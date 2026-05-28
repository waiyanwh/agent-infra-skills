#!/usr/bin/env bash
set -euo pipefail

OPENCODE_ADAPTER_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$OPENCODE_ADAPTER_ROOT/../.." && pwd)"

cd "$REPO_ROOT"

echo "Pulling latest skills..."
git pull --ff-only

echo "Installing opencode agents..."
"$OPENCODE_ADAPTER_ROOT/scripts/install.sh" "$@"
