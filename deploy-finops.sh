#!/usr/bin/env bash
set -euo pipefail

# Usage: ./deploy-finops.sh [context]
# Deploys: Cluster Observability Operator (Perses), cost model, recording rules, dashboards

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CTX="${1:-$(oc config current-context)}"

echo "=== FinOps Stack Deployment ==="
echo "Context: $CTX"
echo ""

# Step 1: Install Cluster Observability Operator
echo "--- Step 1: Installing Cluster Observability Operator ---"
oc apply -f "$SCRIPT_DIR/finops/coo-subscription.yaml" --context="$CTX"

echo "Waiting for COO operator CSV..."
# Wait for the subscription to create an InstallPlan
for i in $(seq 1 40); do
  IP=$(oc get installplan -n cluster-observability-operator --context="$CTX" -o jsonpath='{.items[?(@.status.phase!="Complete")].metadata.name}' 2>/dev/null || true)
  if [[ -n "$IP" ]]; then
    echo "Approving InstallPlan: $IP"
    oc patch installplan "$IP" -n cluster-observability-operator --context="$CTX" --type merge -p '{"spec":{"approved":true}}'
    break
  fi
  echo "  Waiting for InstallPlan... ($i/40)"
  sleep 15
done

# Wait for CSV to succeed
echo "Waiting for COO CSV to succeed..."
for i in $(seq 1 40); do
  PHASE=$(oc get csv -n cluster-observability-operator --context="$CTX" -o jsonpath='{.items[0].status.phase}' 2>/dev/null || true)
  if [[ "$PHASE" == "Succeeded" ]]; then
    echo "COO operator installed successfully"
    break
  fi
  echo "  CSV phase: ${PHASE:-pending} ($i/40)"
  sleep 15
done

# Step 2: Create finops namespace and deploy Perses
echo ""
echo "--- Step 2: Deploying Perses instance ---"
oc apply -f "$SCRIPT_DIR/finops/perses-instance.yaml" --context="$CTX"

echo "Waiting for Perses to reconcile..."
for i in $(seq 1 20); do
  AVAIL=$(oc get perses finops-perses -n finops --context="$CTX" -o jsonpath='{.status.conditions[?(@.type=="Available")].status}' 2>/dev/null || true)
  if [[ "$AVAIL" == "True" ]]; then
    echo "Perses reconciled successfully"
    break
  fi
  echo "  Perses status: ${AVAIL:-pending} ($i/20)"
  sleep 10
done

# Enable Perses dashboards in OpenShift Console via UIPlugin
echo "Enabling Perses dashboards in OpenShift Console..."
oc apply --context="$CTX" -f - <<'UIEOF'
apiVersion: observability.openshift.io/v1alpha1
kind: UIPlugin
metadata:
  name: dashboards
spec:
  type: Dashboards
UIEOF
echo "UIPlugin enabled — dashboards visible at Observe → Dashboards in the console"

# Step 3: Deploy cost model and recording rules
echo ""
echo "--- Step 3: Deploying cost model and Prometheus recording rules ---"
oc apply -f "$SCRIPT_DIR/finops/cost-model.yaml" --context="$CTX"
oc apply -f "$SCRIPT_DIR/finops/prometheus-rules.yaml" --context="$CTX"
echo "Cost model and recording rules deployed"

# Step 4: Deploy Perses dashboards
echo ""
echo "--- Step 4: Deploying FinOps dashboards ---"
for dashboard in "$SCRIPT_DIR"/finops/dashboards/*.yaml; do
  echo "  Applying $(basename "$dashboard")"
  oc apply -f "$dashboard" --context="$CTX"
done
echo "All dashboards deployed"

# Step 5: Print access info
echo ""
echo "=== FinOps Stack Deployment Complete ==="
echo ""

# Try to get the Perses route
PERSES_ROUTE=$(oc get route -n finops --context="$CTX" -o jsonpath='{.items[0].spec.host}' 2>/dev/null || true)
if [[ -n "$PERSES_ROUTE" ]]; then
  echo "Perses Dashboard: https://$PERSES_ROUTE"
else
  echo "Perses Dashboard: Access via OpenShift Console → Observe → Dashboards"
fi

echo ""
echo "Dashboards available:"
echo "  - FinOps Cost Overview"
echo "  - FinOps Chargeback"
echo "  - Model Efficiency"
echo "  - FinOps Executive Summary"
echo ""
echo "Recording rules active:"
echo "  - finops:gpu_cost_per_hour"
echo "  - finops:self_hosted_cost_per_1k_tokens"
echo "  - finops:tokens_per_dollar"
echo "  - finops:estimated_daily_cost"
echo ""
echo "Cost model: g6e.4xlarge @ \$1.40/hr per GPU node"
