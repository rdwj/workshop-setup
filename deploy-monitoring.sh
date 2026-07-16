#!/usr/bin/env bash
set -euo pipefail

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

echo "=== Deploying vLLM + GPU monitoring stack ==="

# Step 1: Enable user workload monitoring
echo "Enabling user workload monitoring..."
oc apply -f - <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: cluster-monitoring-config
  namespace: openshift-monitoring
data:
  config.yaml: |
    enableUserWorkload: true
EOF

wait_for "User workload monitoring Prometheus running" 120 10 \
  'oc get pods -n openshift-user-workload-monitoring --no-headers 2>/dev/null | grep -q "Running"'

# Step 2: Create ServiceMonitors for vLLM endpoints
echo "Creating ServiceMonitors..."
oc apply -f monitoring/servicemonitors.yaml

# Step 3: Deploy Grafana stack (creates namespace, SA, RBAC, deployment, etc.)
echo "Deploying Grafana..."
oc apply -f monitoring/grafana-stack.yaml

# Step 4: Populate the dashboard ConfigMap from the JSON file
# (must come AFTER grafana-stack.yaml so the namespace exists, and must not be
# in grafana-stack.yaml or it would overwrite with empty data on re-apply)
echo "Creating Grafana dashboard ConfigMap from JSON..."
oc create configmap grafana-dashboards \
  --from-file=vllm-gpu.json=monitoring/dashboards/vllm-gpu.json \
  -n grafana --dry-run=client -o yaml | oc apply -f -

wait_for "Grafana pod ready" 180 10 \
  '[ "$(oc get pods -l app=grafana -n grafana -o jsonpath="{.items[0].status.containerStatuses[0].ready}" 2>/dev/null)" = "true" ]'

GRAFANA_HOST=$(oc get route grafana -n grafana -o jsonpath='{.spec.host}')
echo ""
echo "=== Monitoring stack deployed ==="
echo "Grafana: https://$GRAFANA_HOST"
echo "Login:   admin / admin"
echo "Dashboard: https://$GRAFANA_HOST/d/vllm-gpu-dashboard"
