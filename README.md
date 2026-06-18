# Agent Infra and Security Skills

Reusable infrastructure, containers, Kubernetes, GitOps, observability, edge, database, cloud, SRE, delivery, and authorized security-engineering skills for AI coding agents.

The skill content in `skills/` is intentionally agent-agnostic Markdown. Adapter-specific files live under `adapters/`; this repo includes adapters for Codex, Claude Code, and opencode.

Do not commit secrets. Keep tokens, kubeconfigs, private keys, cloud credentials, account IDs, role names, regions, VPC IDs, subnet IDs, ARNs, and environment-specific sensitive values out of this repo unless already present and directly relevant.

## Layout

```text
AGENTS.md
.agents/
  skills/
    <skill-name> -> ../../skills/<skill-name>
skills/
  infra-agent-router/
    SKILL.md
  devops-sre-infra-troubleshooter/
    SKILL.md
  docker-engineer/
    SKILL.md
  kubernetes-engineer/
    SKILL.md
  argocd-gitops-engineer/
    SKILL.md
  observability-engineer/
    SKILL.md
  cloudflare-edge-engineer/
    SKILL.md
  database-reliability-engineer/
    SKILL.md
  aws-cloud-engineer/
    SKILL.md
    references/
      checklists.md
      cli-commands.md
  helm-chart-engineer/
    SKILL.md
  terraform-terragrunt-engineer/
    SKILL.md
  github-actions-engineer/
    SKILL.md
  security-engineer/
    SKILL.md
    references/
      methodology.md
adapters/
  codex/
    AGENTS.md
    scripts/
      install.sh
      update.sh
      doctor.sh
    templates/
      repo-AGENTS.md
  claude-code/
    scripts/
      install.sh
      update.sh
      doctor.sh
  opencode/
    scripts/
      install.sh
      update.sh
      doctor.sh
```

### Skill references

Some skills have a `references/` subdirectory containing detailed content that is loaded on demand rather than always injected into context. This reduces token usage for Codex and Cursor, where the agent reads SKILL.md first and can then selectively read reference files.

For Claude Code and opencode, the adapter install scripts automatically inline reference content into the generated agent files since those runtimes use single flat Markdown agents.

## Skills

- `infra-agent-router`
- `devops-sre-infra-troubleshooter`
- `docker-engineer`
- `kubernetes-engineer`
- `argocd-gitops-engineer`
- `observability-engineer`
- `cloudflare-edge-engineer`
- `database-reliability-engineer`
- `aws-cloud-engineer`
- `helm-chart-engineer`
- `terraform-terragrunt-engineer`
- `github-actions-engineer`
- `security-engineer`

## Adapter Model

The root `skills/` directory is the reusable source of truth. Each adapter should translate or install those skills for a specific agent runtime without changing the shared skill content.

Current adapters:

- `.agents/skills`: repo-local symlink index so Codex can pick up these skills when this repository is opened directly.
- `adapters/codex`: installs managed skills globally into `CODEX_HOME`, or locally into a target project's `.agents/skills/`.
- `adapters/claude-code`: generates Claude Code subagents from `skills/*/SKILL.md` into `~/.claude/agents/` or `<project>/.claude/agents/`.
- `adapters/opencode`: generates opencode subagents from `skills/*/SKILL.md` into `~/.config/opencode/agents/` or `<project>/.opencode/agents/`.

## Other Agent Runtimes

These skills are not tied to Codex. Other agent systems can consume the same `skills/*/SKILL.md` content by adding an adapter that maps the shared skill files into that runtime's native configuration.

Examples:

- Claude Code: generate native subagents from `skills/*/SKILL.md`.
- opencode: generate native subagents from `skills/*/SKILL.md`.
- Other coding agents: import the relevant skill Markdown as role, workflow, and safety instructions.

Keep runtime-specific naming, install paths, and config syntax inside `adapters/<runtime>/`. Keep `skills/` portable.

## Codex Repo-Compatible Usage

This repository is directly consumable by Codex:

- Open Codex from this repository root to use the repo-local symlinked skills in `.agents/skills/`.
- Use `--local /path/to/project` to install copies into another project's `.agents/skills/`.
- Use `--global` only when you intentionally want these skills available in every Codex workspace on the machine.

The repo default branch is `master`. When using tools that default to `main`, pass `--ref master`.

## Codex Global Install

Use global install when you want these skills available in every Codex session on that machine.

```bash
git clone <repo-url> ~/agent-infra-skills
cd ~/agent-infra-skills
./adapters/codex/scripts/install.sh --global
./adapters/codex/scripts/doctor.sh --global
```

Use a custom Codex home if needed:

```bash
./adapters/codex/scripts/install.sh --codex-home "$HOME/.codex"
./adapters/codex/scripts/doctor.sh --codex-home "$HOME/.codex"
```

## Codex Local Project Install

Use local install when you only want these skills available for a specific project or workspace.

```bash
cd ~/agent-infra-skills
./adapters/codex/scripts/install.sh --local /path/to/project
./adapters/codex/scripts/doctor.sh --local /path/to/project
```

This writes the adapter files to:

```text
/path/to/project/.agents/skills/
```

Then launch or run Codex from that project:

```bash
cd /path/to/project
codex
```

Local installs do not overwrite the target project's `AGENTS.md`. Use `adapters/codex/templates/repo-AGENTS.md` as a starting point if the project does not already have repo-specific guidance.

## Codex Skill-Installer Examples

To install one skill globally with Codex's skill installer, pass the repo, branch, and skill path:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo waiyanwh/agent-infra-skills \
  --ref master \
  --path skills/aws-cloud-engineer
```

To install into a project-local skill directory with the same helper, use `--dest`:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo waiyanwh/agent-infra-skills \
  --ref master \
  --path skills/aws-cloud-engineer \
  --dest /path/to/project/.agents/skills
```

For all managed skills, prefer this repo's adapter script:

```bash
./adapters/codex/scripts/install.sh --local /path/to/project
```

## Codex Windows WSL Setup

Run these commands inside WSL, not PowerShell:

```bash
git clone <repo-url> ~/agent-infra-skills
cd ~/agent-infra-skills
./adapters/codex/scripts/install.sh --global
./adapters/codex/scripts/doctor.sh --global
```

For project-local WSL usage:

```bash
cd ~/agent-infra-skills
./adapters/codex/scripts/install.sh --local ~/work/news-project
./adapters/codex/scripts/doctor.sh --local ~/work/news-project

cd ~/work/news-project
codex
```

## What The Codex Install Does

- Global install copies `adapters/codex/AGENTS.md` to `$CODEX_HOME/AGENTS.md`, defaulting to `~/.codex/AGENTS.md`.
- Local install does not overwrite project instructions; it installs skills under `<project>/.agents/skills/`.
- Copies each managed skill directory from `skills/` to the chosen skill target.
- Replaces only these managed skill directories:
  - `infra-agent-router`
  - `devops-sre-infra-troubleshooter`
  - `docker-engineer`
  - `kubernetes-engineer`
  - `argocd-gitops-engineer`
  - `observability-engineer`
  - `cloudflare-edge-engineer`
  - `database-reliability-engineer`
  - `aws-cloud-engineer`
  - `helm-chart-engineer`
  - `terraform-terragrunt-engineer`
  - `github-actions-engineer`
  - `security-engineer`
- Does not symlink skills.
- Does not delete unmanaged skills.

Restart Codex after installing or updating skills so the new instructions are loaded.

## Codex Update Workflow

Edit the source files in this repo, then commit and push:

```bash
git status
git add README.md skills adapters
git commit -m "Update agent infra skills"
git push
```

On another machine:

```bash
cd ~/agent-infra-skills
./adapters/codex/scripts/update.sh --global
./adapters/codex/scripts/doctor.sh --global
```

For a local project install:

```bash
cd ~/agent-infra-skills
./adapters/codex/scripts/update.sh --local /path/to/project
./adapters/codex/scripts/doctor.sh --local /path/to/project
```

`update.sh` runs `git pull --ff-only` and then the Codex adapter installer with the same install arguments.

## Claude Code Global Install

Use global install when you want these skills available as Claude Code/OpenClaude agents in every project on that machine.

```bash
git clone <repo-url> ~/agent-infra-skills
cd ~/agent-infra-skills
./adapters/claude-code/scripts/install.sh --global
./adapters/claude-code/scripts/doctor.sh --global
```

Use a custom Claude Code home if needed:

```bash
./adapters/claude-code/scripts/install.sh --claude-home "$HOME/.claude"
./adapters/claude-code/scripts/doctor.sh --claude-home "$HOME/.claude"
```

## Claude Code Local Project Install

Use local install when you only want these agents available for a specific project.

```bash
cd ~/agent-infra-skills
./adapters/claude-code/scripts/install.sh --local /path/to/project
./adapters/claude-code/scripts/doctor.sh --local /path/to/project
```

This writes generated agent files to:

```text
/path/to/project/.claude/agents/
```

The Claude Code adapter replaces only managed agent files named after the skills. It does not overwrite `CLAUDE.md` or delete unmanaged Claude Code/OpenClaude agents.

Verify OpenClaude sees the generated agents:

```bash
openclaude agents
```

Run OpenClaude with a generated agent:

```bash
openclaude --agent docker-engineer
```

Non-interactive smoke test:

```bash
openclaude --agent docker-engineer -p --tools "" --no-session-persistence "Reply with exactly: docker-engineer agent loaded"
```

## Claude Code Update Workflow

```bash
cd ~/agent-infra-skills
./adapters/claude-code/scripts/update.sh --global
./adapters/claude-code/scripts/doctor.sh --global
```

For a local project install:

```bash
cd ~/agent-infra-skills
./adapters/claude-code/scripts/update.sh --local /path/to/project
./adapters/claude-code/scripts/doctor.sh --local /path/to/project
```

## opencode Global Install

Use global install when you want these skills available as opencode subagents in every project on that machine.

```bash
git clone <repo-url> ~/agent-infra-skills
cd ~/agent-infra-skills
./adapters/opencode/scripts/install.sh --global
./adapters/opencode/scripts/doctor.sh --global
```

Use a custom opencode config path if needed:

```bash
./adapters/opencode/scripts/install.sh --opencode-home "$HOME/.config/opencode"
./adapters/opencode/scripts/doctor.sh --opencode-home "$HOME/.config/opencode"
```

## opencode Local Project Install

Use local install when you only want these subagents available for a specific project.

```bash
cd ~/agent-infra-skills
./adapters/opencode/scripts/install.sh --local /path/to/project
./adapters/opencode/scripts/doctor.sh --local /path/to/project
```

This writes generated subagent files to:

```text
/path/to/project/.opencode/agents/
```

The opencode adapter replaces only managed agent files named after the skills. It does not overwrite `opencode.json` or delete unmanaged opencode agents.

Verify opencode sees the generated subagents:

```bash
opencode agent list
```

The generated opencode agents are `mode: subagent`. In opencode, subagents are invoked by `@` mention from a primary agent session; they are not selected with `opencode run --agent <name>`, because that flag selects primary agents.

TUI example:

```text
@docker-engineer review this Dockerfile for build and runtime issues
```

CLI example:

```bash
opencode run "@kubernetes-engineer debug why this Deployment is stuck in CrashLoopBackOff"
```

## opencode Update Workflow

```bash
cd ~/agent-infra-skills
./adapters/opencode/scripts/update.sh --global
./adapters/opencode/scripts/doctor.sh --global
```

For a local project install:

```bash
cd ~/agent-infra-skills
./adapters/opencode/scripts/update.sh --local /path/to/project
./adapters/opencode/scripts/doctor.sh --local /path/to/project
```

## Codex Per-Repo Instructions

Use `adapters/codex/templates/repo-AGENTS.md` as a small starting point for individual repositories. Per-repo files should contain only repo-specific commands, paths, deployment targets, safety notes, and conventions. Do not copy the global skills into every repository.

## Skill Invocation

For agents that support named skills, invoke the skill directly:

```text
Use skill: docker-engineer

Task:
Review this Dockerfile for build, security, and runtime issues.
```

```text
Use skill: kubernetes-engineer

Task:
Debug why this Deployment is stuck in CrashLoopBackOff.
```

```text
Use skill: argocd-gitops-engineer

Task:
Debug why this Argo CD application is OutOfSync after the tag workflow ran.
```

```text
Use skill: observability-engineer

Task:
Review why this Datadog alert did not fire during the incident window.
```

```text
Use skill: cloudflare-edge-engineer

Task:
Debug why Cloudflare returns 429 for staging API requests.
```

```text
Use skill: database-reliability-engineer

Task:
Review this PostgreSQL migration for lock and rollback risk.
```

```text
Use skill: aws-cloud-engineer

Task:
Debug why ALB targets are unhealthy.
```

For reviewer-style use:

```text
Use primary skill: terraform-terragrunt-engineer
Use reviewer skill: aws-cloud-engineer

Task:
Review AWS IAM and networking changes in this Terraform plan.
```

For routing:

```text
Use skill: infra-agent-router

Task:
EKS pods cannot connect to RDS.
```

For Codex builds that support `$skill` syntax, use names like `$infra-agent-router`, `$docker-engineer`, `$kubernetes-engineer`, `$argocd-gitops-engineer`, `$observability-engineer`, `$cloudflare-edge-engineer`, `$database-reliability-engineer`, `$aws-cloud-engineer`, and `$helm-chart-engineer`.

For Claude Code/OpenClaude, select generated agents with the runtime's agent selector. With OpenClaude:

```bash
openclaude --agent docker-engineer
openclaude --agent kubernetes-engineer -p "Review this manifest"
openclaude --agent argocd-gitops-engineer -p "Debug this Argo CD sync failure"
```

For opencode, invoke generated subagents with `@` mentions, for example:

```text
@infra-agent-router route this infrastructure issue to the right specialist
@docker-engineer review this Dockerfile
@kubernetes-engineer debug this pod failure
@argocd-gitops-engineer debug this sync failure
@observability-engineer review this noisy monitor
@cloudflare-edge-engineer debug this WAF block
@database-reliability-engineer review this migration risk
```

Do not use `opencode run --agent docker-engineer` for these generated opencode agents. They are subagents, and opencode's `--agent` flag is for primary agents.

## AWS MCP Behavior

For AWS troubleshooting, agents should use available AWS/cloud MCP tools when useful for live context, prefer read-only MCP or CLI inspection first, and never assume AWS MCP access exists. Agents should ask before AWS write actions, production-impacting changes, IAM, DNS, route table, security group, restart, scale, deploy, or state-changing actions. They must never print AWS credentials or secrets, and should redact sensitive AWS identifiers where appropriate.
