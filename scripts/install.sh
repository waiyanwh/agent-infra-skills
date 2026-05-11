#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"

SRC_AGENTS="$REPO_ROOT/AGENTS.md"
SRC_SKILLS="$REPO_ROOT/skills"
DEST_SKILLS="$CODEX_HOME/skills"
MANAGED_SKILLS="
infra-agent-router
devops-sre-infra-troubleshooter
helm-chart-engineer
terraform-terragrunt-engineer
github-actions-engineer
"

echo "Repo root:   $REPO_ROOT"
echo "CODEX_HOME:  $CODEX_HOME"
echo "Source:      $SRC_SKILLS"

if [ ! -d "$SRC_SKILLS" ]; then
  echo "ERROR: skills directory not found: $SRC_SKILLS" >&2
  exit 1
fi

mkdir -p "$CODEX_HOME"
mkdir -p "$DEST_SKILLS"

# Do not commit secrets to this repository or to CODEX_HOME.
# Keep tokens, kubeconfigs, cloud credentials, account IDs, and private keys out of
# AGENTS.md, SKILL.md, templates, shell history, and logs.

# Install global AGENTS.md
if [ -f "$SRC_AGENTS" ]; then
  cp "$SRC_AGENTS" "$CODEX_HOME/AGENTS.md"
  echo "Installed: $CODEX_HOME/AGENTS.md"
else
  echo "ERROR: AGENTS.md not found: $SRC_AGENTS" >&2
  exit 1
fi

# Install skills.
# Replace only the managed skill directories listed above.
# Do not symlink the skills directory and do not delete unmanaged skills.
for skill_name in $MANAGED_SKILLS; do
  skill_dir="$SRC_SKILLS/$skill_name"
  if [ ! -f "$skill_dir/SKILL.md" ]; then
    echo "ERROR: managed skill missing SKILL.md: $skill_dir" >&2
    exit 1
  fi

  rm -rf "$DEST_SKILLS/$skill_name"
  mkdir -p "$DEST_SKILLS/$skill_name"
  cp -R "$skill_dir"/. "$DEST_SKILLS/$skill_name"/

  echo "Installed skill: $skill_name"
done

echo
echo "Done."
echo "Restart Codex to pick up new or changed skills."
