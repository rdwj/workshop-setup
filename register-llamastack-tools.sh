#!/usr/bin/env bash
set -euo pipefail

# Register MCP tool groups with a LlamaStack server.
#
# LlamaStack stores tool registrations in-memory, so they are lost on
# pod restart. This script re-registers everything from a YAML config
# file, making it safe to run on every startup (idempotent).
#
# Usage:
#   ./register-llamastack-tools.sh                          # defaults
#   ./register-llamastack-tools.sh -u http://localhost:8321  # explicit URL
#   ./register-llamastack-tools.sh -c config/my-tools.yaml   # custom config
#
# Environment:
#   LLAMASTACK_URL  - Base URL of the LlamaStack server (no trailing slash)
#
# As an init container (example):
#   command: ["/bin/bash", "-c"]
#   args:
#     - |
#       /scripts/register-llamastack-tools.sh \
#         -u http://llama-stack-service:8321 \
#         -c /config/llamastack-tools.yaml
#
# Requires: curl, yq (or python3 as fallback for YAML parsing)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config/llamastack-tools.yaml"
VERIFY_TIMEOUT=30
VERIFY_INTERVAL=2

usage() {
  echo "Usage: $(basename "$0") [-u LLAMASTACK_URL] [-c CONFIG_FILE] [-h]"
  echo ""
  echo "  -u URL     LlamaStack base URL (default: \$LLAMASTACK_URL)"
  echo "  -c FILE    Tool group config file (default: config/llamastack-tools.yaml)"
  echo "  -h         Show this help"
  exit 1
}

while getopts "u:c:h" opt; do
  case $opt in
    u) LLAMASTACK_URL="$OPTARG" ;;
    c) CONFIG_FILE="$OPTARG" ;;
    h) usage ;;
    *) usage ;;
  esac
done

LLAMASTACK_URL="${LLAMASTACK_URL:?Set LLAMASTACK_URL or pass -u}"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "[FAIL] Config file not found: $CONFIG_FILE"
  exit 1
fi

# ---------------------------------------------------------------------------
# YAML parsing — prefer yq, fall back to a minimal python3 one-liner.
# ---------------------------------------------------------------------------
parse_toolgroups() {
  local file="$1"
  if command -v yq &>/dev/null; then
    yq -r '.toolgroups[] | [.toolgroup_id, .provider_id, .mcp_endpoint] | @tsv' "$file"
  elif command -v python3 &>/dev/null; then
    python3 -c "
import yaml, sys
with open(sys.argv[1]) as f:
    for tg in yaml.safe_load(f).get('toolgroups', []):
        print('\t'.join([tg['toolgroup_id'], tg['provider_id'], tg['mcp_endpoint']]))
" "$file"
  else
    echo "[FAIL] Need yq or python3 (with PyYAML) to parse config" >&2
    exit 1
  fi
}

# ---------------------------------------------------------------------------
# Wait helper (matches the pattern used in other deploy-*.sh scripts).
# ---------------------------------------------------------------------------
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

# ---------------------------------------------------------------------------
# Pre-flight: make sure LlamaStack is reachable.
# ---------------------------------------------------------------------------
echo "LlamaStack URL: $LLAMASTACK_URL"
echo "Config file:    $CONFIG_FILE"
echo ""

wait_for "LlamaStack reachable at $LLAMASTACK_URL" "$VERIFY_TIMEOUT" "$VERIFY_INTERVAL" \
  "curl -sf '$LLAMASTACK_URL/v1/toolgroups' >/dev/null"

# ---------------------------------------------------------------------------
# Register each tool group.
# ---------------------------------------------------------------------------
TOTAL=0
OK=0
FAILED=0

while IFS=$'\t' read -r toolgroup_id provider_id mcp_endpoint; do
  TOTAL=$((TOTAL + 1))
  echo "Registering $toolgroup_id -> $mcp_endpoint"

  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "$LLAMASTACK_URL/v1/toolgroups" \
    -H "Content-Type: application/json" \
    -d "$(cat <<PAYLOAD
{
  "toolgroup_id": "$toolgroup_id",
  "provider_id": "$provider_id",
  "mcp_endpoint": {"uri": "$mcp_endpoint"}
}
PAYLOAD
    )")

  if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
    echo "[PASS] $toolgroup_id registered (HTTP $HTTP_CODE)"
    OK=$((OK + 1))
  else
    echo "[FAIL] $toolgroup_id registration returned HTTP $HTTP_CODE"
    FAILED=$((FAILED + 1))
  fi
done < <(parse_toolgroups "$CONFIG_FILE")

# ---------------------------------------------------------------------------
# Verify registrations are visible.
# ---------------------------------------------------------------------------
echo ""
echo "Verifying registrations..."

while IFS=$'\t' read -r toolgroup_id _ _; do
  # The list endpoint returns all tool groups; grep for ours.
  if curl -sf "$LLAMASTACK_URL/v1/toolgroups" | grep -q "$toolgroup_id"; then
    echo "[PASS] $toolgroup_id visible in /v1/toolgroups"
  else
    echo "[FAIL] $toolgroup_id NOT found in /v1/toolgroups listing"
    FAILED=$((FAILED + 1))
    OK=$((OK - 1))
  fi
done < <(parse_toolgroups "$CONFIG_FILE")

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo ""
echo "=== Tool registration complete: $OK/$TOTAL succeeded ==="
if [ "$FAILED" -gt 0 ]; then
  echo "WARNING: $FAILED registration(s) failed"
  exit 1
fi
