#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$REPO_ROOT"

# Do not commit secrets to this repository. Keep credentials, kubeconfigs,
# cloud account IDs, and private keys out of AGENTS.md, SKILL.md, and templates.

echo "Pulling latest config..."
git pull --ff-only

echo "Installing..."
./scripts/install.sh
