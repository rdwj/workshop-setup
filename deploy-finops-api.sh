#!/usr/bin/env bash
set -euo pipefail

CTX="${1:-$(oc config current-context)}"
NS="models-as-a-service"

echo "=== Deploying FinOps API ==="
echo "Context: $CTX"
echo "Namespace: $NS"

# Apply config
oc apply -f finops-api/manifests/config.yaml --context="$CTX"

# Apply deployment, service, route, servicemonitor
oc apply -f finops-api/manifests/deployment.yaml --context="$CTX"

echo ""
echo "Waiting for rollout..."
oc rollout status deployment/finops-api -n "$NS" --context="$CTX" --timeout=120s

ROUTE=$(oc get route finops-api -n "$NS" --context="$CTX" -o jsonpath='{.spec.host}' 2>/dev/null)

echo ""
echo "=== FinOps API Ready ==="
echo "Dashboard: https://$ROUTE/"
echo "API:       https://$ROUTE/api/v1/usage"
echo "Metrics:   https://$ROUTE/metrics"
