#!/usr/bin/env bash
set -euo pipefail

INSTALL_SCOPE="global"
PROJECT_DIR=""

usage() {
  cat <<'USAGE'
Usage:
  doctor.sh [--global]
  doctor.sh --local [project-dir]
  doctor.sh --opencode-home <path>

Options:
  --global                Check OPENCODE_HOME or ~/.config/opencode. This is the default.
  --local [project]      Check <project>/.opencode. Defaults to the current directory.
  --opencode-home <path> Check an explicit opencode config path.
  -h, --help             Show this help.
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
    --opencode-home)
      if [ "${2:-}" = "" ]; then
        echo "ERROR: --opencode-home requires a path" >&2
        exit 1
      fi
      INSTALL_SCOPE="explicit"
      OPENCODE_HOME="$2"
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
  OPENCODE_HOME="$PROJECT_DIR/.opencode"
else
  OPENCODE_HOME="${OPENCODE_HOME:-$HOME/.config/opencode}"
fi

DEST_AGENTS="$OPENCODE_HOME/agents"
status=0

echo "Scope: $INSTALL_SCOPE"
if [ "$INSTALL_SCOPE" = "local" ]; then
  echo "Project: $PROJECT_DIR"
fi
echo "OPENCODE_HOME: $OPENCODE_HOME"
echo
echo "opencode agents:"

for skill in \
  infra-agent-router \
  devops-sre-infra-troubleshooter \
  docker-engineer \
  kubernetes-engineer \
  argocd-gitops-engineer \
  observability-engineer \
  cloudflare-edge-engineer \
  database-reliability-engineer \
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
