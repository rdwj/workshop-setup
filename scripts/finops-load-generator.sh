#!/usr/bin/env bash
set -euo pipefail

# Generates realistic traffic through the MaaS inference gateway using
# multiple API keys to simulate different teams. Populates authorized_hits
# metrics for the showback dashboards.
#
# Usage: ./scripts/finops-load-generator.sh [minutes] [context]
#
# Or with manual API keys:
#   KEY_ALPHA=... KEY_BRAVO=... KEY_CHARLIE=... ./scripts/finops-load-generator.sh
#
# Prerequisites:
#   - Models serving and MaaSModelRefs Ready
#   - Subscriptions created (run finops-setup-test-users.sh first)
#   - API keys from RHOAI dashboard or env vars

DURATION_MIN="${1:-15}"
CTX="${2:-$(oc config current-context)}"
DURATION_SEC=$((DURATION_MIN * 60))

CLUSTER_DOMAIN=$(oc get ingress.config.openshift.io cluster --context="$CTX" \
  -o jsonpath='{.spec.domain}' 2>/dev/null)
INFERENCE_URL="https://inference.maas.${CLUSTER_DOMAIN}"

echo "=== FinOps Load Generator ==="
echo "Inference URL: $INFERENCE_URL"
echo "Duration: ${DURATION_MIN} minutes"
echo ""

# Use env vars for API keys, or prompt
KEY_ALPHA="${KEY_ALPHA:-}"
KEY_BRAVO="${KEY_BRAVO:-}"
KEY_CHARLIE="${KEY_CHARLIE:-}"

if [[ -z "$KEY_ALPHA" ]]; then
  echo "API keys not set. Provide them as environment variables:"
  echo "  export KEY_ALPHA=<team-alpha api key>"
  echo "  export KEY_BRAVO=<team-bravo api key>"
  echo "  export KEY_CHARLIE=<team-charlie api key>"
  echo ""
  echo "Get keys from: RHOAI Dashboard → Settings → Subscriptions → API Keys"
  exit 1
fi

echo "API keys:"
echo "  team-alpha:   ${KEY_ALPHA:0:8}..."
echo "  team-bravo:   ${KEY_BRAVO:0:8}..."
echo "  team-charlie: ${KEY_CHARLIE:0:8}..."
echo ""

PROMPTS_DS=(
  "Analyze quarterly financial data and identify the top 3 cost reduction opportunities."
  "Write a risk assessment for migrating ML workloads to managed GPU cloud."
  "How do transformer attention mechanisms affect inference cost scaling?"
  "Compare TCO of self-hosted GPU inference vs cloud API for 10M tokens per day."
)

PROMPTS_ENG=(
  "Write a Python function implementing exponential backoff with jitter."
  "Explain horizontal pod autoscaling based on custom Prometheus metrics."
  "Generate a Makefile for a Go microservice with build, test, and container targets."
  "Write a bash script to rotate Kubernetes secrets without downtime."
)

PROMPTS_PM=(
  "List 3 benefits of a unified AI model gateway for enterprise customers."
  "Draft a one-paragraph Q2 AI infrastructure cost summary for executives."
  "What metrics should a FinOps dashboard show for AI cost management?"
  "Explain chargeback vs showback for internal AI platform usage."
)

MODELS=("gpt-oss-20b" "nemotron-14b")

declare -A CNT
for t in alpha bravo charlie; do for m in gpt nem; do CNT[${t}-${m}]=0; done; done
ERRORS=0
TOTAL=0

send_req() {
  local key=$1 model=$2 prompt=$3 max_tok=${4:-200}
  curl -s -o /dev/null -w "%{http_code}" --max-time 60 \
    -X POST "${INFERENCE_URL}/v1/chat/completions" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${key}" \
    -d "{\"model\":\"${model}\",\"messages\":[{\"role\":\"user\",\"content\":\"${prompt}\"}],\"max_tokens\":${max_tok},\"temperature\":0.7}" \
    2>/dev/null || echo "000"
}

START=$(date +%s)
END=$((START + DURATION_SEC))
LAST_RPT=$START

echo "Starting at $(date)"
echo ""

while [[ $(date +%s) -lt $END ]]; do
  P=$((RANDOM % 4))

  # Team Alpha: 70% gpt-oss, 30% nemotron
  if [[ $((RANDOM % 10)) -lt 7 ]]; then M="gpt-oss-20b"; K="alpha-gpt"; else M="nemotron-14b"; K="alpha-nem"; fi
  send_req "$KEY_ALPHA" "$M" "${PROMPTS_DS[$P]}" 300 > /dev/null &
  CNT[$K]=$((${CNT[$K]} + 1)); TOTAL=$((TOTAL + 1))
  sleep $((RANDOM % 2 + 1))

  # Team Bravo: 80% nemotron, 20% gpt-oss
  P=$((RANDOM % 4))
  if [[ $((RANDOM % 5)) -lt 4 ]]; then M="nemotron-14b"; K="bravo-nem"; else M="gpt-oss-20b"; K="bravo-gpt"; fi
  send_req "$KEY_BRAVO" "$M" "${PROMPTS_ENG[$P]}" 250 > /dev/null &
  CNT[$K]=$((${CNT[$K]} + 1)); TOTAL=$((TOTAL + 1))
  sleep $((RANDOM % 2 + 1))

  # Team Charlie: 50/50, lower volume
  P=$((RANDOM % 4))
  M="${MODELS[$((RANDOM % 2))]}"; if [[ "$M" == "gpt-oss-20b" ]]; then K="charlie-gpt"; else K="charlie-nem"; fi
  send_req "$KEY_CHARLIE" "$M" "${PROMPTS_PM[$P]}" 150 > /dev/null &
  CNT[$K]=$((${CNT[$K]} + 1)); TOTAL=$((TOTAL + 1))
  sleep $((RANDOM % 3 + 2))

  NOW=$(date +%s)
  if [[ $((NOW - LAST_RPT)) -ge 30 ]]; then
    EL=$(( (NOW - START) / 60 )); RM=$(( (END - NOW) / 60 ))
    echo "[${EL}m/${DURATION_MIN}m] total=$TOTAL | alpha: g=${CNT[alpha-gpt]} n=${CNT[alpha-nem]} | bravo: g=${CNT[bravo-gpt]} n=${CNT[bravo-nem]} | charlie: g=${CNT[charlie-gpt]} n=${CNT[charlie-nem]}"
    LAST_RPT=$NOW
  fi
done

wait 2>/dev/null || true

echo ""
echo "=== Complete ==="
echo "Total: $TOTAL requests in ${DURATION_MIN} minutes"
echo "  Alpha (Data Sci): gpt=${CNT[alpha-gpt]} nem=${CNT[alpha-nem]}"
echo "  Bravo (Eng):      gpt=${CNT[bravo-gpt]} nem=${CNT[bravo-nem]}"
echo "  Charlie (PM):     gpt=${CNT[charlie-gpt]} nem=${CNT[charlie-nem]}"
echo ""
echo "Dashboards: RHOAI → Gen AI Studio → Usage"
echo "Queries:    sum by (user) (increase(authorized_hits[1h]))"
