#!/usr/bin/env bash
# vault-verify.sh — Verify Vault JWT auth + credential retrieval
#
# Usage:
#   CTX="default/api-cluster-..." KEYCLOAK_URL="https://..." ./vault-verify.sh

set -euo pipefail

: "${CTX:?Set CTX to your oc/kubectl context}"
: "${KEYCLOAK_URL:?Set KEYCLOAK_URL to the Keycloak base URL}"

VAULT_NS="vault"
VAULT_POD="vault-0"
PASS=0
FAIL=0

check() {
  local label="$1"
  shift
  if "$@"; then
    echo "[PASS] ${label}"
    ((PASS++))
  else
    echo "[FAIL] ${label}"
    ((FAIL++))
  fi
}

echo "=== Vault Deployment Verification ==="

# 1. Pod running
check "Vault pod ready" \
  oc wait "pod/${VAULT_POD}" -n "${VAULT_NS}" --context="${CTX}" \
    --for=condition=Ready --timeout=10s >/dev/null 2>&1

# 2. Vault unsealed
SEAL_STATUS=$(oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
  vault status -format=json 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin)['sealed'])")
check "Vault unsealed" [ "${SEAL_STATUS}" = "False" ]

# 3. Get Keycloak token
ADMIN_USER=$(oc get secret keycloak-initial-admin -n keycloak --context="${CTX}" \
  -o jsonpath='{.data.username}' | base64 -d)
ADMIN_PASS=$(oc get secret keycloak-initial-admin -n keycloak --context="${CTX}" \
  -o jsonpath='{.data.password}' | base64 -d)
ADMIN_TOKEN=$(curl -sk -X POST "${KEYCLOAK_URL}/realms/master/protocol/openid-connect/token" \
  -d "client_id=admin-cli&username=${ADMIN_USER}&password=${ADMIN_PASS}&grant_type=password" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")
CLIENT_UUID=$(curl -sk -H "Authorization: Bearer ${ADMIN_TOKEN}" \
  "${KEYCLOAK_URL}/admin/realms/mcp-gateway/clients?clientId=mcp-gateway" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)[0]['id'])")
CLIENT_SECRET=$(curl -sk -H "Authorization: Bearer ${ADMIN_TOKEN}" \
  "${KEYCLOAK_URL}/admin/realms/mcp-gateway/clients/${CLIENT_UUID}/client-secret" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['value'])")
MCP_TOKEN=$(curl -sk -X POST "${KEYCLOAK_URL}/realms/mcp-gateway/protocol/openid-connect/token" \
  -d "client_id=mcp-gateway&client_secret=${CLIENT_SECRET}&grant_type=client_credentials&scope=openid" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")

check "Keycloak token obtained" [ -n "${MCP_TOKEN}" ]

# 4. Vault JWT login
LOGIN_RESULT=$(oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
  vault write -format=json auth/jwt/login role=mcp-user jwt="${MCP_TOKEN}" 2>&1)
VAULT_CLIENT_TOKEN=$(echo "${LOGIN_RESULT}" | python3 -c \
  "import sys,json; print(json.load(sys.stdin)['auth']['client_token'])" 2>/dev/null || echo "")

check "Vault JWT login" [ -n "${VAULT_CLIENT_TOKEN}" ]

# 5. Read user secret
if [ -n "${VAULT_CLIENT_TOKEN}" ]; then
  USER_SECRET=$(oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
    sh -c "VAULT_TOKEN=${VAULT_CLIENT_TOKEN} vault kv get -format=json \
      mcp/users/service-account-mcp-gateway/github" 2>&1)
  check "User secret readable" echo "${USER_SECRET}" | grep -q "ghp_demo_token"

  # 6. Read shared secret
  SHARED_SECRET=$(oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
    sh -c "VAULT_TOKEN=${VAULT_CLIENT_TOKEN} vault kv get -format=json \
      mcp/shared/defaults" 2>&1)
  check "Shared secret readable" echo "${SHARED_SECRET}" | grep -q "shared-default-key"
else
  echo "[SKIP] User secret (no Vault token)"
  echo "[SKIP] Shared secret (no Vault token)"
  ((FAIL+=2))
fi

echo ""
echo "=== Results: ${PASS} passed, ${FAIL} failed ==="
exit "${FAIL}"
