# Retrospective: RHOAI + Embedding Model Setup

**Date:** 2026-04-03
**Effort:** Strip GPU infrastructure from workshop setup, deploy all-MiniLM-L6-v2 on CPU
**Commits:** (uncommitted at time of retro)

## What We Set Out To Do

Reuse the existing workshop cluster setup to get a clean RHOAI deployment without GPU overhead, then deploy sentence-transformers/all-MiniLM-L6-v2 as an embedding service for a separate project. The original `setup.sh` provisions GPU MachineSets, NVIDIA operators, and GPU nodes — all unnecessary for a small CPU embedding model.

## What Changed

| Change | Type | Rationale |
|--------|------|-----------|
| TEI image `cpu-1.5` to `cpu-1.6` | Good pivot | 1.5 had a model download bug ("relative URL without a base") |
| Memory from 512Mi/1Gi to 2Gi/4Gi | Good pivot | TEI needed more headroom than initial estimate |
| Added 10Gi PVC for model cache | Good pivot | Prevents re-downloading model on pod restarts |
| Probe initialDelaySeconds 30s to 120s | Good pivot | Model download caused premature probe failures |

## What Went Well

- The original `setup.sh` was clean and modular enough that stripping GPU was a straightforward subtraction
- Caught `oc apply -f operators/` during review — would have installed the GPU operator despite removing everything else GPU-related
- The deployment agent recovered from the TEI version issue autonomously and updated the manifest file to stay in sync

## Gaps Identified

| Gap | Severity | Resolution |
|-----|----------|------------|
| Endpoint has no auth (publicly accessible) | Accept | Fine for dev on a sandbox cluster |
| No resource quota on embedding-model namespace | Accept | Not critical for single-model dev |
| deploy-embedding-model.sh doesn't validate curl response | Low | Runs curl but doesn't assert valid embeddings returned |

## Action Items

- [x] Commit new files on a dedicated branch
