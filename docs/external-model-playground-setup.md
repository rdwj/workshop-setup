# Cross-Cluster Model + MCP Gateway: Gen AI Playground Setup

How to configure the RHOAI Gen AI Studio Playground on a management cluster
(no GPUs) to use a model served on a remote cluster, with MCP Gateway
providing tool calling capabilities.

## Architecture

```
                    Management Cluster (no GPUs)
                    +-----------------------------------------+
                    |  Dashboard UI  -->  Gen AI BFF (Go)      |
                    |                         |                |
                    |        Llama Stack Distribution (LSD)    |
                    |            /              \              |
                    |   MCP Gateway          External Model    |
                    |   (mcp-system)         ConfigMap/Secret  |
                    +-----------|------------------|-----------+
                                |                  |
                    Keycloak    |                  |  HTTPS
                    (AuthZ)     |                  |
                                v                  v
                    MCP Servers (upstream)    Remote Model Cluster
                                             +-------------------+
                                             | vLLM (gpt-oss-20b)|
                                             | with tool calling  |
                                             +-------------------+
```

The Gen AI BFF creates a LlamaStackDistribution (LSD) per project namespace.
The LSD connects to:
- The external model endpoint via the `gen-ai-aa-custom-model-endpoints` ConfigMap
- MCP servers via the `gen-ai-aa-mcp-servers` ConfigMap

## Prerequisites

1. **Management cluster** with RHOAI 3.4 installed
2. **Remote model cluster** with a vLLM model serving an OpenAI-compatible API
   - Model must support tool calling (`--enable-auto-tool-choice`, `--tool-call-parser`)
3. **MCP Gateway** deployed and accessible (Kuadrant MCP Gateway or equivalent)
4. **Keycloak** realm configured for MCP Gateway auth (optional, for MCP auth)

## Step 1: Enable dashboard flags

Patch the `OdhDashboardConfig` to enable Gen AI Studio, custom endpoints,
external providers, and MCP catalog.

```bash
CTX="<your-management-cluster-context>"

oc patch odhdashboardconfig odh-dashboard-config \
  -n redhat-ods-applications --context="$CTX" --type=merge -p '{
  "spec": {
    "dashboardConfig": {
      "genAiStudio": true,
      "aiAssetCustomEndpoints": true,
      "mcpCatalog": true,
      "modelAsService": true,
      "enablement": true
    },
    "genAiStudioConfig": {
      "aiAssetCustomEndpoints": {
        "externalProviders": true,
        "clusterDomains": []
      }
    }
  }
}'
```

**Security note:** Enabling `externalProviders` allows users to send data
(RAG context, MCP tool results, user input) to endpoints outside the cluster.

## Step 2: Enable Llama Stack and MLflow operators

The Playground requires the Llama Stack Operator (for the LSD backend) and
optionally the MLflow Operator (for prompt management).

```bash
oc patch dsc default-dsc --context="$CTX" --type=merge -p '{
  "spec": {
    "components": {
      "llamastackoperator": {"managementState": "Managed"},
      "mlflowoperator": {"managementState": "Managed"}
    }
  }
}'
```

Verify both are ready:

```bash
oc get dsc default-dsc --context="$CTX" -o jsonpath='{.status.conditions}' \
  | python3 -c "
import sys, json
for c in json.load(sys.stdin):
    if c['type'] in ('LlamaStackOperatorReady', 'MLflowOperatorReady'):
        print(f\"{c['type']}: {c['status']}\")
"
```

## Step 3: Identify the remote model

Query the remote vLLM endpoint to get the exact model ID:

```bash
REMOTE_MODEL_URL="https://gpt-oss-20b-gpt-oss-model.apps.cluster-n7pd5.n7pd5.sandbox5167.opentlc.com"
curl -s "${REMOTE_MODEL_URL}/v1/models" | python3 -m json.tool
```

Note the `id` field (e.g., `RedHatAI/gpt-oss-20b`).

Verify tool calling works:

```bash
curl -s "${REMOTE_MODEL_URL}/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "RedHatAI/gpt-oss-20b",
    "messages": [{"role": "user", "content": "Hello"}],
    "tools": [{"type": "function", "function": {
      "name": "test_tool", "description": "A test tool",
      "parameters": {"type": "object", "properties": {}}
    }}],
    "max_tokens": 50
  }'
```

## Step 4: Create a Data Science Project

Create a namespace with the `opendatahub.io/dashboard: "true"` label.
This makes it appear as a Data Science Project in the dashboard.

```bash
NS="workshop-playground"

cat <<EOF | oc apply --context="$CTX" -f -
apiVersion: v1
kind: Namespace
metadata:
  name: ${NS}
  labels:
    opendatahub.io/dashboard: "true"
    kubernetes.io/metadata.name: ${NS}
  annotations:
    openshift.io/display-name: "Workshop Playground"
    openshift.io/description: "Gen AI Playground with external model and MCP tools"
EOF
```

## Step 5: Register the external model endpoint

The dashboard creates custom endpoints as a ConfigMap + Secret pair in the
project namespace. The ConfigMap name is `gen-ai-aa-custom-model-endpoints`
and stores a `config.yaml` key with YAML content.

### Create the API key Secret

Even if the remote endpoint doesn't require authentication, the dashboard
code expects a Secret reference:

```bash
cat <<EOF | oc apply --context="$CTX" -n "${NS}" -f -
apiVersion: v1
kind: Secret
metadata:
  name: endpoint-api-key-1
type: Opaque
stringData:
  api_key: "no-auth-required"
EOF
```

If the remote endpoint requires authentication, replace `no-auth-required`
with the actual API key or token.

### Create the external model ConfigMap

```bash
cat <<'EOF' | oc apply --context="$CTX" -n "${NS}" -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: gen-ai-aa-custom-model-endpoints
data:
  config.yaml: |
    providers:
      inference:
        - provider_id: endpoint-1
          provider_type: "remote::openai"
          config:
            base_url: "https://gpt-oss-20b-gpt-oss-model.apps.cluster-n7pd5.n7pd5.sandbox5167.opentlc.com/v1"
            allowed_models:
              - "RedHatAI/gpt-oss-20b"
            custom_gen_ai:
              api_key:
                secretRef:
                  name: "endpoint-api-key-1"
                  key: "api_key"
    registered_resources:
      models:
        - provider_id: endpoint-1
          model_id: "RedHatAI/gpt-oss-20b"
          model_type: "llm"
          metadata:
            display_name: "GPT-OSS 20B (Remote)"
            custom_gen_ai:
              use_cases: "General purpose chat, tool calling, code generation"
EOF
```

**ConfigMap format notes:**
- `provider_type` must be `remote::openai` for OpenAI-compatible endpoints
  (use `remote::passthrough` for embedding models)
- `base_url` must include the `/v1` path suffix
- `allowed_models` must exactly match the model ID from `/v1/models`
- `provider_id` must match between the provider and the registered model
- `model_type` is `llm` for inferencing or `embedding` for embedding models

## Step 6: Configure MCP servers

MCP servers are registered cluster-wide in the `redhat-ods-applications`
namespace via the `gen-ai-aa-mcp-servers` ConfigMap. Use the internal
ClusterIP URL because the Gen AI BFF (running inside the cluster) connects
to MCP servers server-side.

```bash
cat <<'EOF' | oc apply --context="$CTX" -n redhat-ods-applications -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: gen-ai-aa-mcp-servers
  namespace: redhat-ods-applications
data:
  MCP-Gateway-Tools: |
    {
      "url": "http://mcp-gateway.mcp-system.svc:8080/mcp",
      "description": "MCP Gateway providing OpenShift cluster management tools via the Kuadrant MCP Gateway. Includes pod listing, resource management, events, logs, and cluster inspection."
    }
EOF
```

**Key points:**
- Use the internal `svc.cluster.local` URL, not the external LoadBalancer URL
- The ConfigMap key (e.g., `MCP-Gateway-Tools`) is the display name in the UI
- The value must be valid JSON with `url` and `description` fields

## Step 7: Use the Playground

1. Open the RHOAI dashboard: `https://rh-ai.apps.<cluster-domain>/`
2. Navigate to **Gen AI Studio** > **AI asset endpoints**
3. The external model "GPT-OSS 20B (Remote)" should appear in the Models list
4. Click **Add to Playground** next to the model
5. Go to **Gen AI Studio** > **Playground**
6. Select the model from the Model dropdown

### Enable MCP tools

1. In the Playground settings panel, click the **MCP** tab
2. Check the box next to your MCP server
3. Click the **Auth** icon and enter a Keycloak token (see below)
4. Click **Authorize** -- a "Connection successful" message should appear
5. Click the **View tools** icon to see available tools

### Get the MCP Gateway client secret

The client secret is stored in Keycloak. Retrieve it via the Admin API:

```bash
KEYCLOAK_URL="https://keycloak-keycloak.apps.<cluster-domain>"
CTX="<your-cluster-context>"

# Get Keycloak admin credentials from the OpenShift secret
ADMIN_USER=$(oc get secret keycloak-initial-admin -n keycloak --context="$CTX" -o jsonpath='{.data.username}' | base64 -d)
ADMIN_PASS=$(oc get secret keycloak-initial-admin -n keycloak --context="$CTX" -o jsonpath='{.data.password}' | base64 -d)

# Get an admin token
ADMIN_TOKEN=$(curl -s -X POST "${KEYCLOAK_URL}/realms/master/protocol/openid-connect/token" \
  -d "client_id=admin-cli" \
  -d "username=${ADMIN_USER}" \
  -d "password=${ADMIN_PASS}" \
  -d "grant_type=password" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")

# Look up the mcp-gateway client and get its secret
CLIENT_UUID=$(curl -s -H "Authorization: Bearer ${ADMIN_TOKEN}" \
  "${KEYCLOAK_URL}/admin/realms/mcp-gateway/clients?clientId=mcp-gateway" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)[0]['id'])")

curl -s -H "Authorization: Bearer ${ADMIN_TOKEN}" \
  "${KEYCLOAK_URL}/admin/realms/mcp-gateway/clients/${CLIENT_UUID}/client-secret" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['value'])"
```

### Get a Keycloak token for MCP auth

If the MCP Gateway requires auth, obtain a token:

```bash
KEYCLOAK_URL="https://keycloak-keycloak.apps.<cluster-domain>"
CLIENT_SECRET="<your-mcp-gateway-client-secret>"

TOKEN=$(curl -s -X POST "${KEYCLOAK_URL}/realms/mcp-gateway/protocol/openid-connect/token" \
  -d "client_id=mcp-gateway" \
  -d "client_secret=${CLIENT_SECRET}" \
  -d "grant_type=client_credentials" \
  -d "scope=openid groups" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")
echo "$TOKEN"
```

**Important:** The `-d` parameters must be passed separately (not concatenated
with `&`). When concatenated, the shell may misinterpret `&` as a background
operator, and spaces in `scope=openid groups` cause parsing issues.

Paste this token in the MCP Auth dialog in the Playground.

**Note:** Authorization tokens for MCP servers are stored only in the current
browser session. If you close your browser, re-authorize.

### Test tool calling

Send a prompt that requires tool use, such as:
- "List all pods in the mcp-system namespace"
- "What OpenShift projects are in this cluster?"

The model should generate a tool call, the Playground will execute it via
the MCP Gateway, and return the results.

## How it works internally

1. When you open the Playground, the Gen AI BFF creates a
   `LlamaStackDistribution` (LSD) CR in your project namespace
2. The LSD operator deploys a Llama Stack pod that acts as the responses API
3. The BFF reads `gen-ai-aa-custom-model-endpoints` from your namespace and
   configures the LSD with the external model as an inference provider
4. The BFF reads `gen-ai-aa-mcp-servers` from `redhat-ods-applications` and
   configures the LSD with MCP connectors
5. Chat messages from the UI go through: Browser > BFF > LSD > External Model
6. Tool calls go through: LSD > MCP Gateway > Backend MCP Server

## Limitations and gotchas

1. **Custom endpoints is Tech Preview** in RHOAI 3.4. Not supported under
   production SLAs.

2. **ConfigMap format is undocumented.** The `gen-ai-aa-custom-model-endpoints`
   ConfigMap format was reverse-engineered from the odh-dashboard source code.
   The dashboard UI can also create these resources via the "Create endpoint"
   button, which may be more reliable for production use.

3. **MCP auth tokens are session-scoped.** Closing the browser loses the token.
   The Playground does not persist MCP credentials.

4. **Model must support tool calling.** The remote vLLM model must be
   configured with `--enable-auto-tool-choice` and an appropriate
   `--tool-call-parser` for the model family. Without this, MCP tools will
   silently fail.

5. **Base URL must include `/v1`.** The external model ConfigMap `base_url`
   must end with `/v1` for OpenAI-compatible endpoints. The LSD appends
   `/chat/completions` to this path.

6. **No auth verification for external models.** The Playground does not
   validate whether the API key is correct until you send a message. If you
   get connection errors, check the API key and URL.

7. **LSD creation can take 30-60 seconds.** The first time you open the
   Playground in a new project, the LSD pod needs to start. Wait for it.

8. **Internal URL required for MCP.** The MCP ConfigMap must use the internal
   ClusterIP URL. The BFF connects to MCP servers server-side, not from the
   browser.

## Verification checklist

```bash
CTX="<your-context>"
NS="workshop-playground"

# Dashboard flags
oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  --context="$CTX" -o jsonpath='{.spec.dashboardConfig.genAiStudio}'
# Expected: true

oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  --context="$CTX" -o jsonpath='{.spec.dashboardConfig.aiAssetCustomEndpoints}'
# Expected: true

oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
  --context="$CTX" -o jsonpath='{.spec.genAiStudioConfig.aiAssetCustomEndpoints.externalProviders}'
# Expected: true

# Operators ready
oc get dsc default-dsc --context="$CTX" -o jsonpath='{.status.conditions}' \
  | python3 -c "
import sys, json
for c in json.load(sys.stdin):
    if c['type'] in ('LlamaStackOperatorReady','MLflowOperatorReady','DashboardReady'):
        print(f\"{c['type']}: {c['status']}\")
"
# Expected: all True

# External model ConfigMap
oc get configmap gen-ai-aa-custom-model-endpoints -n "$NS" --context="$CTX"
# Expected: exists with 1 data key

# API key Secret
oc get secret endpoint-api-key-1 -n "$NS" --context="$CTX"
# Expected: exists

# MCP servers ConfigMap
oc get configmap gen-ai-aa-mcp-servers -n redhat-ods-applications --context="$CTX"
# Expected: exists

# Remote model reachable
curl -s "https://<remote-model-url>/v1/models" | python3 -c "
import sys, json
models = json.load(sys.stdin)['data']
for m in models:
    print(f\"Model: {m['id']}\")
"
```
