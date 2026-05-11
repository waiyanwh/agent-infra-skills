---
name: infra-agent-router
description: Route DevOps, SRE, infrastructure, Helm, Terraform/Terragrunt, and GitHub Actions requests to exactly one primary specialist skill, with optional reviewer skills and handoff packets for cross-domain work.
---

# Infra Agent Router

Use this skill when a request involves infrastructure, DevOps, SRE, Kubernetes runtime behavior, Helm charts, Terraform/OpenTofu/Terragrunt, or GitHub Actions and the best specialist is not already explicit.

## Operating Rules

- Choose exactly one primary specialist skill.
- Mention optional reviewer skills when the work crosses domains.
- Choose the highest-risk owner as primary when several domains apply.
- Do not perform specialist work inside the router unless the user only asked for routing.
- If switching primary skills mid-task, produce a handoff packet before continuing.
- Preserve system, developer, direct user, and repo `AGENTS.md` instructions.

## Shared Safety Rules

- Think before coding; state assumptions and ask when unclear.
- Prefer simple solutions and surgical changes.
- Do not refactor unrelated code.
- Define success criteria and validate changes.
- Every changed line should trace to the user request.
- Ask clarifying questions when safety, correctness, production impact, cost, security, or state could be affected.
- Prefer read-only inspection before writes.
- Use web search for current docs, version compatibility, release notes, provider behavior, deprecations, CVEs, and current product behavior.
- Use MCP tools when available and relevant; never assume MCP access exists.
- Never print secrets.
- Never run destructive commands without explicit approval.

## Routing Matrix

- Incidents, logs, Kubernetes runtime issues, Linux, networking, DNS, TLS, ingress, cloud symptoms, observability, SRE, incident response, rollback planning -> `devops-sre-infra-troubleshooter`.
- Helm templates, charts, `values.yaml`, `Chart.yaml`, `_helpers.tpl`, chart dependencies, `helm lint`, `helm template`, Helm releases -> `helm-chart-engineer`.
- Terraform, OpenTofu, Terragrunt, providers, modules, state, backends, workspaces, imports, moved blocks, plans, drift -> `terraform-terragrunt-engineer`.
- GitHub Actions workflows, runners, matrices, caches, artifacts, OIDC, permissions, environments, reusable workflows, composite actions -> `github-actions-engineer`.

## Cross-Domain Selection

Use the domain with the greatest irreversible or production risk as primary:

- Live outage or runtime impact beats source configuration ownership.
- Terraform state, backend, IAM, networking, DNS, and replacement risk usually beats chart or CI ownership.
- Helm release and Kubernetes manifest risk usually beats CI ownership.
- GitHub Actions is primary when the main change is workflow behavior, permissions, triggers, runners, artifacts, caches, or deployment orchestration.

## Handoff Packet

When switching skills, produce:

- Primary skill now:
- Previous skill:
- Reason for switch:
- Current facts:
- Files/resources inspected:
- Commands/MCP/web sources used:
- Risks and approvals needed:
- Validation already completed:
- Next recommended checks:
