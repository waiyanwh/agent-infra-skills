#!/usr/bin/env bash
set -euo pipefail

CODEX_ADAPTER_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$CODEX_ADAPTER_ROOT/../.." && pwd)"
INSTALL_SCOPE="global"
PROJECT_DIR=""

usage() {
  cat <<'USAGE'
Usage:
  install.sh [--global]
  install.sh --local [project-dir]
  install.sh --codex-home <path>

Options:
  --global             Install into CODEX_HOME or ~/.codex. This is the default.
  --local [project]   Install into <project>/.codex. Defaults to the current directory.
  --codex-home <path> Install into an explicit Codex home path.
  -h, --help          Show this help.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --global)
      INSTALL_SCOPE="global"
      PROJECT_DIR=""
      shift
      ;;
    --local)
      INSTALL_SCOPE="local"
      if [ "${2:-}" != "" ] && [ "${2#-}" = "$2" ]; then
        PROJECT_DIR="$2"
        shift 2
      else
        PROJECT_DIR="$PWD"
        shift
      fi
      ;;
    --codex-home)
      if [ "${2:-}" = "" ]; then
        echo "ERROR: --codex-home requires a path" >&2
        exit 1
      fi
      INSTALL_SCOPE="explicit"
      CODEX_HOME="$2"
      PROJECT_DIR=""
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [ "$INSTALL_SCOPE" = "local" ]; then
  PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"
  CODEX_HOME="$PROJECT_DIR/.codex"
else
  CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
fi

SRC_AGENTS="$CODEX_ADAPTER_ROOT/AGENTS.md"
SRC_SKILLS="$REPO_ROOT/skills"
DEST_SKILLS="$CODEX_HOME/skills"
MANAGED_SKILLS=(
  "infra-agent-router"
  "devops-sre-infra-troubleshooter"
  "aws-cloud-engineer"
  "helm-chart-engineer"
  "terraform-terragrunt-engineer"
  "github-actions-engineer"
)

echo "Repo root:   $REPO_ROOT"
echo "Scope:       $INSTALL_SCOPE"
if [ "$INSTALL_SCOPE" = "local" ]; then
  echo "Project:     $PROJECT_DIR"
fi
echo "CODEX_HOME:  $CODEX_HOME"
echo "Source:      $SRC_SKILLS"

if [ ! -d "$SRC_SKILLS" ]; then
  echo "ERROR: skills directory not found: $SRC_SKILLS" >&2
  exit 1
fi

mkdir -p "$CODEX_HOME"
mkdir -p "$DEST_SKILLS"

# Do not commit secrets to this repository or to CODEX_HOME.
# Keep tokens, kubeconfigs, cloud credentials, account IDs, role names, regions,
# VPC IDs, subnet IDs, ARNs, and private keys out of AGENTS.md, SKILL.md,
# templates, shell history, and logs unless already present and directly relevant.

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
for skill_name in "${MANAGED_SKILLS[@]}"; do
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
