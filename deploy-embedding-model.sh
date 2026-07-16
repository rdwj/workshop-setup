#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="embedding-model"
DEPLOY_TIMEOUT=300
DEPLOY_INTERVAL=10

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

echo "Deploying sentence-transformers/all-MiniLM-L6-v2 embedding model..."
oc apply -f model/deployment.yaml

wait_for "Deployment all-minilm-l6-v2 rollout" "$DEPLOY_TIMEOUT" "$DEPLOY_INTERVAL" \
  "oc rollout status deployment/all-minilm-l6-v2 -n $NAMESPACE --timeout=10s"

ROUTE_HOST=$(oc get route all-minilm-l6-v2 -n "$NAMESPACE" -o jsonpath='{.spec.host}')
echo "Route: https://$ROUTE_HOST"

echo "Testing embed endpoint..."
curl -s "https://$ROUTE_HOST/embed" \
  -H 'Content-Type: application/json' \
  -d '{"inputs": "Hello world"}' | head -c 200
echo

echo "Embedding model endpoint: https://$ROUTE_HOST"
