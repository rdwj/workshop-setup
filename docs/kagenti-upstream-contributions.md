# Kagenti Upstream Contributions

## Merged

- **kagenti/kagenti#1276** — fix(installer): Skip DataScienceCluster
  creation on brownfield RHOAI clusters. Approved by @Ladas,
  merged 2026-04-22.

## Issues Filed

- **kagenti/kagenti#1275** — MCP Gateway hostname hardcoded to
  `mcp.127-0-0-1.sslip.io`, not configurable for real clusters.
  Upstream broker fix landed in mcp-gateway v0.6.0; remaining work
  is in the kagenti Helm chart (`charts/kagenti/`). Plan to submit a
  PR making the hostname a configurable value. See comment:
  https://github.com/kagenti/kagenti/issues/1275#issuecomment-4300683124

## Resolved Upstream (no action needed)

The following items were identified during v0.1.2 testing but have
since been addressed in upstream releases:

1. **MCP Gateway `tools/call` forwarding** — Fixed in
   Kuadrant/mcp-gateway v0.6.0 (2026-04-16). The MCP Router now
   handles `tools/call` directly, routing to the upstream server and
   bypassing the Broker. The Broker only handles `initialize` and
   `tools/list` aggregation.

2. **GHCR login in installer** — The mcp-gateway Helm chart at
   `ghcr.io/kuadrant/charts/mcp-gateway` is now publicly accessible
   (verified at v0.6.0). The 403 pre-flight issue is moot if the
   installer tracks current chart versions.

3. **Keycloak admin password documentation** — The
   `secret_values.yaml.example` on main now clarifies that
   `keycloak.adminPassword` is "used by the AuthBridge
   client-registration sidecar," resolving the confusion with the
   Keycloak console password.
