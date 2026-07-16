# Perses Dashboard Datasource Setup for MaaS

When the MaaS controller creates Perses dashboards (Cluster, Models, Usage), it does NOT create the corresponding `PersesDatasource` in every namespace. The Usage dashboard in `redhat-ods-applications` works because the MaaS controller creates a datasource there. The Cluster and Models dashboards in `redhat-ods-monitoring` need a manually-created datasource.

## Architecture

```
Dashboard CR (redhat-ods-monitoring/dashboard-0-cluster-admin)
  panels reference: {kind: PrometheusDatasource}  (no name = use default)
      │
      ▼
PersesDatasource CR (redhat-ods-monitoring/thanos-querier)
  default: true
  proxy.secret: "thanos-querier-secret"   ← Perses-internal name
  proxy.url: https://thanos-querier...svc:9092?namespace=models-as-a-service
      │
      ▼
K8s Secret (redhat-ods-monitoring/thanos-querier-datasource-secret)
  data.Authorization: Bearer <prometheus-k8s SA token>
      │  synced by Perses Operator
      ▼
Perses Internal Secret (/perses/secrets/redhat-ods-monitoring/thanos-querier-secret.yaml)
  tlsConfig.ca: <from configmap>
      │
      ▼
Perses Server (openshift-operators/perses-0, SA: perses-sa)
  proxies PromQL queries to Thanos Querier
```

## Key Gotchas

1. **Secret naming**: The Perses operator derives the internal secret name from the datasource CR name (not the K8s secret name). A datasource named `thanos-querier` creates an internal secret named `thanos-querier-secret`. The `proxy.spec.secret` field must reference this **internal** name, not the K8s secret name.

2. **Namespace in Thanos URL**: Port 9092 on Thanos Querier requires a `?namespace=` parameter for tenant isolation. Without it, queries return "Bad Request". Use `?namespace=models-as-a-service` for model metrics.

3. **CA ConfigMap**: Must exist in the datasource namespace with the `service.beta.openshift.io/inject-cabundle: "true"` annotation so OpenShift injects the service CA.

4. **Perses SA RBAC**: The `perses-sa` service account in `openshift-operators` needs `get/list/watch` on secrets in both its own namespace and the datasource namespace. The `perses-operator` SA already has this but `perses-sa` does not by default.

## Setup Steps

```bash
NS="redhat-ods-monitoring"

# 1. CA ConfigMap (auto-injected by OpenShift)
oc apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-web-tls-ca
  namespace: $NS
  annotations:
    service.beta.openshift.io/inject-cabundle: "true"
EOF

# 2. Bearer token secret for Thanos access
TOKEN=$(oc create token prometheus-k8s -n openshift-monitoring --duration=8760h)
oc create secret generic thanos-querier-datasource-secret \
  -n $NS --from-literal=Authorization="Bearer $TOKEN"

# 3. RBAC for Perses SA
oc apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: perses-secret-reader
  namespace: $NS
rules:
  - apiGroups: [""]
    resources: ["secrets"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: perses-secret-reader
  namespace: $NS
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: perses-secret-reader
subjects:
  - kind: ServiceAccount
    name: perses-sa
    namespace: openshift-operators
EOF

# 4. PersesDatasource CR
oc apply -f - <<EOF
apiVersion: perses.dev/v1alpha2
kind: PersesDatasource
metadata:
  name: thanos-querier
  namespace: $NS
spec:
  client:
    tls:
      caCert:
        certPath: service-ca.crt
        name: prometheus-web-tls-ca
        type: configmap
      enable: true
  config:
    default: true
    display:
      name: Thanos Querier
    plugin:
      kind: PrometheusDatasource
      spec:
        proxy:
          kind: HTTPProxy
          spec:
            secret: thanos-querier-secret
            url: https://thanos-querier.openshift-monitoring.svc:9092?namespace=models-as-a-service
        scrapeInterval: 30s
EOF
```

Note: `proxy.spec.secret` is `thanos-querier-secret` (the Perses-internal name derived from the datasource CR name), NOT `thanos-querier-datasource-secret` (the K8s secret name).
