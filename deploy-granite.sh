#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="granite-model"
DEPLOYMENT="granite-3-3-8b-instruct"
DEPLOY_TIMEOUT=900
DEPLOY_INTERVAL=15

wait_for() {
  local desc="$1" timeout="$2" interval="$3"
  shift 3
  local elapsed=0
  until eval "$@" 2>/dev/null; do
    if [ "$elapsed" -ge "$timeout" ]; then
      echo "[FAIL] $desc (timed out after ${timeout}s)"
      return 1
    fi
    echo "  Waiting: $desc... (${elapsed}s/${timeout}s)"
    sleep "$interval"
    elapsed=$((elapsed + interval))
  done
  echo "[PASS] $desc"
}

echo "Deploying RedHatAI/granite-3.3-8b-instruct via vLLM..."
oc apply -f model/granite-llm.yaml

wait_for "Deployment $DEPLOYMENT rollout" "$DEPLOY_TIMEOUT" "$DEPLOY_INTERVAL" \
  "oc rollout status deployment/$DEPLOYMENT -n $NAMESPACE --timeout=10s"

ROUTE_HOST=$(oc get route "$DEPLOYMENT" -n "$NAMESPACE" -o jsonpath='{.spec.host}')
echo "Route: https://$ROUTE_HOST"

echo "Testing chat completions endpoint..."
curl -s "https://$ROUTE_HOST/v1/chat/completions" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "RedHatAI/granite-3.3-8b-instruct",
    "messages": [{"role": "user", "content": "What is OpenShift AI in one sentence?"}],
    "max_tokens": 100
  }' | head -c 500
echo

echo "Granite LLM endpoint: https://$ROUTE_HOST"
