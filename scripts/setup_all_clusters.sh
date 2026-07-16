#!/usr/bin/env bash
set -euo pipefail

# Set up all clusters in batches of 10 to avoid overwhelming the local machine.
# Usage: ./scripts/setup_all_clusters.sh [--sections]
#   --sections    Also run section-1-prep.yml and section-2-prep.yml after base setup

BATCH_SIZE=10
ANSIBLE_DIR="$(cd "$(dirname "$0")/../ansible" && pwd)"
RUN_SECTIONS=false

if [[ "${1:-}" == "--sections" ]]; then
  RUN_SECTIONS=true
fi

cd "$ANSIBLE_DIR"

# Count total clusters in inventory.
TOTAL=$(grep -c "cluster-" inventory/clusters.yml || true)
if [ "$TOTAL" -eq 0 ]; then
  echo "No clusters found in inventory/clusters.yml. Run scripts/generate_inventory.py first."
  exit 1
fi
echo "Found $TOTAL clusters in inventory."

# Build batch limits.
BATCH=1
START=1
while [ "$START" -le "$TOTAL" ]; do
  END=$((START + BATCH_SIZE - 1))
  if [ "$END" -gt "$TOTAL" ]; then
    END=$TOTAL
  fi

  # Build the --limit pattern for this batch.
  LIMIT=""
  for i in $(seq "$START" "$END"); do
    PADDED=$(printf "cluster-%02d" "$i")
    if [ -n "$LIMIT" ]; then
      LIMIT="$LIMIT,$PADDED"
    else
      LIMIT="$PADDED"
    fi
  done

  echo ""
  echo "=========================================="
  echo "Batch $BATCH: clusters $START-$END ($LIMIT)"
  echo "=========================================="

  echo "--- Running site.yml ---"
  ansible-playbook site.yml --limit "$LIMIT" || {
    echo "[WARN] Batch $BATCH site.yml had failures. Check output above."
    echo "  Re-run failed hosts with: ansible-playbook site.yml --limit @site.retry"
  }

  if [ "$RUN_SECTIONS" = true ]; then
    echo "--- Running section-1-prep.yml ---"
    ansible-playbook section-1-prep.yml --limit "$LIMIT" || {
      echo "[WARN] Batch $BATCH section-1-prep.yml had failures."
    }

    echo "--- Running section-2-prep.yml ---"
    ansible-playbook section-2-prep.yml --limit "$LIMIT" || {
      echo "[WARN] Batch $BATCH section-2-prep.yml had failures."
    }
  fi

  echo ""
  echo "Batch $BATCH complete."

  START=$((END + 1))
  BATCH=$((BATCH + 1))
done

echo ""
echo "=========================================="
echo "All $TOTAL clusters processed."
if [ "$RUN_SECTIONS" = true ]; then
  echo "Base setup + section prep playbooks complete."
else
  echo "Base setup complete. Run with --sections to also run section prep playbooks."
fi
echo "=========================================="
