#!/usr/bin/env bash
set -euo pipefail

CODEX_ADAPTER_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$CODEX_ADAPTER_ROOT/../.." && pwd)"

cd "$REPO_ROOT"

# Do not commit secrets to this repository. Keep credentials, kubeconfigs,
# cloud account IDs, role names, regions, VPC IDs, subnet IDs, ARNs, and
# private keys out of AGENTS.md, SKILL.md, and templates unless already present
# in the repo and directly relevant.

echo "Pulling latest config..."
git pull --ff-only

echo "Installing..."
"$CODEX_ADAPTER_ROOT/scripts/install.sh" "$@"
