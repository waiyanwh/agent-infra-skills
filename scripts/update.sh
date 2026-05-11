#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$REPO_ROOT"

# Do not commit secrets to this repository. Keep credentials, kubeconfigs,
# cloud account IDs, role names, regions, VPC IDs, subnet IDs, ARNs, and
# private keys out of AGENTS.md, SKILL.md, and templates unless already present
# in the repo and directly relevant.

echo "Pulling latest config..."
git pull --ff-only

echo "Installing..."
./scripts/install.sh
