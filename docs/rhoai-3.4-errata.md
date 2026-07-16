# RHOAI 3.4 Automation Errata

## MCP Catalog & Playground Integration — Resolved

**Date:** 2026-05-27
**Status:** Resolved

### Dashboard flags required for MCP Catalog

Three additional OdhDashboardConfig flags are needed (not documented
in the installation guide):

```yaml
spec:
  dashboardConfig:
    mcpCatalog: true
    disableModelRegistry: false
    disableModelCatalog: false
```

Restart `rhods-dashboard` deployment after applying.

### MCP Catalog (AI Hub → MCP servers)

Populated via ConfigMap `mcp-catalog-sources` in `rhoai-model-registries`.
The ConfigMap has two data keys:

- `sources.yaml` — lists catalog sources with `id`, `name`, `type: yaml`,
  and a `yamlCatalogPath` pointing to another key in the same ConfigMap
- The catalog YAML key — contains `mcp_servers` array with full metadata

See `configmaps/mcp_catalog_sources.yaml` for a working example.

### MCP Playground Integration (Gen AI Studio → AI asset endpoints → MCP servers)

Controlled by ConfigMap `gen-ai-aa-mcp-servers` in
`redhat-ods-applications`. Cluster-wide, NOT namespace-scoped. Each key
is a server display name, value is JSON with `url` and `description`.

See `configmaps/genai-mcp-servers.yaml` for a working example.

### MCP Lifecycle Operator — Deploy from Catalog gaps

The MCP Lifecycle Operator (installed from GitHub, not OLM) creates
MCPServer CRs, but the "Deploy" button in the MCP Catalog only creates
the MCPServer CR — it does NOT create prerequisite resources:

- ConfigMaps referenced in `spec.config.storage` (e.g., server config)
- ServiceAccounts referenced in `spec.runtime.security`
- RBAC (ClusterRoles/Bindings) for the ServiceAccount

These must be created manually before or after clicking Deploy. This is
a Tech Preview limitation — the catalog metadata format supports
`runtimeMetadata.prerequisites` but the Lifecycle Operator doesn't
auto-create them yet.
