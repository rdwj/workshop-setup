# PR Plan: `feature/rhoai-embedding-setup` → `main`

**Status:** Planned, not yet executed.
**Branch to split:** `feature/rhoai-embedding-setup` (5 commits ahead of `main`)
**Drafted:** 2026-04-08

## Context

Today's work added several distinct pieces of functionality to this repo, all stacked on a single feature branch (`feature/rhoai-embedding-setup`) because we were moving quickly. The branch name has since drifted from its scope — it now covers GPU-free RHOAI setup, embedding model deployment, Authorino operator, cross-encoder reranker, and a section-1 catch-up playbook.

Before opening PR(s), we want to split the work into logical units that match how reviewers would want to see it.

## Commits on the branch

| Commit | Subject |
|---|---|
| `3a30222` | Add GPU-free RHOAI setup and embedding model deployment |
| `af3138b` | Add Authorino operator to RHOAI setup |
| `91b66ff` | Add MS-MARCO cross-encoder reranker deployment |
| `38f21dc` | Add section-1-complete catch-up playbook for skipping Section 1 |
| `dd5b79e` | Add authorino namespace to namespaces.yaml |

## Options considered

### Option A (recommended): Two PRs

Logical separation without excessive overhead.

**PR 1 — CPU-only RHOAI deployment with model serving and Authorino**
- Commits: `3a30222`, `af3138b`, `dd5b79e`, `91b66ff` (4 commits)
- Rename branch: `feature/rhoai-embedding-setup` → `feature/rhoai-cpu-model-serving`
- Base: `main`
- Scope: GPU-free `setup-rhoai.sh`, TEI embedding model, TEI cross-encoder reranker, Red Hat Authorino operator + instance, `namespaces.yaml` fix.
- Rationale: all about running RHOAI on CPU with additional model serving workloads. Pieces build on each other (setup → Authorino hooks into setup → models use the setup).

**PR 2 — Section-1-complete catch-up playbook**
- Commits: `38f21dc` (1 commit, cherry-picked onto a fresh branch from `main`)
- New branch: `feature/section-1-catchup-playbook`
- Base: `main`
- Scope: `ansible/section-1-complete.yml`, README running-pattern documentation.
- Rationale: workshop automation for the Ansible multi-cluster setup, completely independent of model serving. Can be reviewed, merged, and used without any of the model infrastructure.

### Option B: Four PRs

One PR per logical change. Clean history but more overhead and introduces a stacked-PR dependency.

1. GPU-free setup + embedding model (`3a30222`) — base = `main`
2. Authorino operator (`af3138b` + `dd5b79e`) — depends on PR 1, needs stacked PR or wait
3. Reranker (`91b66ff`) — independent, base = `main`
4. Section-1-complete (`38f21dc`) — independent, base = `main`

**Why not chosen:** The PR 1 → PR 2 dependency is annoying to manage, and fine-grained review isn't necessary on a solo project.

### Option C: Single PR

Rename the branch to something descriptive and PR the whole thing as one unit.

**Why not chosen:** Scope is large enough that a single PR description would sprawl. Two logically distinct purposes (model serving vs. workshop automation) are better reviewed separately.

## Decision: Option A

Two PRs. Both can be opened against `main` independently and merged in either order.

## Mechanical plan

### Step 1: Rename the current branch

Fixes the stale branch name.

```bash
git branch -m feature/rhoai-embedding-setup feature/rhoai-cpu-model-serving
git push origin -u feature/rhoai-cpu-model-serving
git push origin --delete feature/rhoai-embedding-setup
```

### Step 2: Create the workshop automation branch from `main`

```bash
git checkout main
git pull
git checkout -b feature/section-1-catchup-playbook
git cherry-pick 38f21dc
git push -u origin feature/section-1-catchup-playbook
```

### Step 3: Remove commit `38f21dc` from the model-serving branch

This is a history rewrite. Safe because nobody else is working on this branch, but flag to be aware of.

```bash
git checkout feature/rhoai-cpu-model-serving
git rebase -i <commit-before-38f21dc>  # drop 38f21dc
git push --force-with-lease
```

Note: `38f21dc` sits between `91b66ff` (reranker) and `dd5b79e` (authorino namespace fix). The rebase needs to drop the middle commit cleanly. If there are conflicts, resolve them — no shared files between the section-1-complete playbook and the other work, so conflicts are unlikely.

### Step 4: Open the PRs

Use the draft titles and bodies below.

## Draft PR titles and bodies

### PR 1: `feature/rhoai-cpu-model-serving` → `main`

**Title:**

```
Add CPU-only RHOAI setup with embedding model, reranker, and Authorino
```

**Body:**

```markdown
## Summary

Adds a lightweight path for running Red Hat OpenShift AI on CPU-only clusters, along with model serving infrastructure and Authorino as standard auth infrastructure.

## What's included

### `setup-rhoai.sh` — GPU-free single-cluster setup
A stripped-down version of `setup.sh` that skips GPU MachineSet creation, the NVIDIA GPU operator, and the GPU ClusterPolicy. Installs NFD, RHOAI, Web Terminal, and Authorino operators with waits and checkpoints. Useful for clusters where GPU is not needed (small models, dashboards, dev/test).

### HF Text Embeddings Inference (TEI) model deployments
- **Embedding model** (`model/deployment.yaml`, `deploy-embedding-model.sh`): Deploys `sentence-transformers/all-MiniLM-L6-v2` as a CPU embedding service with a 10Gi PVC for model caching. Exposes `/embed`.
- **Cross-encoder reranker** (`model/reranker.yaml`, `deploy-reranker.sh`): Deploys `cross-encoder/ms-marco-MiniLM-L12-v2` using the same TEI image. Exposes `/rerank`.

Both run on CPU, deploy to separate namespaces (`embedding-model`, `reranker-model`), and were chosen over vLLM because vLLM requires GPU (reference deployment in the `advanced-rag` project assumed GPU infrastructure we don't have in the CPU-only path).

### Red Hat Authorino operator
- `operators/authorino-operator.yaml` — Subscription to `tech-preview-v1` channel (the Red Hat-supported channel used by RHOAI for model auth).
- `operands/authorino-instance.yaml` — Cluster-wide Authorino instance with TLS disabled (dev/training).
- `setup-rhoai.sh` installs the operator and waits for its CSV and instance.
- Added to `namespaces/namespaces.yaml` so `site.yml` also creates the namespace.

Installed as standard infrastructure so downstream projects can issue API key Secrets and create `AuthConfig` CRs against a ready Authorino instance, without each project having to install the operator itself.

## Why the TEI choice (not vLLM)
The reference deployment we had used vLLM with `--task embed` / `--task score` flags, but the reference required `nvidia.com/gpu` and a GPU toleration. Our cluster path is intentionally CPU-only. TEI has native cross-encoder support (`/rerank` endpoint) and runs on CPU, and we were already using it for the embedding model, so using it for the reranker too keeps the stack consistent.

## Test plan

- [x] Ran `setup-rhoai.sh` against a fresh RHPDS cluster — all operators and operands come up green.
- [x] Ran `deploy-embedding-model.sh` and verified `/embed` returns 384-dim vectors.
- [x] Ran `deploy-reranker.sh` and verified `/rerank` returns correctly-ordered relevance scores.
- [x] Verified Authorino operator CSV reaches `Succeeded` and the `Authorino` instance deployment reaches `readyReplicas: 1`.
- [x] Verified the fleet Ansible site.yml run works with the new `namespaces.yaml` authorino entry (confirmed across 30 clusters).

## Follow-ups (out of scope for this PR)

- Protecting the embedding/reranker endpoints with Authorino AuthConfigs is not done in this PR. The infrastructure is ready, but the consuming app will decide when to wire up auth.
```

### PR 2: `feature/section-1-catchup-playbook` → `main`

**Title:**

```
Add section-1-complete catch-up playbook for Section-2-only sessions
```

**Body:**

```markdown
## Summary

Adds a new Ansible playbook that applies cluster state as if Section 1 of the workshop was completed by a student, for the case where we teach Section 2 without teaching Section 1 earlier in the same session.

## The problem

Section 2 Topic 2 (Custom Images) has a "skip to step 4 if you already imported this image in Section 1" path, but it assumes the dashboard's BYON ImageStream already exists in `redhat-ods-applications`. When teaching Section 2 standalone, there's no Section 1 to import it. Students would have to follow the full import flow, which is redundant with material from the earlier session.

This catch-up playbook pre-creates the exact ImageStream the RHOAI dashboard's "Import new image" form would produce, so the "skip to verify" path works.

## What's included

### `ansible/section-1-complete.yml`
- Creates the `custom-instructlab-code-server` ImageStream in `redhat-ods-applications`
- Exact labels, annotations, tag structure, and name derivation match the ODH dashboard source (`frontend/src/api/k8s/imageStreams.ts`, `ManageBYONImageModal.tsx`)
- Verified fields: `app.kubernetes.io/created-by: byon` label, `opendatahub.io/notebook-image: "true"` label, `opendatahub.io/dashboard: "true"` label, name/desc/url/creator/recommended-accelerators annotations, `openshift.io/imported-from` tag annotation
- Cluster-wide Authorino integration is not required — this is pure BYON setup

### README updates
- Documents the three running patterns (back-to-back teaching, Section-2-only)
- Clear warning that `section-1-complete.yml` must NOT be run when teaching Section 1 in the same session — students create the image themselves in Section 1 Topic 2 and pre-creating it would spoil the exercise

## Test plan

- [x] Ran against a verification cluster and confirmed the ImageStream appears correctly in the RHOAI dashboard at Settings > Environment setup > Workbench images, with the right display name ("InstructLab Code Server") and GPU accelerator association.
- [x] Verified the CLI `oc get imagestream custom-instructlab-code-server -n redhat-ods-applications` returns the expected shape.
- [x] Ran the three-playbook flow (`section-1-prep.yml` → `section-1-complete.yml` → `section-2-prep.yml`) against 30 RHPDS clusters; all 30 passed.
```

## Safety notes

- **Step 3 rewrites history** on `feature/rhoai-cpu-model-serving` using `--force-with-lease`. Safe because nobody else is working on this branch. `--force-with-lease` (not plain `--force`) guards against overwriting unexpected remote updates.
- No commits on `main` are touched. All branch operations are on feature branches.
- If anything goes wrong during the split, the original `feature/rhoai-embedding-setup` state is preserved in the reflog (`git reflog show feature/rhoai-embedding-setup`) for at least 90 days by default.

## When to execute

Not yet. The user will decide when to run the mechanical plan and open the PRs. This document is the plan of record.
