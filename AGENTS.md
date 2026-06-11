# Agent Infra Skills Repo Guide

## Repository Role

This repository owns reusable infrastructure, DevOps, cloud, Kubernetes, Docker, delivery, and authorized security-engineering skills for AI coding agents.

The shared skill source of truth is `skills/*/SKILL.md`. Runtime-specific install logic lives under `adapters/`.

## Layout

- `.agents/skills/`: symlink index so Codex can discover this repo's skills when opened from the repo root.
- `skills/`: agent-agnostic skill source directories.
- `adapters/codex/`: Codex install, update, doctor scripts, global `AGENTS.md`, and repo template.
- `adapters/claude-code/`: Claude Code/OpenClaude agent generator and checks.
- `adapters/opencode/`: opencode subagent generator and checks.

## Editing Rules

- Keep skill content runtime-agnostic unless the skill is explicitly about one runtime.
- Keep Codex, Claude Code, and opencode path/config differences inside their adapter directories.
- When adding or renaming a skill, update the skill directory, router coverage, install scripts, doctor scripts, README, and `.agents/skills` index together.
- Do not commit secrets, kubeconfigs, private keys, long-lived tokens, account IDs, ARNs, or environment-specific sensitive values.

## Validation

Run the relevant checks after edits:

```bash
./adapters/codex/scripts/doctor.sh --local .
./adapters/codex/scripts/install.sh --local /tmp/agent-infra-skills-codex-test
./adapters/codex/scripts/doctor.sh --local /tmp/agent-infra-skills-codex-test
./adapters/claude-code/scripts/doctor.sh --local /tmp/agent-infra-skills-claude-test
./adapters/opencode/scripts/doctor.sh --local /tmp/agent-infra-skills-opencode-test
```

Use `git diff --check` before committing.

## Install Model

- Global install is opt-in and writes to user-level runtime config.
- Local install is preferred for project-scoped usage.
- Codex local install writes to `<project>/.agents/skills/`.
- Claude Code/OpenClaude local install writes to `<project>/.claude/agents/`.
- opencode local install writes to `<project>/.opencode/agents/`.
