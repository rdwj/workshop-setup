# E2E Workshop Test Findings

Testing the MCP Ecosystem Workshop on a fresh OCP 4.20 cluster (e2e-test)
with RHOAI 3.4 pre-installed via Kustomize base.

Each module tested as a student would — following the README instructions,
applying YAML, and noting anything that's unclear, broken, or could be improved.

---

## Pre-test Setup

- Cluster: `api.cluster-n2gnd.n2gnd.sandbox3531.opentlc.com`
- Context: `e2e-test`
- RHOAI: Installed via `oc apply -k deploy/overlays/e2e-test/`
- DSC: Ready
- Agent stack: Pre-deployed in `workshop-setup-mcp` namespace

---

## Module 1: Gateway Infrastructure

**Result:** PASS with one finding.

**Finding 1: Pending InstallPlans block RHCL installation**

The RHCL operator subscription was created with `installPlanApproval:
Automatic`, but the RHCL CSV wouldn't install. The cause was pending
Service Mesh 3 upgrade InstallPlans (`v3.1.0 → v3.3.3`) that had
`Manual` approval from the base RHOAI install. The RHCL operator
depends on SM3 and won't install until SM3 is at a compatible version.

**Impact:** Students will wait indefinitely for the RHCL CSV with no
error message. The subscription shows `Automatic` but the underlying
InstallPlan dependency chain has a Manual approval blocking it.

**Fix options:**
1. Add a note to the README: "If the RHCL CSV doesn't appear after
   3 minutes, check for pending InstallPlans and approve them"
2. Change the base Kustomize to set all subscriptions to Automatic
3. Add a pre-workshop step that approves all pending InstallPlans

**Recommendation:** Option 1 + 3. Students should see the RHCL install
cleanly.

**Other observations:**
- Kuadrant Ready in ~30 seconds without hitting MissingDependency
- GatewayClass `data-science-gateway-class` present and Accepted
- Commands worked as written (copy-paste friendly)
- `python3 -m json.tool` for status checking works well

---

## Module 2: MCP Gateway

**Result:** PASS with two findings.

**Finding 2: InstallPlan approval mode not respected (same as Module 1)**

The MCP Gateway subscription YAML has `installPlanApproval: Automatic`
but the InstallPlan was created with `Manual` approval. Had to approve
manually. This is the same issue as Module 1 — seems cluster-wide.

**Root cause:** When OLM creates an InstallPlan that upgrades a
dependency operator (SM3 in this case), the approval mode of the
*dependency* takes precedence. Since SM3 was installed with Manual
approval by the RHOAI operator, all downstream InstallPlans inherit
Manual.

**Finding 3: The `sed` substitution for CLUSTER_DOMAIN works but is fragile**

The README says "Edit mcp-gateway-cr.yaml and replace `<CLUSTER_DOMAIN>`."
Students need to either:
- Edit the file by hand (error-prone)
- Use `sed` on the command line (the README doesn't show this)
- Know their domain ahead of time

**Recommendation:** Add the sed command to the README as the primary
method, with the manual edit as an alternative. Something like:

```bash
CLUSTER_DOMAIN=$(oc get ingresses.config.openshift.io cluster -o jsonpath='{.spec.domain}')
sed "s/<CLUSTER_DOMAIN>/${CLUSTER_DOMAIN}/g" mcp-gateway-cr.yaml | oc apply -f -
```

**Other observations:**
- Lifecycle operator installed in ~15 seconds, no OOM on initial deploy
- Memory patch worked as written
- privateHost workaround steps clear and effective
- Gateway Accepted + Programmed quickly
- Broker pod running immediately

---

## Module 3: Deploy MCP Server

**Result:** PASS, clean.

**Observations:**
- Skipped the dashboard path (deployed directly via CR) — worked first try
- Prerequisites applied cleanly, MCPServer reconciled in ~20 seconds
- The `curl` test command in Step 6 uses `tools/list` but needs
  `initialize` first (MCP protocol requires session init before listing).
  The README command may fail with a "Bad Request" because it skips init.
- The inline `cat <<'EOF'` YAML in Step 5 is good for copy-paste
- ConfigMap review step is a nice touch for learning

**Finding 4: Step 6 test command needs initialize first**

The README suggests: `curl ... -d '{"jsonrpc":"2.0","method":"tools/list",...}'`
but MCP streamable-http requires `initialize` before `tools/list`.
A direct `tools/list` may return "Bad Request: GET requires an
Mcp-Session-Id header."

**Recommendation:** Change the test command to use `initialize` or add
a note that this is a quick smoke test that may need a two-step process.

---

## Module 4: Gateway Registration

**Result:** PASS with three findings.

**Finding 5: Broker restart label selector doesn't match**

The README suggests:
```
oc rollout restart deployment -n mcp-system -l app.kubernetes.io/component=broker
```
This returned "No resources found." The broker deployment is just named
`mcp-gateway` with no `component=broker` label. The README's fallback
instructions (find by name) work, but the primary command fails.

**Recommendation:** Change the primary restart command to:
```
oc rollout restart deployment/mcp-gateway -n mcp-system
```

**Finding 6: tools/list test command in Step 5 needs session init**

The README shows a one-shot `tools/list` curl but MCP streamable-http
requires `initialize` first to get a session ID. Without auth (no
AuthPolicy yet), the response came as plain JSON (not SSE), so a
simpler curl works — but the format is inconsistent.

**Recommendation:** Add a two-step test or provide a test script.

**Finding 7: `sed` substitution for CLUSTER_DOMAIN (same as Module 2)**

Same issue as Finding 3 — the README says "edit the file" but should
show the `sed` command.

**Other observations:**
- ReferenceGrant applied cleanly
- MCPServerRegistration created, broker picked up 14 tools after restart
- VirtualMCPServers created immediately
- All commands copy-paste friendly (except the domain substitution)

---

## Module 5: Identity and Authentication

**Result:** PASS with four findings.

**Finding 8: Keycloak CR references nonexistent TLS secret**

The `keycloak-cr.yaml` has `http.tlsSecret: keycloak-tls-secret` but
no step creates this secret. The pod gets stuck in ContainerCreating
with `MountVolume.SetUp failed for volume "keycloak-tls-certificates":
secret "keycloak-tls-secret" not found`.

**Fix:** Either:
- Remove `tlsSecret` from the CR and add `httpEnabled: true` (let the
  Route handle TLS) — simpler for a workshop
- Or add a step to create a self-signed cert

**Finding 9: Keycloak Route TLS termination mismatch**

The route YAML uses `termination: reencrypt` but after fixing Finding 8
(enabling HTTP), the pod only serves HTTP. Route needs `termination: edge`.
Also need `port.targetPort: http` instead of the default.

**Fix:** Update `keycloak-route.yaml` to use `edge` TLS termination
and `targetPort: http`.

**Finding 10: Step 10 client secret command too complex**

The README wraps the client secret retrieval in a `bash -c` subshell
that doesn't inherit env vars from the parent shell. Students need to
use the step-by-step approach instead.

**Fix:** Replace the one-liner with sequential commands (the step-by-step
approach I used works).

**Finding 11: tools/list needs initialize + session ID (again)**

The Step 10 test command calls tools/list without initializing a
session. After AuthPolicy is applied, the broker requires a session
for all requests.

**Fix:** Provide a two-step test or a test script.

**Other observations:**
- InstallPlan approval issue again (Finding 2 pattern)
- RHBK resolved to v24.0.11, not v24.0.7 as the README says
- setup-keycloak-realm.sh worked perfectly (idempotent, clear output)
- generate-wristband-keys.sh worked first try
- AuthPolicy accepted and enforced immediately
- 401 for unauth works correctly
- 14 tools for admin identity works correctly
- Token lifetime extension step would work (not tested)

---

## Module 6: Agent Testing

**Result:** PASS with three findings.

**Finding 12: Deployment name wrong in README**

The README uses `workshop-setup-mcp-agent` in rollout commands but the
actual deployment is named `workshop-setup-mcp`.

**Fix:** Replace `workshop-setup-mcp-agent` with `workshop-setup-mcp`
in all `oc rollout` commands.

**Finding 13: MCP_GATEWAY_URL should use internal service, not Route**

The README constructs `MCP_GATEWAY_URL` as `http://mcp-gateway.mcp.${CLUSTER_DOMAIN}`
which goes through the external Route/LoadBalancer. The agent runs
inside the cluster — it should use the internal service URL:
`http://mcp-gateway-data-science-gateway-class.mcp-system.svc.cluster.local:8080/mcp`

Using the external URL adds unnecessary latency and may not work if the
LoadBalancer has auth policies at the network level.

**Finding 14: Agent needs a model endpoint to actually chat**

The pre-deployed agent has `MODEL_ENDPOINT=http://placeholder:8080/v1`.
Students can't test the chat UI without a real model. The workshop needs
to either:
- Point at a remote model (like gpt-oss-20b on another cluster)
- Deploy a local model (requires GPU)
- Make Module 8 (External Model) a prerequisite for Module 6

**Other observations:**
- Agent connected to gateway with 14 tools after config switch
- Keycloak JWT acquisition via startup script works
- The discussion section is excellent educational content
- Step 6 (user client creation) is long but each step works

---

## Summary

All 6 modules PASS. 14 findings total:

| # | Module | Finding | Severity |
|---|--------|---------|----------|
| 1 | 1 | Pending InstallPlans block RHCL | High — students stuck |
| 2 | 2 | InstallPlan approval mode not respected | High — same |
| 3 | 2 | sed substitution not shown in README | Medium — friction |
| 4 | 3 | Step 6 test needs initialize first | Low — cosmetic |
| 5 | 4 | Broker restart label selector wrong | Medium — fails silently |
| 6 | 4 | tools/list needs session init | Low — cosmetic |
| 7 | 4 | sed substitution (same as 3) | Medium |
| 8 | 5 | Keycloak CR references nonexistent TLS secret | **Blocker** |
| 9 | 5 | Route TLS mismatch (reencrypt vs edge) | **Blocker** |
| 10 | 5 | Client secret command too complex | Medium |
| 11 | 5 | tools/list needs session init (same as 6) | Low |
| 12 | 6 | Deployment name wrong | Medium |
| 13 | 6 | Should use internal URL, not Route | Medium |
| 14 | 6 | Agent needs a model endpoint | High — chat won't work |

**Blockers (must fix):** 8, 9 (Keycloak TLS config)
**High (should fix):** 1, 2, 14 (InstallPlans, model endpoint)
**Medium (nice to fix):** 3, 5, 7, 10, 12, 13
**Low (cosmetic):** 4, 6, 11

---

## David Martin's Guidance (kuadrant/mcp-gateway#926)

Testing the approaches from David's comment on the 5przf cluster.

**Key insight:** The broker has two access paths:
- **Direct** (`mcp-gateway.mcp-system.svc:8080`) — tools/list works, tools/call returns "doesn't forward"
- **Via Istio gateway** (`mcp-gateway-data-science-gateway-class:8080`) — both work, but requires JWT auth

The broker can only route tools/call when the request comes through the
Istio gateway's ext_proc filter chain. Direct broker access bypasses
ext_proc, so the broker doesn't know how to reach the backend.

**For the Playground:**
- Configured `oauthProtectedResource` env vars on the broker
- `.well-known/oauth-protected-resource` now returns Keycloak discovery info
- Pointed Playground at the Istio gateway URL
- LSD connects lazily — needs a user chat message to trigger MCP connection
- **Status: needs manual Playground test** — ask something in the chat and
  check LSD logs for whether it does OAuth discovery from the 401 response

**If the LSD does NOT do OAuth discovery:**
- This confirms the Playground/OGX limitation (ogx-ai/ogx#5152)
- The `credentialRef` pattern from David's guide doesn't help here because
  it's for broker → backend discovery, not client → gateway auth

**If the LSD DOES do OAuth discovery:**
- This would be a breakthrough — the Playground would work through the
  authenticated gateway without any upstream code changes
