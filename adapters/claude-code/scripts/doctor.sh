#!/usr/bin/env bash
set -euo pipefail

INSTALL_SCOPE="global"
PROJECT_DIR=""

usage() {
  cat <<'USAGE'
Usage:
  doctor.sh [--global]
  doctor.sh --local [project-dir]
  doctor.sh --claude-home <path>

Options:
  --global              Check CLAUDE_HOME or ~/.claude. This is the default.
  --local [project]    Check <project>/.claude. Defaults to the current directory.
  --claude-home <path> Check an explicit Claude Code home path.
  -h, --help           Show this help.
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
    --claude-home)
      if [ "${2:-}" = "" ]; then
        echo "ERROR: --claude-home requires a path" >&2
        exit 1
      fi
      INSTALL_SCOPE="explicit"
      CLAUDE_HOME="$2"
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
  CLAUDE_HOME="$PROJECT_DIR/.claude"
else
  CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
fi

DEST_AGENTS="$CLAUDE_HOME/agents"
status=0

echo "Scope: $INSTALL_SCOPE"
if [ "$INSTALL_SCOPE" = "local" ]; then
  echo "Project: $PROJECT_DIR"
fi
echo "CLAUDE_HOME: $CLAUDE_HOME"
echo
echo "Claude Code agents:"

for skill in \
  infra-agent-router \
  devops-sre-infra-troubleshooter \
  docker-engineer \
  kubernetes-engineer \
  aws-cloud-engineer \
  helm-chart-engineer \
  terraform-terragrunt-engineer \
  github-actions-engineer \
  security-engineer
do
  if [ -f "$DEST_AGENTS/$skill.md" ]; then
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
