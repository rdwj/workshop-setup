# LlamaStack + Kagenti MCP Lessons Learned

Findings from integrating BaseAgent with LlamaStack and Kagenti MCP
Gateway on RHPDS cluster n7pd5. Validated 2026-04-17.

## LlamaStack

### MCP Tool Registration Works Well

Register MCP servers as tool groups via the `/v1/toolgroups` API:

```bash
curl -X POST $LLAMASTACK_URL/v1/toolgroups \
  -H "Content-Type: application/json" \
  -d '{
    "toolgroup_id": "mcp::calculus-helper",
    "provider_id": "model-context-protocol",
    "mcp_endpoint": {"uri": "https://mcp-server.apps.cluster/mcp/"}
  }'
```

LlamaStack connects to the MCP server, discovers all tools, and
exposes them through both the `tool_runtime/invoke` endpoint (direct
execution) and the inference API (model-driven tool calling). Zero
code changes needed in the MCP server.

The `remote::model-context-protocol` provider must be listed in the
LlamaStack config under `providers.tool_runtime` — this is included
in the default config but verify it's there.

### Model Matters for Tool Calling

**gpt-oss-20b** generates proper OpenAI-compatible `tool_calls` in
inference responses. Tested with `evaluate_numeric`, `differentiate`,
and other calculus tools — correct function names and JSON arguments.

**Granite 3.3 8B does NOT generate tool calls.** Instead, it writes
Python code that references tools by name. This is a model capability
gap, not a LlamaStack issue. If your workshop requires tool calling,
use gpt-oss-20b or another model with proven tool-calling support.

### Embedding Model Requires GPU

The `EMBEDDING_DIMENSION = 768` bug from last session still applies.
When creating vector stores, always pass `embedding_dimension`
explicitly (384 for all-MiniLM-L6-v2). See
[llamastack/llama-stack#5585](https://github.com/llamastack/llama-stack/issues/5585).

Also: vLLM's `vllm-openai:latest` image is GPU-only for serving
embedding models. You cannot run it in CPU-only mode. TEI doesn't
serve `/v1/models` which LlamaStack requires, so vLLM is the only
option for LlamaStack embedding integration.

The eval-gpu machineset is scaled to 0 — the embedding pod will be
pending until a GPU node is provisioned.

### vLLM Writable Cache

vLLM crashes on OpenShift's non-root containers without writable
cache dirs. Set these env vars on the vLLM deployment:

```yaml
env:
  - name: HOME
    value: /tmp/home
  - name: XDG_CACHE_HOME
    value: /tmp/cache
  - name: VLLM_CACHE_DIR
    value: /tmp/vllm-cache
```

### Tool Registration Is Not Persistent

Tool groups registered via `/v1/toolgroups` are stored in-memory.
When LlamaStack restarts, registrations are lost. For workshops,
either:
- Include registration in a startup script / init container
- Add tool groups to the ConfigMap config (if supported in your
  LlamaStack version)
- Have the workshop instructions include a registration step

## Kagenti MCP Gateway

### Architecture Is Not What You'd Expect

The Kagenti MCP Gateway is **not** a simple HTTP proxy. It's a
three-layer stack:

1. **Istio Ingress Gateway** — receives external traffic
2. **MCP Gateway Broker** — Envoy ext_proc (external processor) that
   intercepts ALL requests before routing
3. **Upstream MCP Servers** — the actual tools (ClusterIP only)

The broker rewrites the `:authority` header to
`mcp.127-0-0-1.sslip.io` (hardcoded) and sets routing headers that
tell Envoy where to forward. This means:

- **Do NOT change the Gateway or HTTPRoute hostnames.** They must be
  `mcp.127-0-0-1.sslip.io` — this is what the broker expects, not a
  misconfiguration. We tested changing them and it broke everything.
- The `mcp.127-0-0-1.sslip.io` hostname is internal to the Istio
  routing chain. External access works through the OpenShift Route
  despite the hostname mismatch (the ext_proc rewrites it before
  Envoy re-evaluates routes).

### Discovery Works, Tool Calls Do Not

The broker aggregates `tools/list` across all registered MCP servers.
An agent connecting to the gateway URL sees all tools from all
upstream servers in a single list. This works correctly.

**Tool execution (`tools/call`) returns an error:**
```
"Kagenti MCP Broker doesn't forward tool calls"
```

This is a v0.1.2 limitation. The routing infrastructure (HTTPRoutes,
Envoy clusters) is configured to forward to upstream servers, but
the broker's ext_proc doesn't produce the forwarding headers for
`tools/call` requests. It only handles `tools/list` and `initialize`.

### Workshop Workarounds

**Option A: Agents inside the cluster** (recommended for workshops).
Deploy agent pods that connect to upstream MCP servers directly via
ClusterIP:
```
http://weather-tool-mcp.team1.svc.cluster.local:8000/mcp
```
Use the broker only for discovery if needed.

**Option B: Expose upstream servers via Routes.** Create an OpenShift
Route for each MCP server:
```bash
oc expose svc/weather-tool-mcp -n team1
```
Then agents connect directly, bypassing the gateway entirely.

### Registering MCP Servers

Uses Kubernetes CRDs — `HTTPRoute` + `MCPServerRegistration`:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: my-tool-mcp
  namespace: team1
  labels:
    kagenti.io/type: tool
spec:
  hostnames: ["mcp.127-0-0-1.sslip.io"]   # MUST be this hostname
  parentRefs:
    - kind: Gateway
      name: mcp-gateway
      namespace: gateway-system
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /my-tool
      backendRefs:
        - name: my-tool-mcp
          port: 8000
---
apiVersion: mcp.kagenti.com/v1alpha1
kind: MCPServerRegistration
metadata:
  name: my-tool
  namespace: team1
spec:
  path: /mcp
  targetRef:
    group: gateway.networking.k8s.io
    kind: HTTPRoute
    name: my-tool-mcp
    namespace: team1
```

The controller discovers tools from the upstream server and adds
them to the broker's aggregated listing within ~60 seconds.

### Auth Is Disabled By Default

The deployment includes Keycloak but auth is not enforced on the MCP
gateway. The broker logs show:
```
WARNING: Authentication is disabled. This is not recommended.
```

For workshops this is fine. For production, enable Keycloak auth via
AuthPolicy CRDs (see Kagenti docs for Kuadrant integration).

## Pre-Deployment Credential Checklist

Gather these before running the kagenti installer on a fresh cluster. All
credentials go into `deployments/envs/.secret_values.yaml` (never commit
this file — it's in `.gitignore`).

### GitHub token and username

Required so the installer can pull Helm charts and images from private GHCR
repos. The mcp-gateway Helm chart lives in a private GHCR repo, so the GHCR
login must happen **before** running the installer — not just at image pull
time.

Scopes needed: `read:packages` (GHCR image pull), `repo` (only if pulling
from private source repos).

```bash
# Retrieve your token from the gh CLI
gh auth token

# Then log Helm v3 into GHCR — do this before running run-install.sh
/opt/homebrew/opt/helm@3/bin/helm registry login ghcr.io \
  --username <your-github-username> \
  --password "$(gh auth token)"
```

Set in `.secret_values.yaml`:
```yaml
secrets:
  githubUser: <your-github-username>
  githubToken: <token>
```

### Quay.io credentials

Only required if you are building images from source via Shipwright. If you
are using pre-built images, these can be left blank.

```yaml
secrets:
  quayUser: <username+robot-account>   # e.g. wjackson+wesjackson
  quayToken: <robot-account-token>
```

Generate a robot account token at https://quay.io/organization/<org>/robots.

### Keycloak admin password

**Gotcha: the password in `.secret_values.yaml` is NOT what you use to log
in.** Kagenti creates its own Keycloak admin credentials via the
`keycloak-initial-admin` secret in the `keycloak` namespace. The
values file entry under `keycloak.adminPassword` is used by the
`keycloak-admin-secret` (for the AuthBridge client-registration sidecar) —
it is a separate credential from the Keycloak console login.

To retrieve the actual Keycloak console password after install:

```bash
oc get secret keycloak-initial-admin -n keycloak \
  -o jsonpath='{.data.password}' | base64 -d
```

### Helm v3 requirement

The installer explicitly rejects Helm v4. On macOS, Homebrew may install
Helm v4 by default. Install v3 separately and prepend it to PATH:

```bash
brew install helm@3
export PATH="/opt/homebrew/opt/helm@3/bin:$PATH"
```

Verify: `helm version --short` should show `v3.x.x`.

## Cluster Quick Reference (n7pd5)

| Service | Namespace | Access |
|---|---|---|
| LlamaStack | llamastack | `llama-stack-service:8321` (ClusterIP), route at `llamastack-llamastack.apps.cluster-n7pd5...` |
| Kagenti UI | kagenti-system | `https://kagenti-ui-kagenti-system.apps.cluster-n7pd5...` |
| MCP Gateway | gateway-system | `https://mcp-gateway-gateway-system.apps.cluster-n7pd5.../mcp` |
| MCP Broker | mcp-system | `mcp-gateway-broker-router` (ClusterIP) |
| Calculus Helper MCP | calculus-helper-mcp | Route at `https://mcp-server-calculus-helper-mcp.apps.cluster-n7pd5.../mcp/` |
| Keycloak | kagenti-system | admin: `temp-admin` / see `~/.secrets` |
| gpt-oss-20b | gpt-oss-model-2 | vLLM on L40S GPUs |
| Granite 3.3 8B | granite-model | vLLM on L40S GPU |

**Context:** Use `--context=mcp-rhoai` on all `oc` commands. Multiple
sessions share kubeconfig — never switch contexts.
