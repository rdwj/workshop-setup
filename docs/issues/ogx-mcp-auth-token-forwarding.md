# MCP server auth tokens from Playground UI not forwarded in tool call requests

## Summary

When using the Gen AI Studio Playground in RHOAI 3.4, the JWT auth token entered via the MCP server lock icon is not included in the `Authorization` header when the Llama Stack Distribution (LSD) pod makes tool call requests to MCP servers. This prevents using the Playground with MCP servers behind an authenticated gateway (e.g., Kuadrant MCP Gateway with AuthPolicy).

## Environment

- RHOAI 3.4.0 on OpenShift 4.20
- Llama Stack Distribution image: `quay.io/rhoai/odh-llama-stack-core-rhel9` (OGX 0.6.0.1+rhai0)
- MCP Gateway Operator v0.6.0 (Kuadrant)
- Keycloak (RHBK) v26.2.16 for JWT auth
- Tested with both local and remote model inference endpoints

## Steps to Reproduce

1. Deploy an MCP server (e.g., OpenShift MCP server) behind the MCP Gateway
2. Configure a Kuadrant AuthPolicy on the gateway requiring JWT authentication
3. Verify auth works from CLI: unauthenticated requests get 401, authenticated requests with `Authorization: Bearer <token>` get 200
4. In the RHOAI dashboard, create a Playground in Gen AI Studio
5. Add the MCP Gateway as an MCP server source (via `gen-ai-aa-mcp-servers` ConfigMap pointing to the gateway URL)
6. Click the lock icon on the MCP server entry and paste a valid JWT token
7. Ask the model to use an MCP tool (e.g., "List pods in the default namespace")

## Expected Behavior

The LSD pod should include the user's JWT in the `Authorization: Bearer <token>` header when making MCP protocol requests (`initialize`, `tools/list`, `tools/call`) to the MCP server URL.

## Actual Behavior

The LSD pod makes MCP requests without the `Authorization` header. The MCP Gateway returns HTTP 401 Unauthorized. The LSD catches this as `AuthenticationRequiredError` and the Playground displays "Streaming error" or "network error."

Error from LSD pod logs:

```
llama_stack/providers/utils/tools/mcp.py:196 in _create_session

AuthenticationRequiredError: Client error '401 Unauthorized' for url
'http://<gateway-endpoint>:8080/mcp'
```

The code path in `mcp.py:146` creates a new MCP session via `_create_session` but does not pass any auth headers from the user's Playground session context.

## Impact

- The Playground cannot be used with any MCP server that requires authentication
- This blocks the primary enterprise use case: MCP Gateway with identity-based tool access control
- Workaround is to connect the Playground directly to MCP servers via ClusterIP (bypassing the gateway), which eliminates all auth/authz enforcement

## Workaround

Register MCP servers in `gen-ai-aa-mcp-servers` with their direct in-cluster service URL instead of the gateway URL:

```yaml
data:
  OpenShift-MCP: |
    {
      "url": "http://openshift-mcp.<namespace>.svc.cluster.local:8080/mcp",
      "description": "OpenShift cluster tools (direct, no auth)"
    }
```

This bypasses the gateway and works, but provides no authentication or authorization.

## Suggested Fix

The MCP session creation in `llama_stack/providers/utils/tools/mcp.py` should accept and forward authorization headers. When the Playground UI collects an auth token for an MCP server, the BFF should pass it through to the LSD's MCP tool runtime provider, which should include it in the `headers` parameter of the streamable-http transport connection.

The `_create_session` method at line 146 already accepts a `headers` parameter — the issue is that the auth token collected by the UI never reaches this code path.

## Additional Context

- Tested with both remote model inference (vLLM on a separate cluster) and local model inference — same result. The issue is in the LSD → MCP server path, not the model path.
- The MCP Gateway's `.well-known/oauth-protected-resource` discovery endpoint correctly advertises the Keycloak authorization server, but the LSD does not implement OAuth resource discovery.
- Standalone MCP clients (e.g., custom agents using the `mcp` Python SDK with explicit `Authorization` headers) work correctly with the authenticated gateway.
