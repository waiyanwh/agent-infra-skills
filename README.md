# Agent Infra Skills

Reusable infrastructure, cloud, SRE, and delivery skills for AI coding agents.

The skill content in `skills/` is intentionally agent-agnostic Markdown. Adapter-specific files live under `adapters/`; today this repo includes a Codex adapter that installs the skills into `CODEX_HOME`.

Do not commit secrets. Keep tokens, kubeconfigs, private keys, cloud credentials, account IDs, role names, regions, VPC IDs, subnet IDs, ARNs, and environment-specific sensitive values out of this repo unless already present and directly relevant.

## Layout

```text
skills/
  infra-agent-router/
    SKILL.md
  devops-sre-infra-troubleshooter/
    SKILL.md
  aws-cloud-engineer/
    SKILL.md
  helm-chart-engineer/
    SKILL.md
  terraform-terragrunt-engineer/
    SKILL.md
  github-actions-engineer/
    SKILL.md
adapters/
  codex/
    AGENTS.md
    scripts/
      install.sh
      update.sh
      doctor.sh
    templates/
      repo-AGENTS.md
```

## Skills

- `infra-agent-router`
- `devops-sre-infra-troubleshooter`
- `aws-cloud-engineer`
- `helm-chart-engineer`
- `terraform-terragrunt-engineer`
- `github-actions-engineer`

## Adapter Model

The root `skills/` directory is the reusable source of truth. Each adapter should translate or install those skills for a specific agent runtime without changing the shared skill content.

Current adapter:

- `adapters/codex`: installs global `AGENTS.md` and managed skills into `CODEX_HOME`, which defaults to `~/.codex`.

Future adapters can be added beside it, for example:

```text
adapters/
  codex/
  other-agent/
```

## Other Agent Runtimes

These skills are not tied to Codex. Other agent systems can consume the same `skills/*/SKILL.md` content by adding an adapter that maps the shared skill files into that runtime's native configuration.

Examples:

- Claude Code: generate `CLAUDE.md` plus native agent prompts from `skills/*/SKILL.md`.
- opencode: generate opencode agent definitions from `skills/*/SKILL.md`.
- Other coding agents: import the relevant skill Markdown as role, workflow, and safety instructions.

Keep runtime-specific naming, install paths, and config syntax inside `adapters/<runtime>/`. Keep `skills/` portable.

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
/path/to/project/.codex/
```

Then launch or run Codex for that project with that local Codex home:

```bash
cd /path/to/project
CODEX_HOME="$PWD/.codex" codex
```

If your Codex launcher or environment already supports project-local `.codex` discovery, use that. Otherwise, set `CODEX_HOME` explicitly as shown above.

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
CODEX_HOME="$PWD/.codex" codex
```

## What The Codex Install Does

- Global install copies `adapters/codex/AGENTS.md` to `$CODEX_HOME/AGENTS.md`, defaulting to `~/.codex/AGENTS.md`.
- Local install copies `adapters/codex/AGENTS.md` to `<project>/.codex/AGENTS.md`.
- Copies each managed skill directory from `skills/` to the chosen Codex home at `skills/<skill-name>`.
- Replaces only these managed skill directories:
  - `infra-agent-router`
  - `devops-sre-infra-troubleshooter`
  - `aws-cloud-engineer`
  - `helm-chart-engineer`
  - `terraform-terragrunt-engineer`
  - `github-actions-engineer`
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

## Codex Per-Repo Instructions

Use `adapters/codex/templates/repo-AGENTS.md` as a small starting point for individual repositories. Per-repo files should contain only repo-specific commands, paths, deployment targets, safety notes, and conventions. Do not copy the global skills into every repository.

## Skill Invocation

For agents that support named skills, invoke the skill directly:

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

For Codex builds that support `$skill` syntax, use names like `$infra-agent-router`, `$aws-cloud-engineer`, and `$helm-chart-engineer`.

## AWS MCP Behavior

For AWS troubleshooting, agents should use available AWS/cloud MCP tools when useful for live context, prefer read-only MCP or CLI inspection first, and never assume AWS MCP access exists. Agents should ask before AWS write actions, production-impacting changes, IAM, DNS, route table, security group, restart, scale, deploy, or state-changing actions. They must never print AWS credentials or secrets, and should redact sensitive AWS identifiers where appropriate.
