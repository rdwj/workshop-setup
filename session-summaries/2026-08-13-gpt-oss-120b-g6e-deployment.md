# Session Summary — 2026-08-13 · gpt-oss-120b · g6e.12xlarge KServe deployment and benchmarking

**Plan:** Ad-hoc — deploy gpt-oss-120b on a g6e.12xlarge for 2-seat agentic code refactoring
**Commits:** 5e3f58e..ce07ecb (main)
**Deployed:** gpt-oss-120b on cluster gpt-oss-120b (context `gpt-oss-120b`)
**Model:** Claude Code (Opus 4.6)

## Plan vs. actual
Planned: Create KServe manifests for gpt-oss-120b on g6e.12xlarge, deploy, benchmark with GuideLLM.
Shipped: All of the above, plus discovered model limitations (131K hard ceiling, Harmony parser errors on chat endpoint, auth proxy 30s timeout).
Scope: expanded to include RHOAI setup, GPU operator install, NVIDIA driver bootstrap, auth proxy debugging, and direct-route workaround.

## Shipped
- `model/gpt-oss-120b-kserve.yaml` — p4d.24xlarge (8x A100) KServe manifest (5e3f58e)
- `model/gpt-oss-120b-kserve-g6e.yaml` — g6e.12xlarge (4x L40S) KServe manifest with EAGLE-3, PVC cache, download Job, Authorino auth, direct route, RBAC (5e3f58e)
- `operators/rhoai-operator.yaml` — RHOAI subscription manifest (5e3f58e)
- `benchmarks/` — GuideLLM results at 8K/32K/126K/200K context (5e3f58e)
- `ce07ecb` — gitignore ggshield cache

## Verification & confidence
- Model serving verified via curl (streaming + non-streaming) against both auth and direct routes
- GuideLLM benchmarks at 8K, 32K, 126K completed successfully with 0 errors
- 200K benchmark confirmed model's 131K position embedding hard limit
- EAGLE-3 speculator confirmed active via Prometheus metrics (low acceptance on synthetic text, expected)
- PVC storage path (`pvc://`) NOT yet tested live — manifest updated but not redeployed
- Confidence: **medium** — serving and benchmarks proven; PVC-based restart path is untested

## Judgment calls & deviations
- Chose `gpt-oss-120b-essential` over full model (smaller download, identical inference)
- Used upstream `vllm/vllm-openai:latest` instead of RHAIIS image to get EAGLE-3 support (vLLM 0.27.1 vs RHAIIS 0.10.1.1)
- Created direct-access route bypassing kube-rbac-proxy rather than fighting the unconfigurable 30s upstream timeout
- Used `/v1/completions` for GuideLLM instead of `/v1/chat/completions` — Harmony response parser errors on longer generations
- Tried all us-east-2 AZs for g6e.12xlarge capacity; landed on us-east-2c after 2b and 2a failed (capacity + missing subnet)
- Download Job targets GPU node (nodeSelector) to bind PVC to the same AZ as the model pod

## Backlog delta
- No issues filed this session
- Deferred: redeploy with PVC-backed storage (manifest ready, needs testing)
- Deferred: EAGLE-3 acceptance rate validation on real code prompts (synthetic text gave 2.7%, expect much higher on code)

## Drift & forward-collisions
- Backward: none
- Forward: none

## For the reviewer
- Sanity-check: the `pvc://` storageUri with a download Job is the right KServe pattern — should verify it works on next redeploy before trusting it for production restarts
- Thin verification: EAGLE-3 speculator benefit is unproven on real workloads; the 2.7% acceptance rate on synthetic text is expected-bad but real-code performance is only theoretical (HF card claims 2.3-3.3x)
- Wants guidance: none

## Risks / watch-fors
- The Harmony parser errors on `/v1/chat/completions` with longer outputs mean tool-calling (which uses chat completions) may fail on extended generations — worth testing with real agentic workflows
- The kube-rbac-proxy 30s timeout is a known RHOAI limitation with no config knob; the direct route workaround is unauthenticated
- g6e.12xlarge capacity in us-east-2 was scarce — may hit the same issue on cluster rebuild
- Account vCPU quota (64) blocks g6e.24xlarge (96 vCPU); only g6e.12xlarge (48 vCPU) fits

## Benchmark summary (g6e.12xlarge, 4x L40S, 2 concurrent streams)

| Context | TTFT | ITL | Output tok/s | Latency (4K out) | Status |
|---------|------|-----|-------------|-----------------|--------|
| 8K | 1.4s | 48ms | 28 | 97s | OK |
| 32K | 5.7s | 57ms | 35 | 239s | OK |
| 126K | 29-55s | 84ms | 23 | 366s | OK |
| 200K | — | — | — | — | Rejected (131K ceiling) |
