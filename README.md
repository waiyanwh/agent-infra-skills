# Codex Infra Skills

Private-repo-friendly layout for syncing global Codex instructions and reusable DevOps/SRE/infra skills across macOS and Windows WSL.

Do not commit secrets. Keep tokens, kubeconfigs, private keys, cloud credentials, account IDs, and environment-specific sensitive values out of this repo.

## Layout

```text
AGENTS.md
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
templates/
  repo-AGENTS.md
scripts/
  install.sh
  update.sh
  doctor.sh
```

This repository is the Codex config source. The installer copies files into `CODEX_HOME`, which defaults to `~/.codex`.

## macOS Setup

```bash
git clone <private-repo-url> ~/codex-config
cd ~/codex-config
./scripts/install.sh
./scripts/doctor.sh
```

Use a custom Codex home if needed:

```bash
CODEX_HOME="$HOME/.codex" ./scripts/install.sh
```

## Windows WSL Setup

Run these commands inside WSL, not PowerShell:

```bash
git clone <private-repo-url> ~/codex-config
cd ~/codex-config
./scripts/install.sh
./scripts/doctor.sh
```

Use a custom Codex home inside WSL if needed:

```bash
CODEX_HOME="$HOME/.codex" ./scripts/install.sh
```

## What Install Does

- Copies `AGENTS.md` to `$CODEX_HOME/AGENTS.md`.
- Copies each managed skill directory to `$CODEX_HOME/skills/<skill-name>`.
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

## Update Workflow

Edit the source files in this repo, then commit and push:

```bash
git status
git add AGENTS.md skills templates scripts README.md
git commit -m "Update Codex infra skills"
git push
```

On another machine:

```bash
cd ~/codex-config
./scripts/update.sh
./scripts/doctor.sh
```

`update.sh` runs `git pull --ff-only` and then `install.sh`.

## Per-Repo AGENTS.md

Use `templates/repo-AGENTS.md` as a small starting point for individual repositories. Per-repo files should contain only repo-specific commands, paths, deployment targets, safety notes, and conventions. Do not copy these global skills into every repository.

## Skill Invocation

Use a skill by naming it in the prompt:

```text
Use infra-agent-router for this request.
Use devops-sre-infra-troubleshooter to debug this outage.
Use aws-cloud-engineer to debug this AWS issue.
Use helm-chart-engineer to review this chart.
Use terraform-terragrunt-engineer to review this plan.
Use github-actions-engineer to fix this workflow.
```

If your Codex build supports `$skill` syntax, the same names can be invoked with `$infra-agent-router`, `$helm-chart-engineer`, and so on.

## AWS Skill Examples

Use the AWS skill directly:

```text
Use skill: aws-cloud-engineer

Task:
Debug why ALB targets are unhealthy.
```

Use AWS as reviewer:

```text
Use primary skill: terraform-terragrunt-engineer
Use reviewer skill: aws-cloud-engineer

Task:
Review AWS IAM and networking changes in this Terraform plan.
```

Use the router:

```text
Use skill: infra-agent-router

Task:
EKS pods cannot connect to RDS.
```

## AWS MCP Behavior

For AWS troubleshooting, Codex should use available AWS/cloud MCP tools when useful for live context, prefer read-only MCP or CLI inspection first, and never assume AWS MCP access exists. It should ask before AWS write actions, production-impacting changes, IAM, DNS, route table, security group, restart, scale, deploy, or state-changing actions. It must never print AWS credentials or secrets, and should redact sensitive AWS identifiers where appropriate.
