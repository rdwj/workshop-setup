#!/usr/bin/env bash
# Generates randomized inference traffic for the FinOps dashboard demo.
# Usage: ./finops-demo-traffic.sh [start|stop|status]
#
# Required env vars:
#   GATEWAY        — MaaS gateway URL (e.g. https://maas.apps.cluster-xxx.opentlc.com)
#   API_KEY_GPT    — API key for the gpt-oss-20b model subscription
#   API_KEY_GRANITE — API key for the granite-8b model subscription

set -euo pipefail

PIDFILE="/tmp/finops-demo-traffic.pid"
LOGFILE="/tmp/finops-demo-traffic.log"

: "${GATEWAY:?Set GATEWAY to the MaaS endpoint URL}"
: "${API_KEY_GPT:?Set API_KEY_GPT}"
: "${API_KEY_GRANITE:?Set API_KEY_GRANITE}"

# Two models with separate API keys (each tied to its subscription)
MODELS=("redhataigpt-oss-20b" "granite-8b-code-instruct")
ENDPOINTS=("/models-as-a-service/redhataigpt-oss-20b/v1/chat/completions" "/models-as-a-service/granite-8b-code-instruct/v1/chat/completions")
API_KEYS=("$API_KEY_GPT" "$API_KEY_GRANITE")

PROMPTS=(
  "Write a detailed technical analysis of how transformer attention mechanisms work, covering multi-head attention, positional encoding, and the relationship between query, key, and value matrices. Include mathematical formulations and explain the computational complexity."
  "Explain the complete history of containerization technology from chroot jails through Docker to Kubernetes, covering namespaces, cgroups, OCI specifications, container runtimes, orchestration patterns, and the evolution of microservices architecture."
  "Write a comprehensive guide to implementing a distributed rate limiting system, covering token bucket algorithms, sliding window counters, consistent hashing for distributed state, Redis-based implementations, and handling edge cases like clock skew and network partitions."
  "Describe the full lifecycle of an HTTP request from a browser to a Kubernetes-hosted application, including DNS resolution, TLS handshake, load balancer routing, ingress controller processing, service mesh sidecar proxying, pod networking, and response path."
  "Write a detailed comparison of GPU architectures for machine learning inference, covering NVIDIA A100 vs H100 vs L40S, memory bandwidth, tensor core generations, sparsity support, multi-instance GPU partitioning, and cost-performance tradeoffs for different model sizes."
  "Explain FinOps principles for cloud-native AI workloads including unit economics of GPU compute, token-based cost attribution, chargeback models for shared inference endpoints, cost anomaly detection, and strategies for optimizing model serving costs across teams."
  "Describe how to build a production observability stack for LLM serving, covering metrics collection with Prometheus, distributed tracing with OpenTelemetry, log aggregation, latency percentile tracking, token throughput monitoring, and SLO-based alerting."
  "Write about the security considerations for multi-tenant model serving platforms including API key management, rate limiting per tenant, data isolation, prompt injection defense, audit logging, RBAC for model access, and compliance with data residency requirements."
)

run_traffic() {
  echo "[$(date -u +%H:%M:%S)] Demo traffic generator started (PID $$)" | tee "$LOGFILE"
  echo "[$(date -u +%H:%M:%S)] Gateway: $GATEWAY" | tee -a "$LOGFILE"
  echo "[$(date -u +%H:%M:%S)] Interval: 5-15s, max_tokens: 1000-5000" | tee -a "$LOGFILE"
  echo "---" >> "$LOGFILE"

  local count=0
  while true; do
    count=$((count + 1))

    # Pick a random model with its API key
    model_idx=$(( RANDOM % ${#MODELS[@]} ))
    MODEL="${MODELS[$model_idx]}"
    ENDPOINT="${ENDPOINTS[$model_idx]}"
    API_KEY="${API_KEYS[$model_idx]}"

    # Weighted random: 40% small (10-100), 30% medium (200-800), 30% large (1500-4000)
    roll=$(( RANDOM % 10 ))
    if [ $roll -lt 4 ]; then
      max_tokens=$(( RANDOM % 91 + 10 ))
    elif [ $roll -lt 7 ]; then
      max_tokens=$(( RANDOM % 601 + 200 ))
    else
      max_tokens=$(( RANDOM % 2501 + 1500 ))
    fi

    # Pick a random prompt with varying cache behavior
    # 40% reuse a fixed system context (high cache hit)
    # 30% use a standard prompt (moderate cache)
    # 30% inject a unique preamble (cache miss — forces recompute)
    cache_roll=$(( RANDOM % 10 ))
    prompt_idx=$(( RANDOM % ${#PROMPTS[@]} ))
    if [ $cache_roll -lt 4 ]; then
      prompt="You are a helpful AI assistant deployed on OpenShift AI. Always be concise and accurate. ${PROMPTS[$prompt_idx]}"
      cache_mode="hit"
    elif [ $cache_roll -lt 7 ]; then
      if [ $max_tokens -lt 100 ]; then
        prompt="Answer in one sentence: what is $((RANDOM % 100))?"
      else
        prompt="${PROMPTS[$prompt_idx]}"
      fi
      cache_mode="partial"
    else
      unique_ctx="Session $(date +%s%N). Request ID $RANDOM-$RANDOM-$RANDOM. Context seed: $(head -c 200 /dev/urandom | base64 | head -c 100). Previous conversation summary: The user asked about topic $RANDOM in area $RANDOM with priority $RANDOM."
      prompt="$unique_ctx Now answer: ${PROMPTS[$prompt_idx]}"
      cache_mode="miss"
    fi

    start_ts=$(date +%s)
    resp=$(curl -sk "$GATEWAY$ENDPOINT" \
      -H "Authorization: Bearer $API_KEY" \
      -H "Content-Type: application/json" \
      -d "{\"model\":\"$MODEL\",\"messages\":[{\"role\":\"user\",\"content\":$(printf '%s' "$prompt" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')}],\"max_tokens\":$max_tokens}" 2>&1)
    end_ts=$(date +%s)
    elapsed=$(( end_ts - start_ts ))

    total_tokens=$(echo "$resp" | python3 -c 'import json,sys
try:
    d=json.load(sys.stdin)
    print(d["usage"]["total_tokens"])
except:
    print("error")' 2>/dev/null)

    echo "[$(date -u +%H:%M:%S)] #$count model=$MODEL max_tokens=$max_tokens total=$total_tokens cache=$cache_mode elapsed=${elapsed}s" | tee -a "$LOGFILE"

    sleep_time=$(( RANDOM % 11 + 5 ))
    sleep "$sleep_time"
  done
}

case "${1:-start}" in
  start)
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo "Already running (PID $(cat "$PIDFILE")). Use 'stop' first or 'status' to check."
      exit 1
    fi
    run_traffic &
    echo $! > "$PIDFILE"
    echo "Started demo traffic generator (PID $!)"
    echo "  Log: tail -f $LOGFILE"
    echo "  Stop: $0 stop"
    ;;
  stop)
    if [ -f "$PIDFILE" ]; then
      pid=$(cat "$PIDFILE")
      if kill -0 "$pid" 2>/dev/null; then
        kill "$pid" 2>/dev/null && echo "Stopped (PID $pid)"
      else
        echo "Process $pid not running"
      fi
      rm -f "$PIDFILE"
    else
      echo "No PID file found. Not running."
    fi
    ;;
  status)
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      pid=$(cat "$PIDFILE")
      echo "Running (PID $pid)"
      echo "Recent log:"
      tail -5 "$LOGFILE" 2>/dev/null
    else
      echo "Not running"
      rm -f "$PIDFILE" 2>/dev/null
    fi
    ;;
  *)
    echo "Usage: $0 [start|stop|status]"
    exit 1
    ;;
esac
