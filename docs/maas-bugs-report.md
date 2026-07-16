# MaaS + FinOps Workshop — Bug Report

**Cluster**: cluster-w9l9r (OCP 4.20.24, RHOAI 3.4)
**Date**: 2026-06-16
**Reporter**: rdwj

## Bug 1: Gateway OOMKilled when creating multiple MaaS subscriptions

**Severity**: High — blocks multi-tenant FinOps demo

**Symptoms**:
- After creating 3-4 MaaS subscriptions via the RHOAI dashboard, the RHOAI dashboard becomes unresponsive (spinner, error screens)
- The dashboard pods themselves remain Running (9/9), but the underlying gateway pods crash

**Root cause**: Both Envoy gateway pods OOMKilled:
```
data-science-gateway-data-science-gateway-class-87dd79cdb-bt5x8   0/1   OOMKilled
maas-default-gateway-data-science-gateway-class-d4d7b7b88-blsxs   0/1   OOMKilled
```

Each MaaS subscription creates:
- A `MaaSAuthPolicy` → which creates a Kuadrant `AuthPolicy`
- An `AuthConfig` in kuadrant-system (with Rego policies, metadata HTTP calls, response processing)
- A `TokenRateLimitPolicy` → which creates a Kuadrant `RateLimitPolicy`
- Wasm filter configuration pushed to the Envoy gateway

The cumulative wasm plugin configurations (including inline Rego, HTTP call specs, and caching configs) exceed the gateway pod's memory limits. The wasm remote code fetch mechanism is also flagged as unstable in the logs:
```
envoy wasm: Wasm remote code fetch is unstable and may cause a crash
```

**Reproduction**:
1. Deploy MaaS with a model (gpt-oss-20b via catalog)
2. Create 3+ subscriptions with different owners
3. Gateway pods OOMKill within minutes

**Workaround**: Increase gateway pod memory limits, or limit to 1-2 subscriptions.

**Affected components**: 
- `data-science-gateway-data-science-gateway-class` (Deployment in openshift-ingress)
- `maas-default-gateway-data-science-gateway-class` (Deployment in openshift-ingress)

---

## Bug 2: Authorino cannot reach MaaS API for API key validation (TLS)

**Severity**: High — API key auth completely broken without fix

**Symptoms**: All MaaS API key requests return 403. Authorino debug logs show:
```
cannot fetch metadata: tls: failed to verify certificate: x509: certificate signed by unknown authority
```

**Root cause**: The MaaS setup playbook configures Authorino with env vars pointing to the OpenShift service CA bundle:
```
SSL_CERT_FILE=/etc/ssl/certs/openshift-service-ca/service-ca-bundle.crt
```
But the corresponding volume mount is NOT configured in the Authorino CR. The `spec.volumes` field is empty (`{}`), so the CA file doesn't exist in the container.

**Fix applied**:
```bash
oc patch authorino authorino -n kuadrant-system --type=merge -p '{
  "spec": {
    "volumes": {
      "items": [{
        "name": "openshift-service-ca",
        "configMaps": ["openshift-service-ca.crt"],
        "mountPath": "/etc/ssl/certs/openshift-service-ca",
        "items": [{"key": "service-ca.crt", "path": "service-ca-bundle.crt"}]
      }]
    }
  }
}'
```

**Note**: This fix is needed on any cluster where the Authorino instance in `kuadrant-system` is separate from the one in `authorino` namespace. The `maas-setup.yml` playbook patches the `authorino` namespace instance but not the `kuadrant-system` one.

---

## Bug 3: RHOAI Dashboard frontend crash on subscription operations

**Severity**: Medium — UI becomes unresponsive

**Symptoms**: Creating or deleting subscriptions sometimes causes the RHOAI dashboard to show a white screen or error page. The dashboard pods remain Running — this is a frontend JavaScript error, not a backend crash.

**Likely cause**: The frontend makes API calls to the MaaS API through the gateway. When the gateway is OOMKilled (Bug 1) or restarting, the frontend's HTTP requests fail and the error handling doesn't gracefully degrade.

**Workaround**: Wait 1-2 minutes for the gateway to restart, then refresh the page.

---

## Bug 4: MaaS API key page returns 500 ("Missing X-MaaS-Username")

**Severity**: Medium — API key management broken

**Symptoms**: Navigating to Settings → API Keys shows "Error loading components". MaaS API logs:
```
Missing or empty username header X-MaaS-Username
POST "/v1/api-keys/search" → 500
```

**Root cause**: When the Authorino CA bundle is missing (Bug 2), the API key validation metadata call fails. Authorino can't resolve the user identity from the API key, so it doesn't inject the `X-MaaS-Username` response header. The MaaS API then receives the request without the username header and returns 500.

**Fix**: Same as Bug 2 — mount the service CA bundle in Authorino.

---

## Bug 5: LLMInferenceService dual-container GPU contention

**Severity**: Medium — affects programmatic model deployment

**Symptoms**: When deploying models via `LLMInferenceService` with custom container specs (command/args override), vLLM crashes with:
```
ValueError: Free memory on device (14.05/44.39 GiB) on startup
```

**Root cause**: The LLMInferenceService controller injects a `main` container that runs `vllm serve`. If the user also specifies a `kserve-container` with a vLLM command, there are TWO vLLM processes on the same GPU, each loading the model. GPU memory is consumed 2x.

**Correct approach**: Don't override `command`/`args`. Pass tuning parameters via `VLLM_ADDITIONAL_ARGS` env var. However, env vars set on `kserve-container` in the LLMInferenceService spec do NOT propagate to the controller-injected `main` container. The only reliable way to set vLLM args is through the RHOAI dashboard's "Runtime arguments" field.

---

## Bug 6: Gateway OOMKill threshold — 3+ subscriptions exceeds 1Gi

**Severity**: High

**Symptoms**: Gateway pods OOMKill when 3 or more MaaS subscriptions exist. With 1 subscription and 1Gi memory limit, the gateway runs fine. Each additional subscription adds wasm filter configuration (AuthConfig + RateLimitPolicy + Rego policies) that increases memory consumption beyond the 1Gi default.

**Data**:
- 1 subscription: gateway stable at 1Gi
- 3 subscriptions: OOMKilled
- MaaS gateway (`maas-default-gateway`) can be patched to 2Gi since it's not controller-reverted
- Data-science gateway is controller-managed by RHOAI and reverts memory patches

**Workaround**: Manually patch the MaaS gateway deployment to 2Gi. The data-science gateway needs a fix at the GatewayClass or RHOAI operator level.

---

## Bug 7: API Keys page broken on clusters with External OIDC + MCP AuthPolicies

**Severity**: Medium-High

**Symptoms**: RHOAI Dashboard → Settings → API Keys shows "Error loading components" with 500 error.

**Root cause**: The API key management page routes through the data-science gateway (`rh-ai.apps...`), which has MCP-oriented AuthPolicies that validate Keycloak JWTs but do NOT inject the `X-MaaS-Username` response header that the MaaS API requires. The MaaS inference gateway has its own AuthPolicy that handles this, but the dashboard route uses a different gateway.

**Workaround**: Create API keys via `oc` CLI or use pre-existing keys.

---

## Bug 8: MaaS API Key Management Endpoints Return 404

**Severity**: High — blocks per-user token metering validation

**Symptoms**: Both the RHOAI dashboard API keys page and the MaaS API programmatic endpoints (`/api-keys`, `/maas-api/api-keys`) return 404. Every path attempted returns 404: `/api-keys`, `/api/v1/api-keys`, `/maas-api/api-keys`.

**Environment**:
- The MaaS API HTTPRoute exists (`maas-api-route` in `redhat-ods-applications`) with path `/maas-api` → URL rewrite to `/` on the `maas-api` service (port 8443)
- The service is running: `maas-api-59d9d686b8-lcvqj`, 1/1 Running, 4+ days uptime
- RHOAI 3.4, MaaS controller running in `redhat-ods-applications`, cluster-w9l9r

**Root cause**: The 404 from the RHOAI dashboard is a frontend routing issue. The dashboard routes through the data-science gateway which doesn't expose the MaaS API key endpoints. However, the MaaS API backend itself works correctly — the internal endpoint `/v1/api-keys` responds successfully when called directly from inside the pod with the proper headers.

**Findings**:
- The MaaS API internal endpoint `/v1/api-keys` works when called directly from inside the pod with correct headers
- Required headers: `X-MaaS-Username: <username>`, `X-MaaS-Group: ["system:authenticated"]` (must be JSON array)
- Required body fields: `name`, `subscriptionName`, `subscriptionNamespace`
- The MaaS API `maas-api-route` HTTPRoute has path `/maas-api` → rewrite to `/`, but the dashboard doesn't use this route
- The backend API is functional; only the RHOAI dashboard routing is broken

**Impact**: Cannot create API keys for MaaS subscriptions via the RHOAI dashboard. Without subscription-linked API keys, TRLP token counting doesn't trigger — the `sk-oai-test` key bypasses auth but doesn't link to a subscription.

**Workaround**: Call the MaaS API directly from inside the pod:
```bash
oc exec deploy/maas-api -n redhat-ods-applications -- curl -sk \
  https://localhost:8443/v1/api-keys -X POST \
  -H 'Content-Type: application/json' \
  -H 'X-MaaS-Username: <username>' \
  -H 'X-MaaS-Group: ["system:authenticated"]' \
  -d '{"name":"<key-name>","subscriptionName":"<sub>","subscriptionNamespace":"models-as-a-service"}'
```

---

## Bug 9: TelemetryPolicy Labels Not Surfaced on Prometheus Metrics

**Severity**: Medium-High — per-user Prometheus metrics unavailable

**Symptoms**:
- TelemetryPolicy `finops-telemetry` is `Accepted` and `Enforced` on `maas-default-gateway`
- Labels (userid, subscription, model, cost_center) are correctly wired into EnvoyFilter Wasm `requestData` config
- But neither Limitador's `/metrics` endpoint nor Envoy's `kuadrant_*` stats show the custom labels
- `authorized_hits` and `authorized_calls` only have `limitador_namespace` label
- `kuadrant_hits{}` and `kuadrant_allowed{}` have empty label sets

**Environment**:
- Limitador v2.4.1, Kuadrant 1.4.0, gateway uses `data-science-gateway-class`
- Limitador configured with `--metric-labels-default descriptors[1]`

**Impact**: Per-user token metering data exists in Limitador REST API (`/counters/`) but not in Prometheus, requiring a bridge service to expose the data as Prometheus metrics.

**Workaround**: Built `finops-api` — a FastAPI service that queries Limitador REST API (`/counters/{namespace}`) and exposes per-user token data as Prometheus metrics (`maas_token_usage`, `maas_token_cost_usd`).

---

## Bug 10: TRLP token counting broken — Wasm shim can't persist auth identity across request/response phases

**Severity**: High — per-user token counting completely non-functional

**Symptoms**:
- TokenRateLimitPolicy (TRLP) `maas-trlp-redhataigpt-oss-20b` is Accepted and Enforced
- API key validation succeeds (MaaS API `/internal/v1/api-keys/validate` returns 200 with valid=true, username, subscription)
- Subscription selection succeeds (MaaS API `/internal/v1/subscriptions/select` returns 200 with name, phase=Active)
- Inference requests succeed (200 with token usage in response body)
- But Limitador counters remain empty — no token counting occurs

**Root cause**: The Kuadrant Wasm shim (`kuadrant-wasm-shim`) cannot persist auth identity data from the request phase to the response phase. Gateway proxy logs show:

```
error wasm log kuadrant-wasm-shim: Failed to set attribute map: Set("Map `HttpRequestHeaders` not available in current phase")
error wasm log kuadrant-wasm-shim: Task failed: None
```

The TRLP requires two phases:
1. **Request phase (ratelimit-check-service)**: Evaluates predicate `auth.identity.selected_subscription_key == "models-as-a-service/oss20b2@models-as-a-service/redhataigpt-oss-20b"` and sends `hits_addend: 0` (pre-check only)
2. **Response phase (ratelimit-report-service)**: Reads `responseBodyJSON("/usage/total_tokens")` from the inference response and reports actual token count to Limitador

The Wasm shim attempts to persist `auth.identity.userid` and `auth.identity.selected_subscription_key` (set during request-phase auth) by writing to HTTP request headers. But during the response body processing phase, Envoy does not allow writing to request headers, so the data is lost and the report predicate cannot evaluate.

Additionally, the TelemetryPolicy metric labels (`metrics.labels.userid`, `metrics.labels.subscription`, etc.) fail with:
```
error wasm log kuadrant-wasm-shim: Failed to evaluate message builder: CelError::Resolve { NoSuchKey("organizationId") }
```

**Environment**:
- RHCL 1.4.0 (Kuadrant), Authorino 1.4.0, Limitador 1.4.0
- Service Mesh 3.3.4, RHOAI 3.4
- Gateway: `maas-default-gateway` with `payload-processing` ext_proc (BBR) in filter chain
- The `payload-processing` EnvoyFilter is created by the MaaS controller (`app.kubernetes.io/part-of: models-as-a-service`), so this would affect any MaaS cluster

**Impact**: Per-user token rate limiting is completely non-functional. The TRLP exists and is "Enforced" but never reports token usage to Limitador. Users can consume unlimited tokens despite having rate limits configured.

**Workaround**: Built `finops-api` — a FastAPI bridge that queries Limitador REST API directly. However, since Limitador counters are never populated by the TRLP, finops-api also shows no data. The only source of per-user token data would need to come from parsing vLLM response bodies at a proxy layer outside the broken Wasm pipeline.

**Affected components**:
- `kuadrant-wasm-shim` (Wasm filter in gateway pods)
- `maas-default-gateway-data-science-gateway-class` pod in `openshift-ingress`
- Kuadrant `TokenRateLimitPolicy` CRD

---

## Environment Details

- OpenShift: 4.20.24
- RHOAI: 3.4 (rhods-operator.3.4.0)
- Service Mesh: 3.3.4
- RHCL Operator: 1.4.0
- Authorino: 1.4.0
- Kuadrant: v1 (from RHCL)
- vLLM: registry.redhat.io/rhaiis/vllm-cuda-rhel9:3
- GPU: g6e.4xlarge (NVIDIA L40S, 48GB VRAM)
