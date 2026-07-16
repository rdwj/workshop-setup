#!/usr/bin/env bash
set -euo pipefail

# Creates MaaS subscriptions for 3 simulated teams with different cost centers,
# token limits, and billing rates. Run AFTER models are Ready and MaaSModelRefs
# are available.
#
# Usage: ./scripts/finops-setup-test-users.sh [context]

CTX="${1:-$(oc config current-context)}"
NS="models-as-a-service"

# Cost basis: g6e.4xlarge = $1.40/hr
# At ~50K tokens/hr throughput, that's ~$0.000028/token = $0.028/1K tokens
# We'll use $0.03/1K tokens as the self-hosted rate (round up for overhead)
SELF_HOSTED_PER_TOKEN="0.00003"

echo "=== FinOps Test User Setup ==="
echo "Context: $CTX"
echo "Namespace: $NS"
echo ""

echo "--- Checking model availability ---"
MODELS=$(oc get maasmodelref -n "$NS" --context="$CTX" -o jsonpath='{.items[*].metadata.name}' 2>/dev/null)
echo "Available models: $MODELS"
echo ""

echo "--- Creating subscriptions ---"

# Team Alpha: Data Science — heavy gpt-oss-20b users, moderate nemotron
oc apply --context="$CTX" -f - <<'EOF'
apiVersion: maas.opendatahub.io/v1alpha1
kind: MaaSSubscription
metadata:
  name: team-alpha
  namespace: models-as-a-service
spec:
  owner:
    users:
      - alpha-lead
      - alpha-analyst
  modelRefs:
    - name: gpt-oss-20b
      namespace: models-as-a-service
      tokenRateLimits:
        - limit: 500000
          window: "1h"
      billingRate:
        perToken: "0.00003"
    - name: nemotron-14b
      namespace: models-as-a-service
      tokenRateLimits:
        - limit: 200000
          window: "1h"
      billingRate:
        perToken: "0.00003"
  tokenMetadata:
    costCenter: "data-science"
    organizationId: "team-alpha"
    labels:
      department: "research"
      budget-code: "DS-2026"
EOF
echo "  Created: team-alpha (Data Science — 500K gpt-oss / 200K nemotron per hour)"

# Team Bravo: Engineering — heavy nemotron users for code gen
oc apply --context="$CTX" -f - <<'EOF'
apiVersion: maas.opendatahub.io/v1alpha1
kind: MaaSSubscription
metadata:
  name: team-bravo
  namespace: models-as-a-service
spec:
  owner:
    users:
      - bravo-eng1
      - bravo-eng2
  modelRefs:
    - name: gpt-oss-20b
      namespace: models-as-a-service
      tokenRateLimits:
        - limit: 100000
          window: "1h"
      billingRate:
        perToken: "0.00003"
    - name: nemotron-14b
      namespace: models-as-a-service
      tokenRateLimits:
        - limit: 800000
          window: "1h"
      billingRate:
        perToken: "0.00003"
  tokenMetadata:
    costCenter: "engineering"
    organizationId: "team-bravo"
    labels:
      department: "platform-eng"
      budget-code: "ENG-2026"
EOF
echo "  Created: team-bravo (Engineering — 100K gpt-oss / 800K nemotron per hour)"

# Team Charlie: Product — light usage, both models
oc apply --context="$CTX" -f - <<'EOF'
apiVersion: maas.opendatahub.io/v1alpha1
kind: MaaSSubscription
metadata:
  name: team-charlie
  namespace: models-as-a-service
spec:
  owner:
    users:
      - charlie-pm
  modelRefs:
    - name: gpt-oss-20b
      namespace: models-as-a-service
      tokenRateLimits:
        - limit: 50000
          window: "1h"
      billingRate:
        perToken: "0.00003"
    - name: nemotron-14b
      namespace: models-as-a-service
      tokenRateLimits:
        - limit: 50000
          window: "1h"
      billingRate:
        perToken: "0.00003"
  tokenMetadata:
    costCenter: "product"
    organizationId: "team-charlie"
    labels:
      department: "product-mgmt"
      budget-code: "PM-2026"
EOF
echo "  Created: team-charlie (Product — 50K each per hour)"

echo ""
echo "--- Verifying subscriptions ---"
sleep 5
oc get maassubscription -n "$NS" --context="$CTX" \
  -o custom-columns='NAME:.metadata.name,PHASE:.status.phase,MODELS:.spec.modelRefs[*].name' 2>/dev/null

echo ""
echo "=== Test User Setup Complete ==="
echo ""
echo "Cost basis:"
echo "  Self-hosted: \$0.03 per 1K tokens (derived from g6e.4xlarge @ \$1.40/hr)"
echo "  GPU cost: \$1.40/hr per model (on-demand g6e.4xlarge)"
echo ""
echo "Teams:"
echo "  team-alpha  (Data Science)  — heavy gpt-oss, moderate nemotron"
echo "  team-bravo  (Engineering)   — heavy nemotron, light gpt-oss"
echo "  team-charlie (Product)      — light usage both models"
echo ""
echo "Next: Get API keys from the RHOAI dashboard (Settings → Subscriptions)"
echo "  or wait for MaaSSubscription status to show API key secrets."
