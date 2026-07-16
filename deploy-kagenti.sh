#!/usr/bin/env bash
set -euo pipefail

# Deploy kagenti on OpenShift.
#
# This wrapper handles the pre-flight steps that must happen before the
# Ansible installer runs: Helm v3 PATH setup, GHCR login, and credential
# checks. After the install it prints the UI route and Keycloak credentials.
#
# Usage:
#   ./deploy-kagenti.sh [--context <context-name>] [path/to/kagenti]
#
# Arguments:
#   --context <name>  Use this kubeconfig context (creates a temp kubeconfig
#                     copy so the real one is never modified)
#   path/to/kagenti   Path to the kagenti repo clone (default: ~/Developer/kagenti)
#
# Environment:
#   GITHUB_TOKEN   GitHub token for GHCR login (falls back to 'gh auth token')
#   GITHUB_USER    GitHub username (falls back to 'gh api user -q .login')
#
# Prerequisites:
#   - helm@3 installed (brew install helm@3)
#   - gh CLI authenticated (gh auth login)
#   - oc logged in to the target cluster
#   - deployments/envs/.secret_values.yaml populated in the kagenti repo

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------

CONTEXT=""
POSITIONAL=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --context)
      [[ -n "${2:-}" ]] || { echo "[FAIL] --context requires a value" >&2; exit 1; }
      CONTEXT="$2"
      shift 2
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

HELM3="/opt/homebrew/opt/helm@3/bin/helm"
KAGENTI_REPO="${POSITIONAL[0]:-$HOME/Developer/kagenti}"
INSTALLER="$KAGENTI_REPO/deployments/ansible/run-install.sh"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

die() { echo "[FAIL] $*" >&2; exit 1; }

check() {
  if eval "$2" 2>/dev/null; then
    echo "[PASS] $1"
  else
    die "$1 — $3"
  fi
}

# ---------------------------------------------------------------------------
# Context isolation — temp kubeconfig so child processes target the right cluster
# ---------------------------------------------------------------------------

if [[ -n "$CONTEXT" ]]; then
  oc --kubeconfig="$HOME/.kube/config" config get-contexts "$CONTEXT" &>/dev/null \
    || die "context '$CONTEXT' not found in ~/.kube/config"

  TMPKUBECONFIG="$(mktemp /tmp/kubeconfig-kagenti.XXXXXX)"
  trap 'rm -f "$TMPKUBECONFIG"' EXIT

  cp "$HOME/.kube/config" "$TMPKUBECONFIG"
  KUBECONFIG="$TMPKUBECONFIG" oc config use-context "$CONTEXT" >/dev/null
  export KUBECONFIG="$TMPKUBECONFIG"
  echo "Using context '$CONTEXT' via temp kubeconfig ($TMPKUBECONFIG)"
fi

# ---------------------------------------------------------------------------
# Resolve Helm v3
# ---------------------------------------------------------------------------

if [[ -x "$HELM3" ]]; then
  export PATH="$(dirname "$HELM3"):$PATH"
elif command -v helm >/dev/null 2>&1; then
  helm_ver=$(helm version --short 2>/dev/null | grep -oE 'v[0-9]+' | head -n1)
  [[ "$helm_ver" == "v3" ]] || die "helm in PATH is not v3 (found $helm_ver). Install with: brew install helm@3"
  HELM3="$(command -v helm)"
else
  die "Helm v3 not found. Install with: brew install helm@3"
fi

echo "Using Helm: $HELM3 ($(${HELM3} version --short 2>/dev/null))"

# ---------------------------------------------------------------------------
# Pre-flight checks
# ---------------------------------------------------------------------------

check "kagenti repo exists at $KAGENTI_REPO" \
  "[[ -d '$KAGENTI_REPO' ]]" \
  "Clone the repo first or pass the path as an argument"

check "installer script exists" \
  "[[ -x '$INSTALLER' ]]" \
  "Expected $INSTALLER — is the kagenti repo complete?"

OC_USER=$(oc whoami 2>/dev/null) \
  || die "oc is not logged in — run 'oc login' before deploying"
OC_CONTEXT=$(oc config current-context 2>/dev/null || echo "unknown")
OC_CLUSTER=$(oc config view --minify -o jsonpath='{.clusters[0].cluster.server}' 2>/dev/null || echo "unknown")
echo "[PASS] oc is logged in as $OC_USER (context: $OC_CONTEXT, cluster: $OC_CLUSTER)"

SECRET_FILE="$KAGENTI_REPO/deployments/envs/.secret_values.yaml"
check "secret values file exists" \
  "[[ -f '$SECRET_FILE' ]]" \
  "Create $SECRET_FILE from the .example template before deploying"

# ---------------------------------------------------------------------------
# Resolve GitHub credentials
# ---------------------------------------------------------------------------

if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  GH_TOKEN="$GITHUB_TOKEN"
else
  GH_TOKEN="$(gh auth token 2>/dev/null)" \
    || die "No GitHub token found. Set GITHUB_TOKEN or run 'gh auth login'"
fi

if [[ -n "${GITHUB_USER:-}" ]]; then
  GH_USER="$GITHUB_USER"
else
  GH_USER="$(gh api user -q .login 2>/dev/null)" \
    || die "Could not determine GitHub username. Set GITHUB_USER or ensure 'gh auth login' is complete"
fi

echo "GitHub user: $GH_USER"

# ---------------------------------------------------------------------------
# GHCR login (required — mcp-gateway chart is in a private GHCR repo)
# ---------------------------------------------------------------------------

echo "Logging Helm v3 into ghcr.io..."
echo "$GH_TOKEN" | "$HELM3" registry login ghcr.io \
  --username "$GH_USER" \
  --password-stdin
echo "[PASS] Helm logged into ghcr.io"

# ---------------------------------------------------------------------------
# Run the installer
# ---------------------------------------------------------------------------

echo ""
echo "=== Running kagenti installer (--env ocp) ==="
echo ""

export PATH="$(dirname "$HELM3"):$PATH"
"$INSTALLER" --env ocp

# ---------------------------------------------------------------------------
# Post-install summary
# ---------------------------------------------------------------------------

echo ""
echo "=== Kagenti deployment complete ==="
echo ""

UI_ROUTE=$(oc get route -n kagenti-system -l "app.kubernetes.io/component=ui" \
  -o jsonpath='{.items[0].spec.host}' 2>/dev/null \
  || oc get route -n kagenti-system \
  -o jsonpath='{range .items[?(@.metadata.name=="kagenti-ui")]}{.spec.host}{end}' 2>/dev/null \
  || true)

if [[ -n "$UI_ROUTE" ]]; then
  echo "Kagenti UI:  https://$UI_ROUTE"
else
  echo "Kagenti UI route: run 'oc get routes -n kagenti-system' to find the URL"
fi

KC_PASS=$(oc get secret keycloak-initial-admin -n keycloak \
  -o jsonpath='{.data.password}' 2>/dev/null | base64 -d 2>/dev/null || true)
KC_ROUTE=$(oc get route keycloak -n keycloak \
  -o jsonpath='{.spec.host}' 2>/dev/null || true)

echo ""
echo "Keycloak:"
if [[ -n "$KC_ROUTE" ]]; then
  echo "  URL:      https://$KC_ROUTE"
fi
echo "  Username: admin"
if [[ -n "$KC_PASS" ]]; then
  echo "  Password: $KC_PASS"
else
  echo "  Password: run 'oc get secret keycloak-initial-admin -n keycloak -o jsonpath={.data.password} | base64 -d'"
fi

echo ""
echo "Note: Keycloak password comes from the 'keycloak-initial-admin' secret, not"
echo "      from .secret_values.yaml — those are separate credentials."
