#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="reranker-model"
DEPLOYMENT="ms-marco-minilm-l12-v2"
DEPLOY_TIMEOUT=600
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

echo "Deploying cross-encoder/ms-marco-MiniLM-L12-v2 reranker..."
oc apply -f model/reranker.yaml

wait_for "Deployment $DEPLOYMENT rollout" "$DEPLOY_TIMEOUT" "$DEPLOY_INTERVAL" \
  "oc rollout status deployment/$DEPLOYMENT -n $NAMESPACE --timeout=10s"

ROUTE_HOST=$(oc get route "$DEPLOYMENT" -n "$NAMESPACE" -o jsonpath='{.spec.host}')
echo "Route: https://$ROUTE_HOST"

echo "Testing rerank endpoint..."
curl -s "https://$ROUTE_HOST/rerank" \
  -H 'Content-Type: application/json' \
  -d '{
    "query": "What is machine learning?",
    "texts": [
      "Machine learning is a branch of artificial intelligence.",
      "I had pasta for lunch yesterday.",
      "Neural networks learn patterns from training data."
    ]
  }'
echo

echo "Reranker endpoint: https://$ROUTE_HOST"
