#!/usr/bin/env bash
# vault-configure.sh — Configure Vault JWT auth with Keycloak for MCP Gateway
#
# Prerequisites:
#   - Vault deployed in 'vault' namespace (via vault-helm-values.yaml)
#   - Keycloak deployed with 'mcp-gateway' realm and 'mcp-gateway' client
#   - mcp-gateway client has an audience mapper for 'mcp-gateway'
#
# Usage:
#   CTX="default/api-cluster-..." KEYCLOAK_URL="https://..." ./vault-configure.sh

set -euo pipefail

: "${CTX:?Set CTX to your oc/kubectl context}"
: "${KEYCLOAK_URL:?Set KEYCLOAK_URL to the Keycloak base URL}"

VAULT_POD="vault-0"
VAULT_NS="vault"

echo "=== Waiting for Vault pod ==="
oc wait "pod/${VAULT_POD}" -n "${VAULT_NS}" --context="${CTX}" \
  --for=condition=Ready --timeout=90s

echo "=== Extracting ingress CA ==="
TMPCA=$(mktemp)
oc get configmap default-ingress-cert -n openshift-config-managed \
  --context="${CTX}" -o jsonpath='{.data.ca-bundle\.crt}' > "${TMPCA}"
oc get secret router-ca -n openshift-ingress-operator \
  --context="${CTX}" -o jsonpath='{.data.tls\.crt}' | base64 -d >> "${TMPCA}"

# Create/update ConfigMap with the CA bundle
oc create configmap ingress-ca --from-file=ca-bundle.crt="${TMPCA}" \
  -n "${VAULT_NS}" --context="${CTX}" --dry-run=client -o yaml \
  | oc apply --context="${CTX}" -f -
rm -f "${TMPCA}"

echo "=== Mounting CA into Vault StatefulSet ==="
# Patch only if volume not already present
if ! oc get statefulset vault -n "${VAULT_NS}" --context="${CTX}" \
     -o jsonpath='{.spec.template.spec.volumes[*].name}' | grep -q ingress-ca; then
  oc patch statefulset vault -n "${VAULT_NS}" --context="${CTX}" --type='json' -p='[
    {"op":"add","path":"/spec/template/spec/volumes/-",
     "value":{"name":"ingress-ca","configMap":{"name":"ingress-ca"}}},
    {"op":"add","path":"/spec/template/spec/containers/0/volumeMounts/-",
     "value":{"name":"ingress-ca","mountPath":"/vault/tls/ingress-ca.crt",
              "subPath":"ca-bundle.crt","readOnly":true}}
  ]'
  echo "Deleting pod to pick up volume mount..."
  oc delete pod "${VAULT_POD}" -n "${VAULT_NS}" --context="${CTX}"
  oc wait "pod/${VAULT_POD}" -n "${VAULT_NS}" --context="${CTX}" \
    --for=condition=Ready --timeout=90s
else
  echo "CA volume already mounted, skipping patch"
fi

echo "=== Enabling KV v2 secrets engine ==="
oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
  vault secrets enable -path=mcp kv-v2 2>/dev/null || echo "(already enabled)"

echo "=== Enabling JWT auth ==="
oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
  vault auth enable jwt 2>/dev/null || echo "(already enabled)"

echo "=== Configuring JWT auth with Keycloak JWKS ==="
oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
  vault write auth/jwt/config \
    jwks_url="${KEYCLOAK_URL}/realms/mcp-gateway/protocol/openid-connect/certs" \
    bound_issuer="${KEYCLOAK_URL}/realms/mcp-gateway" \
    default_role="mcp-user" \
    jwks_ca_pem=@/vault/tls/ingress-ca.crt

echo "=== Creating mcp-user policy ==="
oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- sh -c \
  'vault policy write mcp-user - <<POLICY
path "mcp/data/users/{{identity.entity.aliases.auth_jwt_*.metadata.username}}/*" {
  capabilities = ["read"]
}
path "mcp/data/shared/*" {
  capabilities = ["read"]
}
POLICY'

echo "=== Creating mcp-user JWT role ==="
oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
  vault write auth/jwt/role/mcp-user \
    bound_audiences="mcp-gateway,mcp-playground" \
    user_claim="sub" \
    claim_mappings="preferred_username=username" \
    token_policies="mcp-user" \
    token_ttl="5m" \
    role_type="jwt"

echo "=== Storing demo secrets ==="
oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
  vault kv put mcp/users/service-account-mcp-gateway/github \
    token="ghp_demo_token_for_testing" \
    api_key="demo-api-key-12345"

oc exec -n "${VAULT_NS}" --context="${CTX}" "${VAULT_POD}" -- \
  vault kv put mcp/shared/defaults \
    api_key="shared-default-key"

echo ""
echo "=== Vault Configuration Complete ==="
echo "Vault URL (in-cluster): http://vault.vault.svc.cluster.local:8200"
echo "Root token: root (dev mode)"
echo "JWT auth: Keycloak ${KEYCLOAK_URL}/realms/mcp-gateway"
echo "KV path:  mcp/users/{username}/{server-name}"
echo "Shared:   mcp/shared/{name}"
