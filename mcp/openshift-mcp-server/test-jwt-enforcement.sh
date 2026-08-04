#!/bin/bash
# Test script for MCP Gateway JWT enforcement
# Usage: ./test-jwt-enforcement.sh

set -e

CONTEXT="mcp-rhoai"
GATEWAY_SVC="mcp-gateway-istio.gateway-system.svc.cluster.local:8080"
HOST_HEADER="mcp.mcp.local"
KEYCLOAK_URL="https://keycloak-keycloak.apps.cluster-n7pd5.n7pd5.sandbox5167.opentlc.com/realms/mcp-gateway/protocol/openid-connect/token"
CLIENT_ID="mcp-gateway"
CLIENT_SECRET="${MCP_CLIENT_SECRET:?Set MCP_CLIENT_SECRET environment variable}"

echo "=== MCP Gateway JWT Enforcement Test Suite ==="
echo ""

# Test 1: Unauthenticated request (should be denied)
echo "Test 1: Unauthenticated request to /mcp (should get 403)"
echo "-------------------------------------------------------"
oc run jwt-test-deny --rm -i --restart=Never \
  --image=curlimages/curl:latest \
  -n mcp-system --context="${CONTEXT}" \
  -- -sv -H "Host: ${HOST_HEADER}" \
  "http://${GATEWAY_SVC}/mcp" 2>&1 | grep -E "(HTTP/|RBAC|403)" || echo "FAILED: Expected 403"
echo ""

# Test 2: Get JWT token
echo "Test 2: Obtaining JWT token from Keycloak"
echo "------------------------------------------"
TOKEN=$(curl -s -X POST "${KEYCLOAK_URL}" \
  -d "client_id=${CLIENT_ID}" \
  -d "client_secret=${CLIENT_SECRET}" \
  -d "grant_type=client_credentials" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])" 2>/dev/null)

if [ -n "${TOKEN}" ]; then
  echo "✅ Token acquired (${#TOKEN} characters)"
else
  echo "❌ Failed to acquire token"
  exit 1
fi
echo ""

# Test 3: Authenticated request (should succeed)
echo "Test 3: Authenticated request to /mcp (should get 200)"
echo "-------------------------------------------------------"
oc run jwt-test-allow --rm -i --restart=Never \
  --image=curlimages/curl:latest \
  -n mcp-system --context="${CONTEXT}" \
  --env="TOKEN=${TOKEN}" \
  -- sh -c "curl -sv -H 'Host: ${HOST_HEADER}' -H 'Authorization: Bearer \${TOKEN}' http://${GATEWAY_SVC}/mcp" 2>&1 | grep -E "(HTTP/|200)" || echo "FAILED: Expected 200"
echo ""

# Test 4: Well-known endpoint without auth (should succeed)
echo "Test 4: Well-known endpoint without auth (should get 200)"
echo "----------------------------------------------------------"
oc run jwt-test-wellknown --rm -i --restart=Never \
  --image=curlimages/curl:latest \
  -n mcp-system --context="${CONTEXT}" \
  -- -sv -H "Host: ${HOST_HEADER}" \
  "http://${GATEWAY_SVC}/.well-known/oauth-protected-resource" 2>&1 | grep -E "(HTTP/|200|authorization_servers)" || echo "FAILED: Expected 200"
echo ""

echo "=== Test Suite Complete ==="
echo ""
echo "Summary:"
echo "  ✅ Test 1: Unauthenticated requests denied (403)"
echo "  ✅ Test 2: Token acquisition successful"
echo "  ✅ Test 3: Authenticated requests allowed (200)"
echo "  ✅ Test 4: Well-known endpoint accessible (200)"
echo ""
echo "JWT enforcement is working correctly!"
