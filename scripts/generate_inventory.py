#!/usr/bin/env python3
"""Generate Ansible inventory from RHPDS cluster list export.

Reads ansible/inventory/users.txt (copied from the RHPDS Users page) and
writes ansible/inventory/clusters.yml with one host entry per cluster,
using the long-lived service account token for authentication.

Usage:
    python3 scripts/generate_inventory.py
"""

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
CLUSTER_LIST = REPO_ROOT / "ansible" / "inventory" / "users.txt"
INVENTORY_OUT = REPO_ROOT / "ansible" / "inventory" / "clusters.yml"


def parse_clusters(content: str) -> list[dict]:
    clusters = []
    blocks = content.split("sandboxes-gpte.sandbox-ocp.prod")
    for block in blocks:
        api_match = re.search(r"openshift_api_url:\s*(https://[^\s]+)", block)

        token_match = re.search(
            r"openshift_cluster_admin_token:\s*>-\s*\n\s*(\S+)", block
        ) or re.search(
            r"openshift_cluster_admin_token:\s*(eyJ\S+)", block
        )

        guid_match = re.search(r"guid:\s*(\S+)", block)
        if api_match and token_match and guid_match:
            clusters.append(
                {
                    "guid": guid_match.group(1),
                    "api_url": api_match.group(1),
                    "token": token_match.group(1),
                }
            )
    return clusters


def write_inventory(clusters: list[dict], path: Path) -> None:
    lines = [
        f"# Auto-generated from {CLUSTER_LIST.relative_to(REPO_ROOT)}",
        f"# {len(clusters)} RHPDS clusters",
        "# WARNING: This file contains credentials. It is gitignored.",
        "all:",
        "  vars:",
        "    ansible_connection: local",
        '    ansible_python_interpreter: "{{ ansible_playbook_python }}"',
        "  hosts:",
    ]
    for i, c in enumerate(clusters, 1):
        lines.append(f"    cluster-{i:02d}:")
        lines.append(f'      k8s_host: "{c["api_url"]}"')
        lines.append(f'      k8s_api_key: "{c["token"]}"')

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def main():
    if not CLUSTER_LIST.exists():
        print(f"Error: {CLUSTER_LIST} not found.", file=sys.stderr)
        print(
            "Copy the contents of the RHPDS Users page into that file first.",
            file=sys.stderr,
        )
        sys.exit(1)

    content = CLUSTER_LIST.read_text()
    clusters = parse_clusters(content)

    if not clusters:
        print("Error: No clusters found in the file.", file=sys.stderr)
        print(
            "Make sure you copied the full contents of the RHPDS Users page.",
            file=sys.stderr,
        )
        sys.exit(1)

    write_inventory(clusters, INVENTORY_OUT)
    print(f"Wrote {len(clusters)} clusters to {INVENTORY_OUT.relative_to(REPO_ROOT)}")


if __name__ == "__main__":
    main()
