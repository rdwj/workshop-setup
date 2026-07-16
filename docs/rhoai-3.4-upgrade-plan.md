# RHOAI 3.4 Upgrade & Feature Enablement Plan

**Status:** Complete — all phases implemented and tested
**Date:** 2026-05-26
**Branch:** feature/gemma4-fips-fix

## Overview

Upgrade the workshop-setup Ansible automation from RHOAI 3.3 to 3.4, and add
optional playbooks for the new 3.4 capabilities. Each phase is an independent
playbook (or set of changes) that can be developed, tested, and merged
separately.

### Component Map

| Component | Phase | Maturity in 3.4 | Has Guide? |
|---|---|---|---|
| RHOAI 3.4 base install | 1 | GA | Yes (PDF) |
| Models as a Service (MaaS) | 2 | GA | Yes (PDF) |
| MCP Catalog / AI Hub | 3 | Developer Preview | Blog only |
| MCP Operator (Lifecycle) | 3 | Developer Preview | GitHub repo |
| MCP Gateway | 3 | Tech Preview | GitHub repo |
| OGX / LlamaStack Operator | 4 | GA (DSC component) | Partial (DSC docs) |
| Kagenti | 4 | Community | Existing scripts |
| Model Catalog (AI Hub) | 5 | GA | Docs link |
| GPU as a Service | 5 | Depends on MaaS | Part of MaaS guide |

---

## Phase 1: RHOAI 3.4 Base Installation

**Goal:** Run `ansible-playbook site.yml -e rhoai_version=3.4` and get a
working RHOAI 3.4 cluster with the same components we enable today.

**Risk:** Low — the version matrix pattern is already proven for 3.2→3.3.

### Key Deltas from 3.3

- **OpenShift version requirement shifts to 4.19–4.20** (was 4.17–4.19)
- **Dashboard URL changed** to `https://rh-ai.apps.<cluster-domain>`
  (old URLs auto-redirect, but docs/scripts should reference the new one)
- **DSC spec** gains `kserve.modelsAsService` sub-field and `kueue` gets
  `defaultClusterQueueName` / `defaultLocalQueueName` fields
- **CA bundle default** changed for upgrades from 2.7 (not relevant for
  fresh installs, but worth noting)

### Tasks

1. **Add 3.4 entry to `group_vars/all.yml`**
   - New CSV name (need to check operator catalog for exact string — likely
     `rhods-operator.3.4.0` or `rhods-operator.3.4.1`)
   - Channel: `fast-3.x` (unchanged)
   - Set as new default (`rhoai_version: "3.4"`)

2. **Create `operands/datasciencecluster-3.4.yaml`**
   - Start from 3.3 copy
   - Add `kserve.modelsAsService.managementState: Removed` (off by default;
     Phase 2 enables it)
   - Add `kueue.defaultClusterQueueName: default` and
     `kueue.defaultLocalQueueName: default`
   - Verify component list matches 3.4 docs (14 components)

3. **Check operator dependency versions**
   - GPU Operator: currently `v25.3.4` — verify compatibility with OCP 4.19+
   - NFD Operator: `stable` channel — should auto-resolve
   - Authorino: `tech-preview-v1` channel — check if graduated to GA
   - Web Terminal: `fast` channel — should auto-resolve

4. **Update namespaces if needed**
   - 3.4 introduces `models-as-a-service` namespace (Phase 2, not base)
   - Base namespaces unchanged

5. **Validate section prep playbooks still work**
   - `section-1-prep.yml`, `section-2-prep.yml`, `section-1-complete.yml`
   - HardwareProfile API should be stable
   - Workbench API should be stable

6. **Update README** with 3.4 as supported version

### Open Questions

- [ ] Exact RHOAI 3.4 CSV name — need to query the operator catalog on a
  4.19+ cluster
- [ ] Has Authorino operator channel changed from `tech-preview-v1`?
- [ ] GPU Operator version for OCP 4.19+ — same `v25.3.4` or newer?

---

## Phase 2: Models as a Service (MaaS)

**Goal:** New playbook `maas-setup.yml` that configures MaaS end-to-end on a
cluster that already has RHOAI 3.4 installed.

**Risk:** Medium — MaaS has significant prerequisites (Connectivity Link
Operator, PostgreSQL, Gateway, Authorino TLS). This is the most complex phase.

### Prerequisites (installed by the playbook)

1. **Red Hat Connectivity Link Operator v1.2+** in `openshift-operators`
2. **Kuadrant CR** in `kuadrant-system` namespace
3. **PostgreSQL 14+** — external database, reachable from cluster
4. **GatewayClass** resource (`openshift.io/gateway-controller`)
5. **Gateway** named `maas-default-gateway` in `openshift-ingress` with
   required annotations
6. **User Workload Monitoring** enabled on the cluster
7. **Authorino TLS** configured between MaaS API and Authorino

### New Manifests Needed

```
maas/
├── connectivity-link-operator.yaml    # Operator Subscription
├── kuadrant-cr.yaml                   # Kuadrant instance
├── maas-db-secret.yaml                # PostgreSQL connection (template)
├── gateway-class.yaml                 # GatewayClass
├── maas-gateway.yaml                  # Gateway in openshift-ingress
├── maas-namespace.yaml                # models-as-a-service namespace
├── default-tenant.yaml                # Tenant CR
├── default-subscription.yaml          # MaaSSubscription CR (template)
└── authorino-tls-patch.yaml           # Authorino TLS for MaaS
```

### Tasks

1. **Create Connectivity Link Operator subscription manifest**
2. **Create Kuadrant CR manifest**
3. **Create Gateway + GatewayClass manifests**
4. **Create Authorino TLS patching tasks** (annotate service, patch CR,
   set env vars on deployment)
5. **Create MaaS database secret template** — PostgreSQL connection URL;
   user provides the database, we create the secret
6. **Enable MaaS in DSC** — patch or apply updated DSC with
   `kserve.modelsAsService.managementState: Managed`
7. **Configure OdhDashboardConfig** — enable `modelAsService`,
   `maasAuthPolicies`, `genAiStudio`
8. **Create default Tenant CR** in `models-as-a-service` namespace
9. **Create sample MaaSSubscription** (optional, for workshop demos)
10. **Write `ansible/maas-setup.yml`** playbook orchestrating above
11. **Add PostgreSQL provisioning notes** to README (out of scope for
    automation — customer provides the DB)

### New CRDs to Understand

| CRD | API Group | Purpose |
|---|---|---|
| `MaaSSubscription` | `maas.opendatahub.io` | Quota/access (replaces 3.3 tiers) |
| `MaaSAuthPolicy` | `maas.opendatahub.io` | Gateway auth policies |
| `MaaSModelRef` | `maas.opendatahub.io` | Model→inference server mapping |
| `ExternalModel` | `maas.opendatahub.io/v1alpha1` | External LLM providers (Tech Preview) |
| `Tenant` | `maas.opendatahub.io` | Tenant settings (API keys, OIDC, gateway) |

### Open Questions

- [ ] How to handle PostgreSQL — provision in-cluster (dev/workshop) vs.
  external (production)?
- [ ] Default MaaSSubscription token limits for workshops?
- [ ] Which models to publish via MaaS by default?
- [ ] ExternalModel support — do we want to configure OpenAI/Anthropic
  routing for workshops?

---

## Phase 3: MCP Catalog, MCP Operator & MCP Gateway

**Goal:** New playbook `mcp-setup.yml` that enables the MCP ecosystem on a
3.4 cluster.

**Risk:** Medium-High — MCP Lifecycle Operator is Developer Preview, MCP
Gateway is Tech Preview. APIs may change.

### Components

**MCP Lifecycle Operator**
- GitHub: https://github.com/kubernetes-sigs/mcp-lifecycle-operator
- Handles automated deployment of MCP servers from the catalog
- Developer Preview in 3.4

**MCP Gateway**
- GitHub: https://github.com/Kuadrant/mcp-gateway
- Identity-aware routing, per-tool metrics
- Tech Preview in 3.4
- Likely depends on Connectivity Link / Kuadrant (shared with MaaS)

**AI Hub / MCP Catalog**
- Dashboard feature — discover and deploy MCP servers
- Pre-loaded with Red Hat, partner, and community servers
- Uses streamable HTTP transport

### Available MCP Servers in Catalog

| Tier | Server | Purpose |
|---|---|---|
| Red Hat | OpenShift | Cluster state, workload management |
| Red Hat | Ansible Automation Platform | Playbook triggers, job status |
| Red Hat | Lightspeed | Platform intelligence |
| Partner | Confluent Cloud | Kafka/Flink operations |
| Partner | EDB Postgres AI | Database operations |
| Partner | IBM Terraform | IaC management |
| Partner | Microsoft Azure | Azure resource management |
| Partner | Dynatrace | Performance monitoring |
| Community | MongoDB | Document DB connectivity |
| Community | MariaDB | Relational DB connectivity |

### Tasks

1. **Research MCP Lifecycle Operator installation** — check GitHub repo for
   OLM integration or manual install
2. **Research MCP Gateway installation** — may come with Connectivity Link
   Operator (shared infra with MaaS)
3. **Enable AI Hub in dashboard** — check OdhDashboardConfig flags
4. **Create `ansible/mcp-setup.yml`** playbook
5. **Test deploying an MCP server from the catalog** via the dashboard
6. **Document which MCP servers are useful for workshops**

### Open Questions

- [ ] Is MCP Lifecycle Operator installed via OLM or bundled with RHOAI?
- [ ] Does MCP Gateway share infrastructure with MaaS (Kuadrant)?
- [ ] What OdhDashboardConfig flags enable AI Hub / MCP Catalog?
- [ ] Can MCP servers be deployed via CLI/API or only through the dashboard?

---

## Phase 4: OGX (LlamaStack) & Kagenti

**Goal:** New playbook `ogx-setup.yml` that deploys the LlamaStack Operator
and optionally Kagenti on top.

**Risk:** Medium — LlamaStack Operator is GA in the DSC but has external
dependencies (Service Mesh 3.x, cert-manager, S3).

### LlamaStack Operator (OGX)

Already a DSC component (`llamastackoperator`). Currently set to `Removed`
in our DSC manifests.

**Prerequisites:**
- OpenShift Service Mesh 3.x
- cert-manager Operator
- NFD Operator + NVIDIA GPU Operator (already handled by Phase 1)
- S3-compatible storage

**To enable:**
- Set `llamastackoperator.managementState: Managed` in DSC
- Deploy `LlamaStackDistribution` CR with model, safety, and tool config
- Configure CA bundle via `spec.server.tlsConfig.caBundle` if needed

### Kagenti

Kubernetes-native agent framework built on LlamaStack. We already have
`deploy-kagenti.sh` and lessons learned captured in memory.

**Known issues (from prior work):**
- `tools/call` not forwarded in MCP Gateway v0.1.2 — use direct ClusterIP
- Tool registrations are in-memory — lost on restart
- Route timeouts need 300s+ annotation

### Tasks

1. **Create Service Mesh 3.x operator subscription manifest**
2. **Create cert-manager operator subscription manifest**
3. **Create S3 storage configuration** (MinIO for workshops, or external)
4. **Create LlamaStackDistribution CR template**
5. **Create Kagenti deployment manifest** (Ansible version of
   `deploy-kagenti.sh`)
6. **Write `ansible/ogx-setup.yml`** playbook
7. **Document known limitations** (tool persistence, MCP gateway routing)

### Open Questions

- [ ] Which LlamaStack distribution to use? (`starter` had issues in OGX
  v0.9.0 — see memory)
- [ ] S3 storage for workshops — in-cluster MinIO or external?
- [ ] Which tools to pre-register for workshop demos?

---

## Phase 5: Model Catalog (AI Hub) & GPU as a Service

**Goal:** Enable the model catalog in AI Hub and configure GPU sharing for
MaaS model deployments.

**Risk:** Low-Medium — mostly dashboard configuration and extending MaaS.

### Model Catalog (AI Hub)

- Browse and deploy models from the dashboard
- Includes Red Hat models (Granite family), partner models, community models
- Docs: https://docs.redhat.com/en/documentation/red_hat_openshift_ai_self-managed/3.4/html/working_with_the_model_catalog/

### GPU as a Service

GPU as a Service is the pattern of exposing GPU-backed model inference
through the MaaS subscription model. This combines:
- GPU infrastructure (Phase 1)
- MaaS subscriptions with token limits (Phase 2)
- Model deployment via MaaS (`LLMInferenceService` or vLLM runtime)

### Tasks

1. **Enable Model Catalog in OdhDashboardConfig** — verify flags
2. **Deploy a model from the catalog** via dashboard to validate flow
3. **Create GPU-backed MaaS model deployment** — deploy a Granite or
   similar model and publish it through MaaS
4. **Create sample MaaSSubscription with GPU model access**
5. **Document the GPU as a Service workflow** for workshop instructors
6. **Write `ansible/model-catalog-setup.yml`** if automation is needed
   beyond dashboard config

### Open Questions

- [ ] Is Model Catalog enabled by default in 3.4 or does it need a flag?
- [ ] Does GPU as a Service have its own CRDs or is it purely MaaS + GPU?
- [ ] Which models should we pre-deploy from the catalog for workshops?

---

## Implementation Order & Dependencies

```
Phase 1: RHOAI 3.4 Base
    │
    ├──→ Phase 2: MaaS ──→ Phase 5: Model Catalog + GPU as a Service
    │         │
    │         └──→ Phase 3: MCP Catalog (shares Connectivity Link/Kuadrant)
    │
    └──→ Phase 4: OGX / Kagenti (needs GPU from Phase 1)
```

Phase 1 is the prerequisite for everything. After that:
- Phases 2 and 4 are independent of each other
- Phase 3 shares infrastructure with Phase 2 (Connectivity Link, Kuadrant)
- Phase 5 depends on Phase 2

### Recommended Execution Order

1. **Phase 1** — smallest delta, highest value, unblocks everything
2. **Phase 2** — largest scope, most new manifests, unblocks Phases 3 and 5
3. **Phase 4** — independent of MaaS, can be developed in parallel with 2
4. **Phase 3** — depends on Phase 2 infra, Developer Preview so may evolve
5. **Phase 5** — finishing touches, mostly dashboard config

---

## What We Don't Have Docs For Yet

Some components aren't covered in the two PDF guides or the blog post.
We'll need to research these as we hit each phase:

| Component | Source |
|---|---|
| MCP Lifecycle Operator install | GitHub repo + OCP docs |
| MCP Gateway install | GitHub repo + Kuadrant docs |
| OGX / LlamaStack detailed setup | RHOAI 3.4 docs (not in install PDF) |
| Kagenti on 3.4 | Community docs + our prior experience |
| Model Catalog dashboard flags | RHOAI 3.4 dashboard docs |
| GPU as a Service patterns | MaaS guide + model serving docs |
| Exact 3.4 CSV version | Operator catalog query on live cluster |

---

## Branch Strategy

- `feature/rhoai-3.4-base` — Phase 1
- `feature/rhoai-3.4-maas` — Phase 2
- `feature/rhoai-3.4-mcp` — Phase 3
- `feature/rhoai-3.4-ogx` — Phase 4
- `feature/rhoai-3.4-model-catalog` — Phase 5

Each phase gets its own PR against `main`. Phases 2–5 stack on Phase 1.

---

## Completion Notes

All 5 phases were successfully implemented and tested on an OCP 4.20.22 cluster with RHOAI 3.4:

**Phase 1: RHOAI 3.4 Base Installation**
- CSV name: `rhods-operator.3.4.1`
- Operator channel: `fast-3.x`
- DataScienceCluster updated with `kserve.modelsAsService` and `kueue` default queue fields
- Dashboard URL confirmed: `https://rh-ai.apps.<cluster>.<domain>`

**Phase 2: Models as a Service (MaaS)**
- RHCL Operator and Kuadrant deployed
- Gateway architecture: ClusterIP + passthrough Routes (not LoadBalancer)
- MaaS Gateway required direct ClusterIP access from Routes due to OpenShift ingress controller limitations
- PostgreSQL connection secret templated for external database
- Authorino TLS configured successfully

**Phase 3: MCP Catalog, MCP Operator & MCP Gateway**
- MCP Gateway deployed via RHCL/Kuadrant shared infrastructure
- MCP Lifecycle Operator installed from GitHub release (not OLM)
- AI Hub MCP Catalog populated via ConfigMap pattern (not via operator)
- Dashboard flags discovered: `mcpCatalog`, `disableModelRegistry`, `disableModelCatalog`

**Phase 4: OGX / LlamaStack Operator**
- MinIO deployed for S3-compatible storage
- LlamaStack Operator enabled in DataScienceCluster
- LlamaStackDistribution CR with `distribution.name: starter` initially failed (see OGX v0.9.0 gotchas in memory)
- Kagenti deployment optional (community component)

**Phase 5: Model Catalog & GPU as a Service**
- Model Catalog dashboard flags identified and enabled
- GPU-backed model deployment via MaaS subscriptions tested
- MaaSSubscription token limits configured for workshop use

**Key Operational Lessons:**
- See `docs/mcp-gateway-lessons-learned.md` for detailed MCP Gateway routing patterns
- MaaS Gateway requires ClusterIP + passthrough Routes (not LoadBalancer) in OpenShift
- MCP Catalog uses ConfigMap population pattern (not an operator-managed catalog)
- Dashboard feature flags vary between 3.2/3.3 and 3.4 — always verify with OdhDashboardConfig CRD

**Testing Environment:**
- OpenShift Container Platform 4.20.22
- RHOAI 3.4.1
- GPU nodes: g6e.4xlarge (AWS) with NVIDIA L40S
- Cluster provisioned via Red Hat Demo System
