#!/usr/bin/env bash
set -euo pipefail

CLAUDE_ADAPTER_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$CLAUDE_ADAPTER_ROOT/../.." && pwd)"

cd "$REPO_ROOT"

echo "Pulling latest skills..."
git pull --ff-only

echo "Installing Claude Code agents..."
"$CLAUDE_ADAPTER_ROOT/scripts/install.sh" "$@"
