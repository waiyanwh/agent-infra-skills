#!/usr/bin/env bash
set -euo pipefail

CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
status=0

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
  github-actions-engineer
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
