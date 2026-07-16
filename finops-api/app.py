"""FinOps API — per-user token cost visibility for OpenShift AI models."""

import asyncio
import collections
import logging
import os
import time
from contextlib import asynccontextmanager
from datetime import datetime, timezone
from pathlib import Path

import httpx
import yaml
from fastapi import FastAPI, Response
from fastapi.responses import HTMLResponse, JSONResponse
from prometheus_client import CollectorRegistry, Gauge, generate_latest

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
logger = logging.getLogger("finops-api")

LIMITADOR_URL = os.getenv("LIMITADOR_URL", "http://limitador-limitador.kuadrant-system.svc:8080")
BILLING_PATH = Path(os.getenv("BILLING_CONFIG", "/config/billing.yaml"))
THANOS_URL = os.getenv("THANOS_URL", "https://thanos-querier.openshift-monitoring.svc:9091")
SA_TOKEN_PATH = Path("/var/run/secrets/kubernetes.io/serviceaccount/token")

CONFIG_CACHE_TTL = 60   # seconds
HISTORY_INTERVAL = 30   # seconds between snapshots
HISTORY_MAXLEN = 240    # 2-hour rolling window at 30s intervals
VLLM_CACHE_TTL = 15     # seconds

_config_cache: dict | None = None
_config_loaded_at: float = 0.0
_vllm_cache: dict[str, tuple[float, dict]] = {}  # keyed by model_name or "__aggregate__"

history: collections.deque = collections.deque(maxlen=HISTORY_MAXLEN)
_dashboard_html: str | None = None
_EMPTY_CONFIG = {"gpu_cost_per_hour": 0, "instance_type": "unknown", "namespaces": [], "subscriptions": {}}


def load_billing_config() -> dict:
    global _config_cache, _config_loaded_at
    now = time.monotonic()
    if _config_cache and (now - _config_loaded_at) < CONFIG_CACHE_TTL:
        return _config_cache
    try:
        raw = yaml.safe_load(BILLING_PATH.read_text())
    except Exception as exc:
        logger.error("Failed to load billing config: %s", exc)
        return _config_cache or _EMPTY_CONFIG
    _config_cache = raw
    _config_loaded_at = now
    return raw


def _build_user_lookup(cfg: dict) -> dict[str, tuple[str, str]]:
    """Return {userid: (subscription_name, cost_center)}."""
    lookup: dict[str, tuple[str, str]] = {}
    for sub_name, sub in cfg.get("subscriptions", {}).items():
        if sub_name == "default":
            continue
        for uid in sub.get("users", []):
            lookup[uid] = (sub_name, sub.get("cost_center", "unassigned"))
    return lookup


async def _fetch_counters(namespace: str) -> list[dict]:
    url = f"{LIMITADOR_URL}/counters/{namespace.replace('/', '%2F')}"
    try:
        async with httpx.AsyncClient(timeout=5.0) as client:
            resp = await client.get(url)
            resp.raise_for_status()
            return resp.json()
    except Exception as exc:
        logger.error("Limitador query failed for %s: %s", namespace, exc)
        return []


def _extract_userid(counter: dict) -> str | None:
    return next((v for k, v in counter.get("set_variables", {}).items()
                 if "auth.identity.userid" in k), None)


def _prom_model_name(namespace: str) -> str:
    """Derive the Prometheus model_name label from the billing namespace string.

    e.g. "models-as-a-service/redhataigpt-oss-20b-kserve-route" -> "redhataigpt-oss-20b"
    """
    return namespace.split("/")[-1].replace("-kserve-route", "")


async def _fetch_vllm_metrics(model_name: str | None = None) -> dict:
    """Query Thanos for vLLM performance metrics, optionally filtered to a single model.

    When *model_name* is provided the PromQL queries include a
    ``{model_name="<value>"}`` label selector so that results are scoped to
    that specific LLMInferenceService.  When omitted the queries run
    unfiltered (aggregate across all models).

    Results are cached per model_name for VLLM_CACHE_TTL seconds.
    """
    cache_key = model_name or "__aggregate__"
    now = time.monotonic()
    cached_entry = _vllm_cache.get(cache_key)
    if cached_entry and (now - cached_entry[0]) < VLLM_CACHE_TTL:
        return cached_entry[1]

    try:
        token = SA_TOKEN_PATH.read_text().strip()
    except Exception:
        token = ""
    headers = {"Authorization": f"Bearer {token}"} if token else {}

    # Build label selector fragment
    lbl = '{model_name="%s"}' % model_name if model_name else ""

    def _hq(q: float, m: str) -> str:
        return "histogram_quantile(%s, rate(kserve_vllm:%s_bucket%s[10m]))" % (q, m, lbl)

    queries = {
        "prompt_tokens_total": f"kserve_vllm:prompt_tokens_total{lbl}",
        "generation_tokens_total": f"kserve_vllm:generation_tokens_total{lbl}",
        "cached_tokens_total": f"kserve_vllm:prompt_tokens_cached_total{lbl}",
        "kv_cache_usage_pct": f"kserve_vllm:kv_cache_usage_perc{lbl}",
        "requests_running": f"kserve_vllm:num_requests_running{lbl}",
        "requests_waiting": f"kserve_vllm:num_requests_waiting{lbl}",
        "preemptions_total": f"kserve_vllm:num_preemptions_total{lbl}",
        "prefix_cache_hits_total": f"kserve_vllm:prefix_cache_hits_total{lbl}",
        "prefix_cache_queries_total": f"kserve_vllm:prefix_cache_queries_total{lbl}",
        "ttft_p50_seconds": _hq(0.5, "time_to_first_token_seconds"),
        "ttft_p95_seconds": _hq(0.95, "time_to_first_token_seconds"),
        "tpot_p50_seconds": _hq(0.5, "inter_token_latency_seconds"),
        "prefill_time_p50_seconds": _hq(0.5, "request_prefill_time_seconds"),
        "decode_time_p50_seconds": _hq(0.5, "request_decode_time_seconds"),
    }

    result = {}
    try:
        async with httpx.AsyncClient(timeout=5.0, verify=False) as client:
            for key, query in queries.items():
                resp = await client.get(
                    f"{THANOS_URL}/api/v1/query", params={"query": query}, headers=headers,
                )
                if resp.status_code == 200:
                    data = resp.json()
                    values = data.get("data", {}).get("result", [])
                    if values:
                        result[key] = float(values[0]["value"][1])
    except Exception as exc:
        logger.error("Thanos query failed (model=%s): %s", model_name or "aggregate", exc)

    prompt = result.get("prompt_tokens_total", 0)
    gen = result.get("generation_tokens_total", 0)
    cached = result.get("cached_tokens_total", 0)
    total = prompt + gen

    # Cost rates: when querying per-model, try to find the matching namespace config;
    # for aggregate queries fall back to the first namespace.
    cfg = load_billing_config()
    ns_cfg_match = None
    if model_name:
        for ns_cfg in cfg.get("namespaces", []):
            if _prom_model_name(ns_cfg["namespace"]) == model_name:
                ns_cfg_match = ns_cfg
                break
    if ns_cfg_match is None:
        ns_cfg_match = next(iter(cfg.get("namespaces", [{}])), {})

    cpt_in = ns_cfg_match.get("cost_per_input_token", ns_cfg_match.get("cost_per_token", 0))
    cpt_out = ns_cfg_match.get("cost_per_output_token", ns_cfg_match.get("cost_per_token", 0))
    _ms = lambda k: round(result.get(k, 0) * 1000, 1)  # noqa: E731

    metrics = {
        "prompt_tokens_total": int(prompt), "generation_tokens_total": int(gen),
        "cached_tokens_total": int(cached),
        "cache_hit_rate_pct": round(cached / prompt * 100, 1) if prompt > 0 else 0,
        "prompt_pct": round(prompt / total * 100, 1) if total > 0 else 0,
        "generation_pct": round(gen / total * 100, 1) if total > 0 else 0,
        "ttft_p50_ms": _ms("ttft_p50_seconds"), "ttft_p95_ms": _ms("ttft_p95_seconds"),
        "tpot_p50_ms": _ms("tpot_p50_seconds"),
        "prefill_time_p50_ms": _ms("prefill_time_p50_seconds"),
        "decode_time_p50_ms": _ms("decode_time_p50_seconds"),
        "kv_cache_usage_pct": round(result.get("kv_cache_usage_pct", 0) * 100, 1),
        "requests_running": int(result.get("requests_running", 0)),
        "requests_waiting": int(result.get("requests_waiting", 0)),
        "preemptions_total": int(result.get("preemptions_total", 0)),
        "prefix_cache_hits_total": int(result.get("prefix_cache_hits_total", 0)),
        "prefix_cache_queries_total": int(result.get("prefix_cache_queries_total", 0)),
        "cache_savings_usd": round(cached * cpt_in, 4),
        "self_hosted_usd": round(prompt * cpt_in + gen * cpt_out, 4),
    }
    _vllm_cache[cache_key] = (now, metrics)
    return metrics


async def _gather_usage() -> dict:
    cfg = load_billing_config()
    user_lookup = _build_user_lookup(cfg)
    records = []
    for ns_cfg in cfg.get("namespaces", []):
        namespace = ns_cfg["namespace"]
        model = ns_cfg.get("model", "unknown")
        cost_per_token = ns_cfg.get("cost_per_token", 0)
        counters = await _fetch_counters(namespace)
        for c in counters:
            limit = c.get("limit", {})
            uid = _extract_userid(c)
            if uid is None:
                continue
            max_val = limit.get("max_value", 0)
            remaining = c.get("remaining", 0)
            tokens_used = max_val + (2**64 - remaining) if remaining > max_val else max_val - remaining
            sub_name, cost_center = user_lookup.get(uid, (None, "unassigned"))
            records.append({
                "userid": uid, "model": model,
                "tokens_used": tokens_used, "tokens_remaining": remaining,
                "tokens_limit": max_val,
                "window_seconds": limit.get("seconds", 0),
                "window_remaining_seconds": c.get("expires_in_seconds", 0),
                "cost_usd": round(tokens_used * cost_per_token, 4),
                "cost_center": cost_center, "subscription": sub_name,
            })
    # Per-model vLLM metrics
    vllm_by_model: dict[str, dict] = {}
    for ns_cfg in cfg.get("namespaces", []):
        model = ns_cfg.get("model", "unknown")
        prom_name = _prom_model_name(ns_cfg["namespace"])
        vllm_by_model[model] = await _fetch_vllm_metrics(prom_name)

    # Aggregate (unfiltered) for backward compatibility
    vllm_aggregate = await _fetch_vllm_metrics()

    first_ns = cfg.get("namespaces", [{}])[0] if cfg.get("namespaces") else {}
    cpt = first_ns.get("cost_per_token", 0)
    return {
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "gpu_cost_per_hour": cfg.get("gpu_cost_per_hour", 0),
        "instance_type": cfg.get("instance_type", "unknown"),
        "cost_per_token": cpt,
        "cost_per_input_token": first_ns.get("cost_per_input_token", cpt),
        "cost_per_output_token": first_ns.get("cost_per_output_token", cpt),
        "usage": sorted(records, key=lambda r: r["tokens_used"], reverse=True),
        "vllm_metrics": vllm_aggregate,
        "vllm_metrics_by_model": vllm_by_model,
    }


async def _collect_history():
    """Background task: snapshot usage every HISTORY_INTERVAL seconds."""
    logger.info("History collector started (interval=%ds, maxlen=%d)", HISTORY_INTERVAL, HISTORY_MAXLEN)
    while True:
        try:
            data = await _gather_usage()
            history.append({
                "timestamp": data["timestamp"], "usage": data["usage"],
                "vllm_metrics": data.get("vllm_metrics", {}),
                "vllm_metrics_by_model": data.get("vllm_metrics_by_model", {}),
            })
        except Exception as exc:
            logger.error("History collection error: %s", exc)
        await asyncio.sleep(HISTORY_INTERVAL)


def _load_dashboard_template() -> str:
    global _dashboard_html
    if _dashboard_html is None:
        _dashboard_html = (Path(__file__).parent / "templates" / "dashboard.html").read_text()
    return _dashboard_html

@asynccontextmanager
async def lifespan(app: FastAPI):
    task = asyncio.create_task(_collect_history())
    yield
    task.cancel()

app = FastAPI(title="FinOps API", version="0.3.0", lifespan=lifespan)

@app.get("/healthz")
async def healthz():
    return {"status": "ok"}

@app.get("/api/v1/usage")
async def usage_all():
    return JSONResponse(content=await _gather_usage())

@app.get("/api/v1/usage/history")
async def usage_history():
    return JSONResponse(content={"snapshots": list(history)})

@app.get("/api/v1/usage/{userid}")
async def usage_user(userid: str):
    data = await _gather_usage()
    data["usage"] = [r for r in data["usage"] if r["userid"] == userid]
    return JSONResponse(content=data)

@app.get("/metrics")
async def metrics():
    data = await _gather_usage()
    registry = CollectorRegistry()
    g_used = Gauge("maas_token_usage", "Tokens used", ["userid", "model", "cost_center"], registry=registry)
    g_cost = Gauge("maas_token_cost_usd", "Token cost USD", ["userid", "model", "cost_center"], registry=registry)
    g_limit = Gauge("maas_token_limit", "Token limit", ["userid", "model"], registry=registry)
    g_remaining = Gauge("maas_token_remaining", "Tokens remaining", ["userid", "model"], registry=registry)
    for r in data["usage"]:
        labels = [r["userid"], r["model"], r["cost_center"]]
        g_used.labels(*labels).set(r["tokens_used"])
        g_cost.labels(*labels).set(r["cost_usd"])
        g_limit.labels(r["userid"], r["model"]).set(r["tokens_limit"])
        g_remaining.labels(r["userid"], r["model"]).set(r["tokens_remaining"])
    vllm = data.get("vllm_metrics", {})
    for name, desc in [
        ("cache_hit_rate_pct", "KV cache hit rate %"),
        ("prompt_tokens_total", "Total prompt tokens"),
        ("generation_tokens_total", "Total generation tokens"),
        ("ttft_p50_ms", "TTFT P50 ms"), ("ttft_p95_ms", "TTFT P95 ms"),
        ("tpot_p50_ms", "Inter-token latency P50 ms"),
        ("prefill_time_p50_ms", "Prefill time P50 ms"),
        ("decode_time_p50_ms", "Decode time P50 ms"),
        ("kv_cache_usage_pct", "KV cache usage %"),
        ("requests_running", "Requests running"), ("requests_waiting", "Requests waiting"),
        ("preemptions_total", "Preemptions total"),
        ("self_hosted_usd", "Self-hosted cost USD"),
        ("openai_equivalent_usd", "OpenAI equivalent cost USD"),
    ]:
        Gauge(f"maas_vllm_{name}", desc, registry=registry).set(vllm.get(name, 0))
    return Response(content=generate_latest(registry), media_type="text/plain; version=0.0.4")

@app.get("/", response_class=HTMLResponse)
async def dashboard():
    return HTMLResponse(content=_load_dashboard_template())
