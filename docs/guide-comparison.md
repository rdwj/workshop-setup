# MCP Ecosystem Guide vs Our Deployment: Comparison

Compared `guides/MCP-Ecosystem/` (Jaideep Rao, ROSA/OCP 4.21.6, RHOAI 3.4.0) against our deployment on OCP 4.20 / RHOAI 3.4.

## Decision Key

- **Align deployment** — we should change our deployment to match the guide
- **Suggest guide change** — our approach works better; propose the guide be updated
- **Acceptable** — intentional divergence, no action needed

---

## 1. Architecture (Section 04)

Our deployment implements all four ecosystem components (Catalog, Lifecycle Operator, Gateway, Gen AI Studio). Overall architecture is faithful.

| Difference | Guide | Us | Decision |
|---|---|---|---|
| Service Mesh as prerequisite | Footnote mention | Explicit requirement in gateway-infrastructure.yml | **Suggest guide change** — SM3 should be an explicit Tier 1 prerequisite |
| Catalog UI | "Browsable inventory" implies interactive UI | Static YAML + Python generator | **Acceptable** — we use the RHOAI dashboard's built-in catalog UI; our generator feeds it |

## 2. Operators, Gateway, Keycloak (Section 05)

| Difference | Guide | Us | Decision |
|---|---|---|---|
| Gateway install method | Helm chart | Ansible playbook (direct CR creation) | **Suggest guide change** — add Ansible as alternative; Helm isn't required |
| Keycloak realm name | `mcp-gateway` | `mcp-gateway` | **Done** — renamed to match guide |
| Keycloak client names | `mcp-gateway` + `mcp-playground` | `mcp-gateway` + `mcp-playground` | **Done** — both clients created |
| Kuadrant CR namespace | `openshift-operators` | `kuadrant-system` | **Suggest guide change** — dedicated namespace is cleaner; less clutter in openshift-operators |
| RHBK operator install | Documented | Not automated in playbooks | **Align deployment** — add RHBK to gateway-infrastructure.yml or a new keycloak-setup.yml |
| Vault deployment | Documented | Scripts exist but not in playbooks | **Align deployment** — add vault-setup.yml playbook |
| Wristband key generation | Required (section 5.1.2.4) | Scripts exist but not in playbooks | **Align deployment** — add to mcp-setup.yml or ecosystem-setup.yml |
| RHCL version | v1.3.2 | v1.3.4 | **Acceptable** — we use what the catalog provides |
| Gateway extra listener | `mcps` only | `mcps` (8080/HTTP) + `https` (443/HTTPS) | **Acceptable** — extra TLS listener adds external access |

## 3. AuthPolicy, Wristband, Vault (Section 05)

| Difference | Guide | Us | Decision |
|---|---|---|---|
| AuthPolicy sectionName | `mcp` (external listener) | `mcps` (backend listener) | **Investigate** — guide targets external; we target internal. Both work, but the guide's approach is architecturally cleaner for client-facing auth |
| AuthPolicy rules nesting | Flat `rules:` | `defaults:` → `strategy: atomic` → `rules:` | **Acceptable** — different Kuadrant API versions may require this |
| Wristband claim construction | OPA Rego extracts from `resource_access` JWT claim | OPA Rego with group-based tool lists | **Done** — switched from CEL to Rego |
| Vault KV mount path | `secret/` (default) | `mcp/` (custom) | **Acceptable** — custom mount is cleaner for multi-tenant Vault |
| Vault secret path structure | `secret/data/mcp-gateway/users/{sub}/{server}` | `mcp/users/{username}/{server}` | **Acceptable** — functionally equivalent, different path convention |
| Vault policy templating | `{{identity.entity.aliases.<mount>.metadata.preferred_username}}` | `{{identity.entity.aliases.auth_jwt_*.metadata.username}}` | **Acceptable** — wildcard mount accessor works |

## 4. Server Deployment + Registration (Section 05)

| Difference | Guide | Us | Decision |
|---|---|---|---|
| Tool prefix | `toolPrefix: openshift_` in MCPServerRegistration | `toolPrefix: openshift_` | **Done** — prefixes set, immutable once applied |
| VirtualMCPServer tool names | Prefixed (`openshift_pods_list`) | Prefixed (`openshift_pods_list`) | **Done** — updated to match |
| HTTPRoute hostname | `openshift-mcp-server.mcp.local` | `openshift.mcp.local` | **Acceptable** — naming convention, not functional |
| MCPServer image | `registry.redhat.io/...rhel9:0.2` | `quay.io/redhat-user-workloads/...release-03:latest` | **Suggest guide change** — registry.redhat.io image doesn't exist; guide should update |

## 5. Gen AI Studio + Catalog (Section 05)

| Difference | Guide | Us | Decision |
|---|---|---|---|
| Catalog ConfigMap format | Two-key: `sources.yaml` + catalog data YAML | Simple JSON-per-key for Playground + separate catalog CM | **Investigate** — verify our format works with the RHOAI catalog UI |
| Catalog management | Manual ConfigMap authoring with full tool schemas | `generate-catalog.py` from `mcp-servers.yaml` | **Acceptable** — our automation is an improvement over manual editing |
| Catalog fields | 20+ fields (artifacts, runtimeMetadata, prerequisites) | 12 fields (no OCI URIs, no deployment prerequisites) | **Align deployment** — add `artifacts` and `runtimeMetadata` for servers we want deployable from catalog |
| OGX Distribution CR | Referenced | Not deployed | **Align deployment** — needed for Playground tool calling to work through OGX |

## 6. Personas + RBAC (Section 06)

| Difference | Guide | Us | Decision |
|---|---|---|---|
| Responsibility pattern | 4 patterns described | Platform-Managed (centralized) | **Acceptable** — appropriate for workshop/demo |
| VirtualMCPServer for tool curation | Used per guide | Created but filtering done via wristband instead | **Acceptable** — wristband approach works; VirtualMCPServer routing has ext_proc ordering issue |
| Per-user K8s RBAC | Implied by namespace admin pattern | Single `mcp-viewer` ServiceAccount | **Acceptable** — workshop scope doesn't need per-user K8s RBAC |

## 7. Namespace Isolation (Section 07)

| Difference | Guide | Us | Decision |
|---|---|---|---|
| Topology | 4 options described | Shared gateway + per-server namespaces (light hybrid) | **Acceptable** — valid variant of shared gateway model |
| ReferenceGrant placement | Gateway's namespace | We have one in `gateway-system` (possibly wrong namespace) | **Align deployment** — verify ReferenceGrant is in the Gateway CR's namespace |
| NetworkPolicy | Not explicitly recommended | Not deployed | **Acceptable** — neither prescribes it |

## 8. BYOS + Best Practices (Section 08-09)

| Difference | Guide | Us | Decision |
|---|---|---|---|
| Security scanning | Vulnerability scans + SAST required | Not documented | **Align deployment** — add scanning to CI for custom MCP servers |
| Health endpoints | Required in catalog metadata | Not in our catalog entries | **Align deployment** — add `healthEndpoints` field to mcp-servers.yaml |
| Catalog deployment metadata | `artifacts`, `runtimeMetadata.prerequisites` | Not present | **Align deployment** — needed for "Deploy from catalog" button to work |

### Bugs and Sharp Edges Not Covered by the Guide

See `docs/mcp-gateway-lessons-learned.md` for the full list (7 bugs,
7 sharp edges, 2 undocumented requirements) with workarounds and
upstream issue references.

---

## Priority Actions — Status

### Changes applied to our deployment:

All five alignment items are complete. Keycloak realm/clients renamed,
toolPrefix set, CEL replaced with OPA Rego, ecosystem-setup playbook
created, catalog metadata added. See tables above for details.

### Should suggest to guide author:
1. Service Mesh 3 as explicit Tier 1 prerequisite (not footnote)
2. Ansible as alternative to Helm for gateway setup
3. Kuadrant CR in dedicated namespace (not openshift-operators)
4. Fix OpenShift MCP server image reference in catalog
5. Document the 8 lessons learned we discovered (broker reload, scope gotcha, ext_proc ordering, etc.)
6. Acknowledge `x-mcp-virtualserver` filter chain limitation and recommend wristband as workaround

## Upstream Issues and PRs Filed

### MCP Lifecycle Operator — prerequisite auto-creation

The operator validates that ConfigMaps and ServiceAccounts exist but does not
create them, even when the catalog provides `runtimeMetadata.prerequisites`
with default content. Every deploy-from-catalog requires manual prerequisite
creation per namespace.

- **Issue:** https://github.com/kubernetes-sigs/mcp-lifecycle-operator/issues/226
- **PR:** https://github.com/kubernetes-sigs/mcp-lifecycle-operator/pull/227
  - Adds annotation-gated auto-creation of SA and ConfigMap
  - Validated on live RHOAI 3.4 / OCP 4.20 cluster
  - Found RBAC gap during live testing (controller-runtime needs list/watch for SA informers)
  - Limitation: auto-created ConfigMap is empty — CRD schema doesn't carry default content

### OGX / Llama Stack — Playground MCP auth token forwarding

The Playground collects JWT tokens for MCP servers (lock icon) but the
LSD pod does not forward them in the `Authorization` header. The MCP
tool runtime in `mcp.py` explicitly rejects Authorization in `mcp_headers`.
MCP servers behind an authenticated gateway return 401.

- **Upstream (ogx-ai/ogx):** Commented on existing [#5152](https://github.com/ogx-ai/ogx/issues/5152) with Playground evidence and live cluster test results
- **Distribution (opendatahub-io/ogx-distribution):** Filed [#415](https://github.com/opendatahub-io/ogx-distribution/issues/415) for the integration work to wire Playground JWT through to the `forward_headers` mechanism once upstream lands

### Catalog image (pending)

The built-in Red Hat MCP catalog has a broken image reference for the
OpenShift MCP server (`registry.redhat.io/openshift-mcp-beta/openshift-mcp-server-rhel9:0.2`
does not exist). Overridden with our custom catalog entry pointing to
`quay.io/redhat-user-workloads/ocp-mcp-server-tenant/openshift-mcp-server-release-03:latest`.
Jira to be filed separately through internal process.
