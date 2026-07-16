# feat: Create prerequisite resources from runtimeMetadata.prerequisites

**Repo:** kubernetes-sigs/mcp-lifecycle-operator
**Labels:** kind/feature

## Summary

When deploying MCP servers from the RHOAI MCP catalog, the MCPServer CR references prerequisite resources (ServiceAccount, ConfigMaps) that must already exist in the target namespace. The catalog metadata includes `runtimeMetadata.prerequisites` with suggested names, hints, and default content — but neither the operator nor the dashboard creates these resources. Users must manually create them per namespace before the MCPServer will reconcile.

## Current Behavior

The operator validates that referenced ConfigMaps, Secrets, and ServiceAccounts exist (in `validateConfig()`). If missing, it sets `Accepted: False, Reason: Invalid` with a message like:

```
failed to get ConfigMap openshift-mcp-server-config for storage mount at index 0:
ConfigMap "openshift-mcp-server-config" not found
```

Once the resources are manually created, the operator auto-recovers and reconciles successfully (via ConfigMap/Secret watches added in #92).

The catalog metadata already describes exactly what's needed:

```yaml
runtimeMetadata:
  prerequisites:
    serviceAccount:
      required: true
      suggestedName: mcp-viewer
      hint: "Needs 'view' ClusterRole for read-only cluster access"
    configMaps:
      - name: openshift-mcp-server-config
        mountAsFile: true
        mountPath: /etc/mcp-config
        keys:
          - key: config.toml
            required: true
            defaultContent: |
              log_level = 5
              port = "8080"
              read_only = true
              toolsets = ["core", "config"]
```

But neither the operator nor the RHOAI dashboard acts on this metadata.

## Proposed Behavior

When reconciling an MCPServer CR, the operator should optionally create prerequisite resources from `runtimeMetadata.prerequisites` if they don't exist. This could be gated by an annotation to avoid breaking existing behavior:

```yaml
metadata:
  annotations:
    mcp.x-k8s.io/auto-create-prerequisites: "true"
```

When enabled and prerequisites are defined:
- Create ConfigMaps with `defaultContent` for each key
- Create ServiceAccount with `suggestedName`
- Do not create ClusterRoleBindings (requires cluster-scoped permissions — leave to the deploying user or platform)

If `defaultContent` is not provided for a ConfigMap key, skip creation and fall through to the existing validation error.

## Impact

This reduces manual steps for catalog-based deployments. Currently, every deploy-from-catalog in a new namespace requires:

```bash
oc create serviceaccount mcp-viewer -n $NS
oc create clusterrolebinding mcp-viewer-$NS --clusterrole=view --serviceaccount=$NS:mcp-viewer
oc create configmap openshift-mcp-server-config -n $NS --from-literal=config.toml='...'
```

With this feature, only the ClusterRoleBinding remains manual (appropriate since it's a cluster-scoped security decision).

## Implementation Notes

- Creation logic would go in `validateConfig()` (in `mcpserver_controller_validation.go`) or a new `ensurePrerequisites()` called before validation
- The `runtimeMetadata` field may need to be added to the MCPServer CRD spec if not already present — or the prerequisites could be read from an annotation
- ConfigMap creation should use `defaultContent` from the prerequisites metadata, not guess
- ServiceAccount creation should use `suggestedName`, with the operator owning the resource (so it's cleaned up on MCPServer deletion)
- Unit tests should follow existing Ginkgo/Gomega patterns in `mcpserver_controller_storage_test.go`
- RBAC: the controller's ClusterRole needs `create` permission for ConfigMaps and ServiceAccounts in target namespaces

## Environment

- MCP Lifecycle Operator: latest release
- RHOAI 3.4.0 on OpenShift 4.20
- Tested with the OpenShift MCP Server catalog entry
