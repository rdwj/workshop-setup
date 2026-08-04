#!/bin/bash
# Create workshop secrets in OpenShift
# Usage: ./create-workshop-secrets.sh [--context CONTEXT]
#
# Set these environment variables before running:
#   MAAS_DB_USER       (default: maasadmin)
#   MAAS_DB_PASSWORD   (required)
#   MAAS_DB_NAME       (default: maasdb)
#   MINIO_ROOT_USER    (default: minioadmin)
#   MINIO_ROOT_PASSWORD (required)

set -euo pipefail

CONTEXT=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --context) CONTEXT="--context=$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

MAAS_DB_USER="${MAAS_DB_USER:-maasadmin}"
MAAS_DB_NAME="${MAAS_DB_NAME:-maasdb}"
MINIO_ROOT_USER="${MINIO_ROOT_USER:-minioadmin}"

for var in MAAS_DB_PASSWORD MINIO_ROOT_PASSWORD; do
  if [ -z "${!var:-}" ]; then
    echo "Error: ${var} must be set before running this script" >&2
    exit 1
  fi
done

echo "Creating PostgreSQL credentials in maas-postgresql namespace..."
oc create namespace maas-postgresql ${CONTEXT} --dry-run=client -o yaml | oc apply ${CONTEXT} -f -
oc create secret generic maas-postgresql-credentials \
  --from-literal=POSTGRES_USER="${MAAS_DB_USER}" \
  --from-literal=POSTGRES_PASSWORD="${MAAS_DB_PASSWORD}" \
  --from-literal=POSTGRES_DB="${MAAS_DB_NAME}" \
  -n maas-postgresql ${CONTEXT} \
  --dry-run=client -o yaml | oc apply ${CONTEXT} -f -
echo "  Done."

echo "Creating MinIO credentials in minio namespace..."
oc create namespace minio ${CONTEXT} --dry-run=client -o yaml | oc apply ${CONTEXT} -f -
oc create secret generic minio-credentials \
  --from-literal=MINIO_ROOT_USER="${MINIO_ROOT_USER}" \
  --from-literal=MINIO_ROOT_PASSWORD="${MINIO_ROOT_PASSWORD}" \
  -n minio ${CONTEXT} \
  --dry-run=client -o yaml | oc apply ${CONTEXT} -f -
echo "  Done."

echo ""
echo "Secrets created. You can now apply the manifests:"
echo "  oc apply -f maas/postgresql.yaml ${CONTEXT}"
echo "  oc apply -f ogx/minio.yaml ${CONTEXT}"
