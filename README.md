# OpenShift AI Workshop Setup

Automated cluster provisioning for OpenShift AI workshops. Sets up GPU-enabled clusters with RHOAI 3.2, 3.3, and 3.4, operator installations, and per-section prep for instructor-led training.

## End-to-End Instructor Workflow

### Step 1: Provision clusters from the Red Hat Demo System

Go to the [Red Hat Demo System catalog](https://catalog.demo.redhat.com/catalog?item=babylon-catalog-prod/sandboxes-gpte.sandbox-ocp.prod&utm_source=webapp&utm_medium=share-link) and order one **OCP4 Sandbox** per student.

Use these settings when ordering:

| Setting | Value |
|---------|-------|
| Control plane nodes | 3 |
| Control plane instance type | m6a.xlarge |
| Worker nodes | 3 |
| Worker instance type | m6a.4xlarge |

Order as many as you need (one per student). They take roughly 45-60 minutes to provision.

### Step 2: Export the cluster list

Once all clusters are provisioned, go to the **Users** page in the demo system. Select all clusters and copy the full contents of the page into a text file:

```
clusters/cluster_list.txt
```

This file contains the API URLs, service account tokens, kubeadmin passwords, bastion credentials, and AWS details for every cluster. It is gitignored and will not be committed.

### Step 3: Generate the Ansible inventory

Run the inventory generator script to parse the cluster list into the Ansible inventory format:

```bash
python3 scripts/generate_inventory.py
```

This reads `clusters/cluster_list.txt` and writes `ansible/inventory/clusters.yml` with one entry per cluster, using the long-lived service account tokens for authentication (these won't expire during the setup run).

Verify the result:

```bash
head -15 ansible/inventory/clusters.yml
grep -c "cluster-" ansible/inventory/clusters.yml   # should match your cluster count
```

### Step 4: Install prerequisites on your Mac

```bash
# Ansible and the Kubernetes collection
pip install ansible kubernetes
ansible-galaxy collection install kubernetes.core

# Verify
ansible --version
ansible-galaxy collection list kubernetes.core
```

### Step 5: Run the base cluster setup

```bash
cd ansible
ansible-playbook site.yml
```

This runs against all clusters in parallel (forks=25 by default) and installs:
- GPU MachineSet (g6e.4xlarge with nvidia.com/gpu taint)
- Node Feature Discovery operator
- NVIDIA GPU operator + ClusterPolicy
- Red Hat OpenShift AI operator + DataScienceCluster
- Web Terminal operator
- HTPasswd auth with `admin1` / `wfcatalog` cluster-admin user
- Waits for GPU node to report `nvidia.com/gpu` capacity

Typical runtime: 15-20 minutes (dominated by GPU node provisioning on AWS).

### Step 6: Run section prep playbooks

There are three prep playbooks. Which combination you run depends on which sections you are teaching.

| Playbook | What it creates | When to run |
|----------|----------------|-------------|
| `section-1-prep.yml` | `sample-project` namespace with a running Jupyter workbench (for workbench admin exercises in Section 1 Topic 4). | Always, when teaching either section. |
| `section-2-prep.yml` | `my-project` namespace, NVIDIA GPU HardwareProfile (for Section 2 accelerator verification). | Always, when teaching Section 2. Safe to run before Section 1 is taught — it does not conflict with any Section 1 exercise. |
| `section-1-complete.yml` | Pre-imports the InstructLab Code Server custom workbench image into `redhat-ods-applications`, matching what a student would have created in Section 1 Topic 2. | **Only when teaching Section 2 without first teaching Section 1.** Do NOT run this if Section 1 is being taught in the same session — it will spoil the Section 1 Topic 2 custom image import exercise. |

**Teaching both sections back-to-back** (same session, no break for re-running Ansible):

```bash
cd ansible
ansible-playbook section-1-prep.yml
ansible-playbook section-2-prep.yml
```

Students import the InstructLab image themselves in Section 1 Topic 2.

**Teaching only Section 2** (Section 1 was covered in a prior session, or being skipped):

```bash
cd ansible
ansible-playbook section-1-prep.yml
ansible-playbook section-1-complete.yml
ansible-playbook section-2-prep.yml
```

`section-1-prep.yml` is still run in this case so that `sample-project` and `sample-workbench` exist in the student's dashboard as evidence of prior work — useful if students have questions about material from the earlier session. `section-1-complete.yml` then adds the InstructLab ImageStream so that Section 2 Topic 2 follows the "skip to verify" path instead of re-doing the import.

### Step 7: If some clusters fail

Ansible creates a retry file for failed hosts:

```bash
ansible-playbook site.yml --limit @site.retry
```

### Step 8: Distribute credentials to students

Each student needs:
- OpenShift console URL (from the cluster list)
- OpenShift AI dashboard URL: `https://rhods-dashboard-redhat-ods-applications.apps.<cluster>.<domain>`
- Login: `admin1` / `wfcatalog` (for dashboard and `oc` CLI)
- Their cluster's `kubeadmin` password (as a fallback for the OpenShift web console)

Students should log in as `admin1` rather than `kubeadmin` because OpenShift maps `kubeadmin` to the internal identity `kube:admin`, and the colon in that name breaks group management commands used in the exercises.

## Repository Structure

```
ansible/                    # Ansible playbooks and roles
  site.yml                  # Base cluster setup (GPU, operators, RHOAI)
  section-1-prep.yml        # Prep for "Dashboard Admin Tasks"
  section-2-prep.yml        # Prep for "Admin Tasks for Users, Resources, Accelerators"
  section-1-complete.yml    # Section 1 catch-up (InstructLab image) — only when skipping Section 1
  inventory/clusters.yml    # Cluster credentials (gitignored — generate from cluster list)
  group_vars/all.yml        # Configurable variables (instance types, versions, timeouts)
  roles/workshop_cluster/   # Role with all setup tasks

auth/                       # HTPasswd auth manifests
namespaces/                 # Operator namespace definitions
operators/                  # NFD, GPU, RHOAI, Web Terminal, Authorino subscriptions
operands/                   # DataScienceCluster, NFD instance, Authorino instance
gpu-operand/                # NVIDIA ClusterPolicy
clusters/                   # Cluster provisioning data (gitignored)
scripts/                    # Utility scripts (inventory generator, etc.)

model/                      # Model deployment manifests
  deployment.yaml           # all-MiniLM-L6-v2 embedding model (TEI, CPU)
  reranker.yaml             # ms-marco-MiniLM-L12-v2 reranker (TEI, CPU)
  granite-llm.yaml          # Granite 3.3 8B Instruct (vLLM, GPU)
  gpt-oss-20b.yaml          # GPT-OSS-20B (vLLM, GPU, Red Hat AI Inference Server)

monitoring/                 # Grafana + Prometheus monitoring stack
  grafana-stack.yaml        # Grafana deployment, SA, RBAC, data source
  servicemonitors.yaml      # ServiceMonitors for vLLM endpoints
  thanos-route.yaml         # Thanos Querier route + metrics-reader SA for API access
  dashboards/
    vllm-gpu.json           # 18-panel Grafana dashboard

exercises/                  # YAML manifests used in class exercises
  hardware-profile-nvidia-gpu.yaml
  kueue-resource-flavor.yaml
  kueue-cluster-queue.yaml
  kueue-local-queue.yaml
  sample-workbench.yaml

docs/                       # Workshop documentation (reference copies)
  OpenShift AI Workshops - Original.md   # Original runbook (reference)
  OpenShift AI Workshops - Full.md       # Enhanced version with full walkthroughs
  # Course content maintained at: github.com/redhat-ai-americas/openshift-ai-workshop-advanced-3-2

setup.sh                    # Shell script for single-cluster setup (manual use)
setup-rhoai.sh              # GPU-free RHOAI setup (CPU-only clusters)
deploy-embedding-model.sh   # Deploy all-MiniLM-L6-v2 embedding model
deploy-reranker.sh          # Deploy ms-marco-MiniLM-L12-v2 reranker
deploy-granite.sh           # Deploy Granite 3.3 8B Instruct
deploy-gpt-oss.sh           # Deploy GPT-OSS-20B
deploy-monitoring.sh        # Deploy Grafana monitoring stack
```

## Section Prep Playbooks

Currently, prep playbooks exist for two sections:

- **Section 1:** Managing Administration Tasks from the OpenShift AI Dashboard
- **Section 2:** Managing OpenShift AI -- Admin Tasks for Users, Resources, Accelerators, and Workloads

Other workshop sections (Model Serving, Model Registries, Workbenches, Pipelines, etc.) do not yet have dedicated prep playbooks. The base `site.yml` provides the foundation that all sections need. Additional section prep playbooks can be added following the same pattern.

## Single-Cluster Setup (Shell Script)

For manual setup or testing on a single cluster:

```bash
oc login <api_url> -u <user> -p <password>
./setup.sh
```

The shell script does the same thing as `site.yml` but for the cluster you are currently logged into. It includes `[PASS]`/`[FAIL]` validation at each step.

## Configurable Variables

Edit `ansible/group_vars/all.yml` to adjust for different workshops:

| Variable | Default | Description |
|----------|---------|-------------|
| `gpu_instance_type` | `g6e.4xlarge` | AWS GPU instance type |
| `gpu_disk_size_gb` | `200` | Root volume size for GPU node |
| `gpu_replicas` | `1` | Number of GPU machines |
| `gpu_csv_name` | `gpu-operator-certified.v25.3.4` | GPU operator version |
| `rhoai_csv_name` | `rhods-operator.3.2.0` | RHOAI operator version |

Timeout values are also configurable if clusters are slow to provision.

## Model Deployments

Four models can be deployed independently using the shell scripts or Ansible playbooks:

| Model | Runtime | Hardware | Deploy script | Ansible playbook |
|-------|---------|----------|---------------|-----------------|
| all-MiniLM-L6-v2 (embedding) | HF TEI | CPU | `deploy-embedding-model.sh` | — |
| ms-marco-MiniLM-L12-v2 (reranker) | HF TEI | CPU | `deploy-reranker.sh` | — |
| Granite 3.3 8B Instruct | vLLM | GPU (L40S) | `deploy-granite.sh` | `gpu-model-serving.yml` |
| GPT-OSS-20B | vLLM (Red Hat AI Inference Server) | GPU (L40S) | `deploy-gpt-oss.sh` | `gpt-oss-serving.yml` |

The GPU models require at least one GPU node per model. The `gpu-model-serving.yml` playbook creates the first GPU node and deploys Granite. The `gpt-oss-serving.yml` playbook scales the GPU MachineSet to 2 replicas and deploys GPT-OSS.

## Monitoring

### Grafana Dashboard

Deploy with:

```bash
./deploy-monitoring.sh          # single cluster
cd ansible && ansible-playbook monitoring.yml  # fleet
```

This installs:
- User workload monitoring (OpenShift Prometheus scrapes user namespaces)
- ServiceMonitors for both vLLM endpoints
- Grafana with a pre-built 18-panel dashboard covering request throughput, latency percentiles (e2e, TTFT, inter-token), GPU utilization (DCGM), KV cache usage, prefix cache hit rates, and token throughput

**Grafana URL:** `https://grafana-grafana.apps.<cluster>.<domain>`
**Dashboard:** `https://grafana-grafana.apps.<cluster>.<domain>/d/vllm-gpu-dashboard`
**Login:** admin / admin (change on first login)

### Prometheus API for Coding Agents

The monitoring stack exposes a standard Prometheus HTTP API via the Thanos Querier route. This is the recommended way for coding agents or automated tools to query metrics programmatically.

**Endpoint:** `https://thanos-querier-openshift-monitoring.apps.<cluster>.<domain>`

**Authentication:** Bearer token from the `metrics-reader` ServiceAccount:

```bash
TOKEN=$(oc get secret metrics-reader-token -n openshift-monitoring -o jsonpath='{.data.token}' | base64 -d)
```

**Instant query:**

```bash
curl -sk -H "Authorization: Bearer $TOKEN" \
  "https://thanos-querier-openshift-monitoring.apps.<cluster>.<domain>/api/v1/query?query=<promql>"
```

**Range query:**

```bash
END=$(date -u +%s); START=$((END - 1800))
curl -sk -H "Authorization: Bearer $TOKEN" \
  "https://thanos-querier-openshift-monitoring.apps.<cluster>.<domain>/api/v1/query_range?query=<promql>&start=$START&end=$END&step=30"
```

**Key queries:**

| Metric | PromQL | Description |
|--------|--------|-------------|
| KV cache usage | `vllm:kv_cache_usage_perc` | 0-1 scale per model |
| Active requests | `vllm:num_requests_running` | Currently decoding |
| Waiting requests | `vllm:num_requests_waiting` | Queued for processing |
| Prefix cache hit rate | `rate(vllm:prefix_cache_hits_total[5m]) / rate(vllm:prefix_cache_queries_total[5m])` | Ratio of cached prompt prefixes |
| Cached tokens/sec | `rate(vllm:prompt_tokens_cached_total[5m])` | Prompt tokens served from cache |
| E2E latency p95 | `histogram_quantile(0.95, rate(vllm:e2e_request_latency_seconds_bucket[5m]))` | Per model |
| Time to first token p95 | `histogram_quantile(0.95, rate(vllm:time_to_first_token_seconds_bucket[5m]))` | Per model |
| Token throughput | `rate(vllm:generation_tokens_total[1m])` | Generation tokens/sec |
| GPU utilization | `DCGM_FI_DEV_GPU_UTIL` | Per GPU, 0-100% |
| GPU memory | `DCGM_FI_DEV_FB_USED` | MiB per GPU |

All vLLM metrics include a `model_name` label (`RedHatAI/granite-3.3-8b-instruct` or `RedHatAI/gpt-oss-20b`) for filtering. Responses are standard Prometheus JSON: `{"status":"success","data":{"resultType":"vector","result":[...]}}`.

## Additional Playbooks

### Models as a Service (MaaS)

Deploy Models as a Service infrastructure on RHOAI 3.4 clusters:

```bash
cd ansible
ansible-playbook maas-setup.yml
```

This playbook configures:
- Red Hat Connectivity Link Operator (RHCL) and Kuadrant
- PostgreSQL connection (external database required)
- Gateway and GatewayClass resources
- Authorino TLS configuration
- Default Tenant and MaaSSubscription CRs

**Prerequisites:** RHOAI 3.4 base installation, external PostgreSQL 14+ database

### MCP Catalog and Lifecycle Management

Enable the MCP ecosystem (MCP Gateway, MCP Lifecycle Operator, AI Hub catalog):

```bash
cd ansible
ansible-playbook mcp-setup.yml
```

This playbook configures:
- MCP Gateway deployment (depends on RHCL/Kuadrant from MaaS setup)
- MCP Lifecycle Operator installation
- AI Hub MCP Catalog (ConfigMap-based catalog population)
- Dashboard feature flags: `mcpCatalog`, `disableModelRegistry`, `disableModelCatalog`

**Prerequisites:** RHOAI 3.4 base installation, MaaS setup recommended (shares RHCL/Kuadrant infrastructure)

### OGX / LlamaStack Operator

Deploy the LlamaStack Operator (OGX) with MinIO storage and optional Kagenti:

```bash
cd ansible
ansible-playbook ogx-setup.yml
```

This playbook configures:
- MinIO S3-compatible storage
- LlamaStack Operator enablement in DataScienceCluster
- LlamaStackDistribution CR with model and tool configuration
- Optional: Kagenti deployment (agent framework)

**Prerequisites:** RHOAI 3.4 base installation with GPU support, Service Mesh 3.x, cert-manager Operator

### Model Catalog and GPU as a Service

Enable the Model Catalog dashboard feature and deploy GPU-backed models:

```bash
cd ansible
ansible-playbook model-catalog-setup.yml
```

This playbook configures:
- Model Catalog dashboard flags in OdhDashboardConfig
- GPU-backed model deployment via MaaS
- Sample MaaSSubscription with GPU model access

**Prerequisites:** RHOAI 3.4 base installation, MaaS setup, GPU infrastructure
