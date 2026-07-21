#!/usr/bin/env bash
set -euo pipefail

# Usage: setup-rhoai.sh [--context <name>]
# Sets up RHOAI (without GPU) on an existing OpenShift cluster.

# --- Argument parsing ---
CONTEXT=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --context) CONTEXT="$2"; shift 2 ;;
    --context=*) CONTEXT="${1#*=}"; shift ;;
    *) echo "Unknown argument: $1" >&2; echo "Usage: setup-rhoai.sh [--context <name>]" >&2; exit 1 ;;
  esac
done

if [ -z "$CONTEXT" ]; then
  CONTEXT="$(oc config current-context 2>/dev/null || true)"
  if [ -z "$CONTEXT" ]; then
    echo "Error: no --context provided and no current context set" >&2
    exit 1
  fi
  echo "No --context specified, using current context: $CONTEXT"
fi

OC="oc --context $CONTEXT"

if ! $OC whoami &>/dev/null; then
  echo "Error: cannot reach cluster with context '$CONTEXT'" >&2
  echo "Run 'oc login' or check your kubeconfig." >&2
  exit 1
fi
echo "Using context: $CONTEXT ($(${OC} whoami) @ $(${OC} whoami --show-server 2>/dev/null))"

# --- Timeout constants (seconds) ---
INSTALLPLAN_TIMEOUT=300
CSV_TIMEOUT=600
DSC_TIMEOUT=600
NFD_TIMEOUT=300

# --- Helper functions ---
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

# --- Auth, namespaces, operators ---
$OC apply -f auth/

# Apply only the namespaces needed for RHOAI (not nvidia-gpu-operator).
$OC apply -f - <<'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: redhat-ods-operator
---
apiVersion: v1
kind: Namespace
metadata:
  name: openshift-nfd
---
apiVersion: v1
kind: Namespace
metadata:
  name: authorino
EOF

$OC apply -f operators/nfd-operator.yaml
$OC apply -f operators/rhoai-operator.yaml
$OC apply -f operators/web-terminal-operator.yaml
$OC apply -f operators/authorino-operator.yaml

# --- Wait for install plans and approve them ---
OPERATOR_NAMESPACES="openshift-nfd redhat-ods-operator"

for ns in $OPERATOR_NAMESPACES; do
  wait_for "InstallPlan in $ns" "$INSTALLPLAN_TIMEOUT" 10 \
    ''$OC' get installplan -n "'"$ns"'" --no-headers 2>/dev/null | grep -q "Manual"'
done

echo "Approving install plans..."
for ns in $OPERATOR_NAMESPACES; do
  PLAN=$($OC get installplan -n "$ns" -o jsonpath='{range .items[?(@.spec.approved==false)]}{.metadata.name}{end}')
  if [ -z "$PLAN" ]; then
    echo "  No unapproved install plan found in $ns, skipping"
    continue
  fi
  $OC patch installplan "$PLAN" -n "$ns" --type merge -p '{"spec":{"approved":true}}'
done

# Authorino uses Manual approval and installs into openshift-operators
# (shared with other operators). Look up its install plan via the subscription
# to avoid accidentally approving an unrelated plan.
wait_for "Authorino InstallPlan in openshift-operators" "$INSTALLPLAN_TIMEOUT" 10 \
  ''$OC' get subscription authorino-operator -n openshift-operators -o jsonpath="{.status.installPlanRef.name}" 2>/dev/null | grep -q "install-"'

AUTHORINO_PLAN=$($OC get subscription authorino-operator -n openshift-operators \
  -o jsonpath='{.status.installPlanRef.name}')
PLAN_APPROVED=$($OC get installplan "$AUTHORINO_PLAN" -n openshift-operators \
  -o jsonpath='{.spec.approved}' 2>/dev/null)
if [ "$PLAN_APPROVED" = "false" ]; then
  $OC patch installplan "$AUTHORINO_PLAN" -n openshift-operators --type merge -p '{"spec":{"approved":true}}'
else
  echo "  Authorino install plan $AUTHORINO_PLAN already approved, skipping"
fi

# --- Checkpoint: Verify operator CSVs ---
wait_for "NFD operator Succeeded in openshift-nfd" "$CSV_TIMEOUT" 15 \
  ''$OC' get csv -n openshift-nfd --no-headers 2>/dev/null | grep "nfd\." | grep -q "Succeeded"'

wait_for "RHOAI operator Succeeded in redhat-ods-operator" "$CSV_TIMEOUT" 15 \
  ''$OC' get csv -n redhat-ods-operator --no-headers 2>/dev/null | grep "rhods-operator" | grep -q "Succeeded"'

wait_for "Web Terminal operator Succeeded" "$CSV_TIMEOUT" 15 \
  ''$OC' get csv -n openshift-operators --no-headers 2>/dev/null | grep "web-terminal" | grep -q "Succeeded"'

wait_for "Authorino operator Succeeded in openshift-operators" "$CSV_TIMEOUT" 15 \
  ''$OC' get csv -n openshift-operators --no-headers 2>/dev/null | grep "authorino-operator" | grep -q "Succeeded"'

# --- Apply operands ---
$OC apply -f operands/

# --- Verify operands ---
wait_for "NFD instance Available" "$NFD_TIMEOUT" 15 \
  '[ "$('$OC' get nodefeaturediscovery nfd-instance -n openshift-nfd -o jsonpath="{.status.conditions[?(@.type==\"Available\")].status}" 2>/dev/null)" = "True" ]'

wait_for "NFD labels present on nodes" "$NFD_TIMEOUT" 15 \
  ''$OC' get nodes -o jsonpath="{range .items[*]}{.metadata.labels}" 2>/dev/null | grep -q "feature.node.kubernetes.io"'

wait_for "DataScienceCluster default-dsc Ready" "$DSC_TIMEOUT" 15 \
  '[ "$('$OC' get datasciencecluster default-dsc -o jsonpath="{.status.conditions[?(@.type==\"Ready\")].status}" 2>/dev/null)" = "True" ]'

wait_for "Authorino instance ready" "$DSC_TIMEOUT" 15 \
  '[ "$('$OC' get deployment authorino -n authorino -o jsonpath="{.status.readyReplicas}" 2>/dev/null)" = "1" ]'

echo ""
echo "=== RHOAI setup complete ==="
