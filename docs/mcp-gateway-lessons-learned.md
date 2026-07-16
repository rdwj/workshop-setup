# MCP Ecosystem: Deployment Findings

Findings from RHOAI 3.4 MCP ecosystem deployment on OCP 4.20+.
Items marked **[ISSUE FILED]** have upstream tracking. Items marked
**[NEEDS JIRA]** catalog image requires internal Jira.

---

## Bugs

---

#### 1. Catalog deploys OpenShift MCP server with nonexistent image

**[NEEDS JIRA]** for the broken catalog image. Lifecycle operator prerequisites tracked separately below.

The built-in Red Hat MCP catalog references
`registry.redhat.io/openshift-mcp-beta/openshift-mcp-server-rhel9:0.2`
which returns `manifest unknown`. The image does not exist at that path.
Additionally, the RHOAI dashboard does not create the prerequisites
(ServiceAccount, ConfigMap) described in the catalog's
`runtimeMetadata.prerequisites` before submitting the MCPServer CR.
The lifecycle operator validates that these exist but does not create
them. Deploy-from-catalog requires manual prerequisite creation until
this is addressed.

**Workaround:** Create prerequisites manually per namespace, then patch
the image to `quay.io/redhat-user-workloads/ocp-mcp-server-tenant/openshift-mcp-server-release-03:latest`.

**Upstream:**

- [kubernetes-sigs/mcp-lifecycle-operator#226](https://github.com/kubernetes-sigs/mcp-lifecycle-operator/issues/226) (prerequisite auto-creation)
- [kubernetes-sigs/mcp-lifecycle-operator#227](https://github.com/kubernetes-sigs/mcp-lifecycle-operator/pull/227) (PR, validated on cluster)
- Catalog image: Jira to be filed separately

---

#### 2. ~~Playground does not forward MCP auth tokens~~ — RESOLVED

**[RESOLVED]** — This was a configuration error, not a platform bug.

The Playground/LSD **does** forward the JWT pasted in the lock icon.
The issue was that the `gen-ai-aa-mcp-servers` ConfigMap pointed at the
broker's internal service (`mcp-gateway.mcp-system.svc:8080`) instead of
the Istio gateway service. The broker direct path bypasses the ext_proc
filter chain, so `tools/call` fails.

**Fix:** Use the Istio gateway's internal service URL in the ConfigMap:

```yaml
data:
  MCP-Gateway: |
    {
      "url": "http://mcp-gateway-data-science-gateway-class.mcp-system.svc.cluster.local:8080/mcp",
      "description": "MCP Gateway"
    }
```

With this URL, the full authenticated chain works through the Playground:
user pastes JWT → LSD forwards it → Authorino validates → wristband
issued → ext_proc routes tools/call → backend uses SA token.

**Upstream:** [opendatahub-io/ogx-distribution#415](https://github.com/opendatahub-io/ogx-distribution/issues/415) (closed — configuration error)

---

#### 3. Broker hardcodes Istio gateway service name as `<gateway>-istio`

**[ISSUE FILED]**

The ext_proc router resolves the Istio gateway service by appending
`-istio` to the Gateway name. When the GatewayClass is named something
other than `istio` (e.g., `data-science-gateway-class`), the lookup
fails. `tools/list` works (cached) but `tools/call` fails with a DNS
error.

**Workaround:** Set `privateHost` on the MCPGatewayExtension to the
actual Istio gateway service name. Alternatively, create an ExternalName
service alias.

**Upstream:** [kuadrant/mcp-gateway#679](https://github.com/Kuadrant/mcp-gateway/issues/679)

---

#### 4. ~~`x-mcp-virtualserver` header routing does not take effect~~ — RESOLVED

**[CLOSED]** [kuadrant/mcp-gateway#1079](https://github.com/Kuadrant/mcp-gateway/issues/1079) — user error

`x-mcp-virtualserver` header routing **does work** when requests go
through the Istio gateway service
(`mcp-gateway-data-science-gateway-class`). The original report was
testing against the broker's ClusterIP service (`mcp-gateway`), which
bypasses the ext_proc filter chain entirely.

With both VirtualMCPServer and wristband configured, they act as
**subtractive layers** — the broker returns the intersection of both
tool lists. This enforces access on both `tools/list` and `tools/call`.

**Best practice:** Use both mechanisms together. The wristband
(`x-authorized-tools`) defines per-group tool permissions via OPA Rego.
The MCPVirtualServer (`x-mcp-virtualserver`) provides curated tool
views. The broker enforces their intersection — a tool must appear in
both to be accessible.

---

#### 5. Broker does not auto-reload when config secret changes

**[ISSUE FILED]** [kuadrant/mcp-gateway#1080](https://github.com/Kuadrant/mcp-gateway/issues/1080)

When MCPServerRegistration resources are created, the controller updates
the gateway config Secret, but the broker pod does not reload. New
servers are not discovered until the broker is restarted.

**Workaround:** `oc rollout restart deployment/<broker> -n <gateway-ns>`

---

#### 6. MCP Lifecycle Operator OOMKilled at default 128Mi

**[ISSUE FILED]** [kubernetes-sigs/mcp-lifecycle-operator#230](https://github.com/kubernetes-sigs/mcp-lifecycle-operator/issues/230)

The operator manifest sets a default memory limit of 128Mi. During
MCPServer reconciliation, memory usage exceeds this and the pod is
OOMKilled.

**Workaround:** Patch the deployment to 512Mi after install.

---

#### 7. Authorization header forwarded to backend breaks SA token auth

**[ISSUE FILED]** Related: [kuadrant/mcp-gateway#926](https://github.com/Kuadrant/mcp-gateway/issues/926)

When the AuthPolicy validates a JWT and the request is forwarded to the
backend MCP server, the `Authorization: Bearer <keycloak-jwt>` header
is included. The OpenShift MCP server supports OIDC and uses the
received Bearer token for Kubernetes API authentication instead of its
own ServiceAccount token. Since the Keycloak JWT is not valid for the
K8s API, tool calls fail with "the server has asked for the client to
provide credentials."

**Workaround:** Strip the `Authorization` header in the AuthPolicy
response before forwarding to the backend:

```yaml
response:
  success:
    headers:
      authorization:
        plain:
          value: ""
```

---

## Sharp Edges

---

#### 8. MCP-only clusters: `modelsAsService` must be `Removed`

Setting `modelsAsService: Managed` in the DataScienceCluster deploys
the `maas-controller`, which requires Kuadrant CRDs (`AuthPolicy`,
`TokenRateLimitPolicy`) and a MaaS Gateway. On clusters that only need
MCP, the maas-controller enters CrashLoopBackOff because these
prerequisites don't exist.

---

#### 9. External MCP servers: broker connects plain HTTP only

The broker (v0.6.0) connects to backend MCP servers over plain HTTP
even when the config secret contains `https://` URLs. Istio
ServiceEntry, DestinationRule, and sidecar injection do not help — the
broker pod runs without a sidecar.

**Workaround:** Deploy an nginx-unprivileged TLS-terminating reverse
proxy and register the proxy's ClusterIP Service as the HTTPRoute
backend.

---

#### 10. RHBK operator only supports OwnNamespace install mode

The Red Hat Build of Keycloak operator cannot be installed in
AllNamespaces mode. It must be installed into the namespace where
Keycloak instances will be created, with a dedicated OperatorGroup.

---

#### 11. `toolPrefix` on MCPServerRegistration is immutable

The CRD validation rule makes `toolPrefix` immutable once set. Changing
it requires deleting and recreating the MCPServerRegistration.

---

#### 12. `scope=openid groups` required for group-based routing

Keycloak tokens only include the `groups` claim if explicitly requested
with `scope=openid groups`. Without it, AuthPolicy CEL expressions
checking `auth.identity.groups` fail silently — users see an empty tool
list with no error.

---

#### 13. Vault JWT auth requires ingress CA bundle and audience mapper

Vault's JWT auth method needs the OpenShift ingress CA bundle mounted
for TLS trust to Keycloak's JWKS endpoint. Separately, Keycloak
defaults `aud` to `account` — an audience mapper must be added to
include the client ID for Vault's `bound_audiences` validation.

---

#### 14. Dedicated gateway required (guide could note sharing risk)

The MCPGatewayExtension injects ext_proc filters into the target
Gateway listener, which breaks non-MCP traffic (e.g., MaaS inference
endpoints). The guide shows dedicated gateway setup but it would help
to also note that reusing a MaaS gateway will break model serving.

---

#### 17. Route hostnames must use single-level subdomains for TLS

The OpenShift wildcard TLS certificate covers `*.apps.cluster-xxx` but
NOT multi-level subdomains like `*.mcp.apps.cluster-xxx`. Clients that
perform strict TLS verification (e.g., Claude Code's MCP client, Python
`httpx` without `verify=False`) reject connections to multi-level
hostnames.

**Fix:** Use single-level subdomain naming in HTTPRoutes and Routes:
`mcp-openshift.<domain>` instead of `openshift.mcp.<domain>`. The
Gateway listener hostname should be `*.<CLUSTER_DOMAIN>` (not
`*.mcp.<CLUSTER_DOMAIN>`) to match.

---

#### 18. MCP Gateway broker uses streamable-http transport

The MCP Gateway broker (v0.6.0+) implements the MCP streamable-http
protocol: POST requests receive JSON responses with `Mcp-Session-Id`
headers, GET requests open an SSE stream for server-initiated
notifications. It does NOT implement the legacy SSE transport (which
requires the server to send an `event: endpoint` SSE event on GET).

IDE clients must use `http` transport (not `sse`). For Claude Code:
`claude mcp add <name> <url> -t http -H "Authorization: Bearer <token>"`

---

#### 19. ClusterLogForwarder requires three RBAC layers for Loki

OpenShift Logging 6.x requires explicit RBAC before the operator will
deploy collector pods. Three layers are needed:

1. **CLO authorization:** `collect-application-logs` and
   `collect-infrastructure-logs` ClusterRoleBindings (controls which
   log types the collector is permitted to collect)
2. **Loki write access:** `logging-collector-logs-writer`
   ClusterRoleBinding (grants the collector write permissions to the
   LokiStack gateway)
3. **TLS trust:** ConfigMap with
   `service.beta.openshift.io/inject-cabundle: "true"` annotation
   (injects the cluster CA so collectors can verify the LokiStack
   gateway's TLS certificate)

Missing any one causes silent failures — no TLS errors, just 403
responses (missing write RBAC) or no collector pods at all (missing CLO
authorization).

---

## Undocumented Requirements

---

#### 15. Wristband `allowed-tools` claim format

Must be `map[string][]string` keyed by MCPServerRegistration name
(namespace-qualified). A flat array does not work. Tool names must be
**unprefixed** — the broker applies `toolPrefix` internally. Including
the prefix in the claim (e.g., `openshift_pods_list`) causes
double-prefixing and returns 0 tools.

---

#### 16. Custom catalog `artifacts` field format

Must be an array of `{uri: "oci://..."}` objects. A plain object causes
`cannot unmarshal object into []openapi.MCPArtifact`. The `source`
field in the catalog YAML must match a label name in
`model-catalog-default-sources` or entries are silently hidden from the
dashboard.

---

#### 20. Gateway pod uses `openshift-gateway` Istio, not `default`

The Envoy gateway-class pod runs Istio from the `openshift-gateway`
revision (typically v1.26.x) in `openshift-ingress`, not the `default`
Istio in `istio-system`. Telemetry resources and meshConfig patches
(e.g., `extensionProviders` for access logging) must target
`istio/openshift-gateway` in `openshift-ingress`.

Verify with:

```bash
oc exec <gateway-pod> -c istio-proxy -- \
  pilot-agent request GET config_dump 2>&1 | \
  python3 -c "import sys,json; ..."
```

Look for `ISTIO_VERSION` in the bootstrap node metadata.

---

#### 21. Wristband alone provides visibility filtering, not execution enforcement

The wristband (`x-authorized-tools`) filters `tools/list` responses —
developer-b sees 23 tools vs developer-a's 39. However, `tools/call`
for hidden tools is forwarded to the backend without checking the
wristband claim.

**This is expected behavior, not a bug.** The wristband is one layer of
the authorization stack. Full `tools/call` enforcement requires BOTH
the wristband AND `x-mcp-virtualserver` header routing to be active
(see corrected #4). The broker enforces the intersection of both layers.

When we tested with the wristband alone (no `x-mcp-virtualserver`
header in the AuthPolicy response), `tools/call` bypassed filtering.
Adding the `x-mcp-virtualserver` header that maps groups to
MCPVirtualServers completes the enforcement — the broker rejects calls
for tools not in the intersection.

**Fix:** Add both layers to the AuthPolicy response:
1. `x-authorized-tools` — wristband with `allowed-tools` claim (OPA)
2. `x-mcp-virtualserver` — maps user group to the correct
   MCPVirtualServer name (`admin-tools` or `user-tools`)
