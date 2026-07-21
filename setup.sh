#!/usr/bin/env bash
set -euo pipefail

# Usage: setup.sh [--context <name>]
# Sets up a workshop cluster with GPU, NFD, NVIDIA GPU operator, and RHOAI.

# --- Argument parsing ---
CONTEXT=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --context) CONTEXT="$2"; shift 2 ;;
    --context=*) CONTEXT="${1#*=}"; shift ;;
    *) echo "Unknown argument: $1" >&2; echo "Usage: setup.sh [--context <name>]" >&2; exit 1 ;;
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

# Verify connectivity
if ! $OC whoami &>/dev/null; then
  echo "Error: cannot reach cluster with context '$CONTEXT'" >&2
  echo "Run 'oc login' or check your kubeconfig." >&2
  exit 1
fi
echo "Using context: $CONTEXT ($(${OC} whoami) @ $(${OC} whoami --show-server 2>/dev/null))"

# --- Timeout constants (seconds) ---
MACHINESET_TIMEOUT=30
INSTALLPLAN_TIMEOUT=300
CSV_TIMEOUT=600
DSC_TIMEOUT=600
NFD_TIMEOUT=300
CLUSTERPOLICY_TIMEOUT=600
GPU_NODE_TIMEOUT=900

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

# --- Set up the GPU machineset ---
MACHINESET=$($OC get machinesets -n openshift-machine-api -o name | awk 'NR==1')
$OC get -n openshift-machine-api "$MACHINESET" -o yaml > scratch/machineset.yaml
cp scratch/machineset.yaml scratch/gpu-machineset.yaml

yq -i 'del(.status) | del(.metadata.uid) | del(.metadata.creationTimestamp) | del(.metadata.generation) | del(.metadata.resourceVersion)' scratch/gpu-machineset.yaml
MACHINESET_NAME="gpu-$(yq '.metadata.name' scratch/gpu-machineset.yaml)"
yq -i ".metadata.name = \"$MACHINESET_NAME\" | .spec.selector.matchLabels.\"machine.openshift.io/cluster-api-machineset\" = \"$MACHINESET_NAME\" | .spec.template.metadata.labels.\"machine.openshift.io/cluster-api-machineset\" = \"$MACHINESET_NAME\"" scratch/gpu-machineset.yaml
yq -i ".spec.template.spec.providerSpec.value.blockDevices[0].ebs.volumeSize = 200" scratch/gpu-machineset.yaml
yq -i ".spec.template.spec.providerSpec.value.instanceType = \"g6e.4xlarge\"" scratch/gpu-machineset.yaml
yq -i ".spec.template.spec.taints = [{\"key\":\"nvidia.com/gpu\",\"value\":\"\",\"effect\":\"NoSchedule\"}]" scratch/gpu-machineset.yaml
yq -i ".spec.replicas = 1" scratch/gpu-machineset.yaml

$OC apply --server-side --force-conflicts -f scratch/gpu-machineset.yaml

# --- Checkpoint 1: Verify GPU machineset ---
wait_for "MachineSet $MACHINESET_NAME has instanceType g6e.4xlarge" "$MACHINESET_TIMEOUT" 5 \
  '[ "$('$OC' get machineset "$MACHINESET_NAME" -n openshift-machine-api -o jsonpath="{.spec.template.spec.providerSpec.value.instanceType}")" = "g6e.4xlarge" ]'

wait_for "MachineSet $MACHINESET_NAME has replicas=1" "$MACHINESET_TIMEOUT" 5 \
  '[ "$('$OC' get machineset "$MACHINESET_NAME" -n openshift-machine-api -o jsonpath="{.spec.replicas}")" = "1" ]'

# --- Auth, namespaces, operators ---
$OC apply -f auth/
$OC apply -f namespaces/
$OC apply -f operators/

# --- Wait for install plans and approve them ---
OPERATOR_NAMESPACES="openshift-nfd nvidia-gpu-operator redhat-ods-operator"

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

# --- Checkpoint 2: Verify operator CSVs ---
wait_for "NFD operator Succeeded in openshift-nfd" "$CSV_TIMEOUT" 15 \
  ''$OC' get csv -n openshift-nfd --no-headers 2>/dev/null | grep "nfd\." | grep -q "Succeeded"'

wait_for "GPU operator Succeeded in nvidia-gpu-operator" "$CSV_TIMEOUT" 15 \
  ''$OC' get csv -n nvidia-gpu-operator --no-headers 2>/dev/null | grep "gpu-operator" | grep -q "Succeeded"'

wait_for "RHOAI operator Succeeded in redhat-ods-operator" "$CSV_TIMEOUT" 15 \
  ''$OC' get csv -n redhat-ods-operator --no-headers 2>/dev/null | grep "rhods-operator" | grep -q "Succeeded"'

wait_for "Web Terminal operator Succeeded" "$CSV_TIMEOUT" 15 \
  ''$OC' get csv -n openshift-operators --no-headers 2>/dev/null | grep "web-terminal" | grep -q "Succeeded"'

# --- Apply operands ---
$OC apply -f operands/

# --- Checkpoint 3: Verify operands ---
wait_for "NFD instance Available" "$NFD_TIMEOUT" 15 \
  '[ "$('$OC' get nodefeaturediscovery nfd-instance -n openshift-nfd -o jsonpath="{.status.conditions[?(@.type==\"Available\")].status}" 2>/dev/null)" = "True" ]'

wait_for "NFD labels present on nodes" "$NFD_TIMEOUT" 15 \
  ''$OC' get nodes -o jsonpath="{range .items[*]}{.metadata.labels}" 2>/dev/null | grep -q "feature.node.kubernetes.io"'

wait_for "DataScienceCluster default-dsc Ready" "$DSC_TIMEOUT" 15 \
  '[ "$('$OC' get datasciencecluster default-dsc -o jsonpath="{.status.conditions[?(@.type==\"Ready\")].status}" 2>/dev/null)" = "True" ]'

# --- Apply GPU operand ---
$OC apply -f gpu-operand/

# --- Checkpoint 4: Verify GPU operand and node ---
wait_for "ClusterPolicy gpu-cluster-policy ready" "$CLUSTERPOLICY_TIMEOUT" 15 \
  '[ "$('$OC' get clusterpolicy gpu-cluster-policy -o jsonpath="{.status.state}" 2>/dev/null)" = "ready" ]'

echo "Waiting for GPU node to come up (this can take up to 15 minutes)..."
GPU_ELAPSED=0
until $OC get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.capacity.nvidia\.com/gpu}{"\n"}{end}' 2>/dev/null | awk '$2 > 0 {found=1} END {exit !found}'; do
  if [ "$GPU_ELAPSED" -ge "$GPU_NODE_TIMEOUT" ]; then
    echo "[FAIL] GPU node with nvidia.com/gpu capacity (timed out after ${GPU_NODE_TIMEOUT}s)"
    exit 1
  fi
  echo "  GPU node not ready yet... (${GPU_ELAPSED}s/${GPU_NODE_TIMEOUT}s)"
  $OC get machines -n openshift-machine-api -l "machine.openshift.io/cluster-api-machineset=$MACHINESET_NAME" \
    -o custom-columns=NAME:.metadata.name,PHASE:.status.phase --no-headers 2>/dev/null | sed 's/^/    /'
  sleep 30
  GPU_ELAPSED=$((GPU_ELAPSED + 30))
done
echo "[PASS] GPU node with nvidia.com/gpu capacity"

echo ""
echo "=== Workshop cluster setup complete ==="
