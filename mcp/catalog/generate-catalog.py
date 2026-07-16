#!/usr/bin/env python3
"""Generate RHOAI MCP catalog ConfigMaps from mcp-servers.yaml.

Reads the server definitions and produces two Kubernetes ConfigMaps:
  1. gen-ai-aa-mcp-servers  (redhat-ods-applications) — Playground dropdown
  2. mcp-catalog-sources    (rhoai-model-registries)  — MCP Catalog browser

Usage:
    python3 generate-catalog.py              # prints to stdout
    python3 generate-catalog.py -o out.yaml  # writes to file
"""
import argparse
import json
import sys
import time
from pathlib import Path

import yaml


def load_servers(path: Path) -> dict:
    with open(path) as f:
        return yaml.safe_load(f)


def build_playground_configmap(config: dict) -> dict:
    """Build the gen-ai-aa-mcp-servers ConfigMap for the Playground dropdown."""
    data = {}
    for server in config.get("servers", []):
        entry = {
            "url": server["url"],
            "description": server.get("description", ""),
        }
        data[server["display_name"]] = json.dumps(entry, indent=2)

    return {
        "apiVersion": "v1",
        "kind": "ConfigMap",
        "metadata": {
            "name": "gen-ai-aa-mcp-servers",
            "namespace": "redhat-ods-applications",
        },
        "data": data,
    }


def build_catalog_configmap(config: dict) -> dict:
    """Build the mcp-catalog-sources ConfigMap for the MCP Catalog browser."""
    catalog_name = config.get("catalog_name", "Workshop MCP Servers")
    catalog_id = config.get("catalog_id", "workshop-mcp-catalog")
    catalog_filename = f"{catalog_id}.yaml"

    # sources.yaml tells the dashboard where to find catalogs
    sources = {
        "mcp_catalogs": [
            {
                "name": catalog_name,
                "id": catalog_id,
                "type": "yaml",
                "enabled": True,
                "properties": {"yamlCatalogPath": catalog_filename},
                "labels": [config.get("catalog_label", catalog_name.split()[0])],
            }
        ]
    }

    # Build the catalog entries
    mcp_servers = []
    epoch_ms = str(int(time.time() * 1000))

    for server in config.get("servers", []):
        entry = {
            "name": server["name"],
            "provider": server.get("provider", "Red Hat"),
            "license": server.get("license", "Apache-2.0"),
            "license_link": f"https://opensource.org/licenses/{server.get('license', 'Apache-2.0')}",
            "description": server.get("description", ""),
            "version": server.get("version", "1.0.0"),
            "transports": server.get("transports", ["http"]),
            "deploymentMode": "local",
            "tags": server.get("tags", []),
            "lastUpdateTimeSinceEpoch": epoch_ms,
        }

        if server.get("readme"):
            entry["readme"] = server["readme"].rstrip()

        if server.get("documentation_url"):
            entry["documentationUrl"] = server["documentation_url"]
        if server.get("repository_url"):
            entry["repositoryUrl"] = server["repository_url"]

        # Add deployment metadata — artifacts must be an array of {uri, ...} objects
        if server.get("artifacts"):
            image = server["artifacts"].get("containerImage", "")
            if image:
                epoch_ms_str = str(int(time.time() * 1000))
                entry["artifacts"] = [
                    {
                        "uri": f"oci://{image}" if not image.startswith("oci://") else image,
                        "createTimeSinceEpoch": epoch_ms_str,
                        "lastUpdateTimeSinceEpoch": epoch_ms_str,
                    }
                ]

        if server.get("runtimeMetadata"):
            entry["runtimeMetadata"] = server["runtimeMetadata"]

        if server.get("healthEndpoints"):
            entry["healthEndpoints"] = server["healthEndpoints"]

        # Build tools list
        tools = []
        for tool in server.get("tools", []):
            tools.append(
                {
                    "name": tool["name"],
                    "description": tool.get("description", ""),
                    "accessType": tool.get("access_type", "read_only"),
                    "parameters": [],
                }
            )
        if tools:
            entry["tools"] = tools

        # Security indicators
        read_only = all(
            t.get("access_type", "read_only") == "read_only"
            for t in server.get("tools", [])
        )
        entry["securityIndicators"] = {
            "readOnlyTools": read_only,
            "secureEndpoint": server.get("auth_required", False),
            "verifiedSource": server.get("provider", "") == "Red Hat",
        }

        mcp_servers.append(entry)

    catalog_source = config.get("catalog_source", catalog_name)
    catalog_content = {"source": catalog_source, "mcp_servers": mcp_servers}

    return {
        "apiVersion": "v1",
        "kind": "ConfigMap",
        "metadata": {
            "name": "mcp-catalog-sources",
            "namespace": "rhoai-model-registries",
            "labels": {"app": "model-catalog", "component": "model-catalog"},
        },
        "data": {
            "sources.yaml": yaml.dump(sources, default_flow_style=False),
            catalog_filename: yaml.dump(
                catalog_content, default_flow_style=False, width=120
            ),
        },
    }


def main():
    parser = argparse.ArgumentParser(
        description="Generate RHOAI MCP catalog ConfigMaps"
    )
    parser.add_argument(
        "-o", "--output", help="Output file (default: stdout)", default=None
    )
    parser.add_argument(
        "-s",
        "--servers-file",
        help="Path to mcp-servers.yaml",
        default=str(Path(__file__).parent / "mcp-servers.yaml"),
    )
    args = parser.parse_args()

    config = load_servers(Path(args.servers_file))

    playground_cm = build_playground_configmap(config)
    catalog_cm = build_catalog_configmap(config)

    output_parts = []
    output_parts.append("---")
    output_parts.append(yaml.dump(playground_cm, default_flow_style=False))
    output_parts.append("---")
    output_parts.append(yaml.dump(catalog_cm, default_flow_style=False))

    result = "\n".join(output_parts)

    if args.output:
        Path(args.output).write_text(result)
        print(f"Wrote {args.output}", file=sys.stderr)
    else:
        print(result)


if __name__ == "__main__":
    main()
