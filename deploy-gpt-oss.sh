#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="gpt-oss-model"
DEPLOYMENT="gpt-oss-20b"
DEPLOY_TIMEOUT=1800
DEPLOY_INTERVAL=30

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

echo "Deploying RedHatAI/gpt-oss-20b with EAGLE3 speculative decoding..."
oc apply -f model/gpt-oss-20b.yaml

echo "Waiting for deployment rollout (model + speculator download may take 10+ minutes on first boot)..."
wait_for "Deployment $DEPLOYMENT rollout" "$DEPLOY_TIMEOUT" "$DEPLOY_INTERVAL" \
  "oc rollout status deployment/$DEPLOYMENT -n $NAMESPACE --timeout=10s"

ROUTE_HOST=$(oc get route "$DEPLOYMENT" -n "$NAMESPACE" -o jsonpath='{.spec.host}')
echo "Route: https://$ROUTE_HOST"

echo "Testing chat completions endpoint..."
curl -s "https://$ROUTE_HOST/v1/chat/completions" \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "RedHatAI/gpt-oss-20b",
    "messages": [{"role": "user", "content": "Hello, what model are you?"}],
    "max_tokens": 100
  }' | head -c 500
echo

echo "GPT-OSS-20B endpoint: https://$ROUTE_HOST"
