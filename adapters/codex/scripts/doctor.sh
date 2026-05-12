#!/usr/bin/env bash
set -euo pipefail

INSTALL_SCOPE="global"
PROJECT_DIR=""

usage() {
  cat <<'USAGE'
Usage:
  doctor.sh [--global]
  doctor.sh --local [project-dir]
  doctor.sh --codex-home <path>

Options:
  --global             Check CODEX_HOME or ~/.codex. This is the default.
  --local [project]   Check <project>/.codex. Defaults to the current directory.
  --codex-home <path> Check an explicit Codex home path.
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

status=0

echo "Scope: $INSTALL_SCOPE"
if [ "$INSTALL_SCOPE" = "local" ]; then
  echo "Project: $PROJECT_DIR"
fi
echo "CODEX_HOME: $CODEX_HOME"
echo

if [ -f "$CODEX_HOME/AGENTS.md" ]; then
  echo "OK: $CODEX_HOME/AGENTS.md exists"
else
  echo "MISSING: $CODEX_HOME/AGENTS.md"
  status=1
fi

echo
echo "Skills:"

for skill in \
  infra-agent-router \
  devops-sre-infra-troubleshooter \
  aws-cloud-engineer \
  helm-chart-engineer \
  terraform-terragrunt-engineer \
  github-actions-engineer \
  security-engineer
do
  if [ -f "$CODEX_HOME/skills/$skill/SKILL.md" ]; then
    echo "OK: $skill"
  else
    echo "MISSING: $skill"
    status=1
  fi
done

echo
if [ "$status" -eq 0 ]; then
  echo "Doctor passed."
else
  echo "Doctor failed."
fi

exit "$status"
