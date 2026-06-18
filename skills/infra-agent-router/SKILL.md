---
name: infra-agent-router
description: Route DevOps, SRE, infrastructure, Docker, Kubernetes, Argo CD/GitOps, observability, Cloudflare edge, database reliability, AWS cloud, Helm, Terraform/Terragrunt, GitHub Actions, and authorized security-engineering requests to exactly one primary specialist skill, with optional reviewer skills and handoff packets for cross-domain work.
---

# Infra Agent Router

Use this skill when a request involves infrastructure, DevOps, SRE, Docker, Kubernetes, Argo CD/GitOps, observability, Cloudflare edge, database reliability, AWS cloud, Helm charts, Terraform/OpenTofu/Terragrunt, GitHub Actions, or authorized security engineering and the best specialist is not already explicit.

## Operating Rules

- Choose exactly one primary specialist skill.
- Mention optional reviewer skills when the work crosses domains.
- Choose the highest-risk owner as primary when several domains apply.
- Do not perform specialist work inside the router unless the user only asked for routing.
- If switching primary skills mid-task, produce a handoff packet before continuing.
- Preserve system, developer, direct user, adapter, and repo-specific instruction files.

## Shared Safety Rules

- Think before coding; state assumptions and ask when unclear.
- Prefer simple solutions and surgical changes.
- Do not refactor unrelated code.
- Define success criteria and validate changes.
- Every changed line should trace to the user request.
- Prefer read-only inspection before writes.
- Use web search for current docs, version compatibility, deprecations, CVEs.
- Use MCP tools when available and relevant; never assume MCP access exists.
- Never print secrets. Never run destructive commands without explicit approval.

## Routing Matrix

- Broad incidents, Linux, networking, DNS, TLS, cloud symptoms, SRE, incident response, rollback planning -> `devops-sre-infra-troubleshooter`.
- Dockerfiles, Docker Compose, container image builds, BuildKit/buildx, image size/security, registry workflows -> `docker-engineer`.
- Kubernetes manifests, Kustomize, kubectl, pods, deployments, services, ingress, Gateway API, RBAC, storage, scheduling, rollout safety -> `kubernetes-engineer`.
- Argo CD applications, GitOps repos, sync health, app-of-apps, ApplicationSets, Argo Rollouts, targetRevision/tag flow -> `argocd-gitops-engineer`.
- Observability, logs, metrics, traces, dashboards, monitors, SLOs, Datadog, CloudWatch, Prometheus, Grafana, OpenTelemetry -> `observability-engineer`.
- Cloudflare DNS, WAF, rate limits, API Shield, mTLS, SSL/TLS, cache, Workers, redirects, bot controls -> `cloudflare-edge-engineer`.
- Database reliability, PostgreSQL, MySQL, RDS/Aurora, MongoDB, Redis, backups, migrations, locks, replication lag, slow queries -> `database-reliability-engineer`.
- AWS service troubleshooting, IAM, networking, VPCs, Route53, ACM, ALB/NLB/ELB, CloudWatch, CloudTrail, EKS infra, ECS, RDS, Lambda, S3, SQS/SNS, cost/quota -> `aws-cloud-engineer`.
- Helm templates, charts, values.yaml, Chart.yaml, _helpers.tpl, dependencies, releases -> `helm-chart-engineer`.
- Terraform, OpenTofu, Terragrunt, providers, modules, state, backends, workspaces, imports, plans, drift -> `terraform-terragrunt-engineer`.
- GitHub Actions workflows, runners, matrices, caches, artifacts, OIDC, permissions, environments, reusable workflows -> `github-actions-engineer`.
- Authorized bug bounty or open-source vulnerability triage, root cause analysis, validation, remediation, adversarial review -> `security-engineer`.

## Cross-Domain Selection

Use the domain with the greatest irreversible or production risk as primary:

- Live outage or runtime impact beats source configuration ownership.
- Kubernetes workload/runtime behavior -> `kubernetes-engineer` primary, `devops-sre-infra-troubleshooter` reviewer.
- Argo CD sync state, app source wiring, Rollouts objects -> `argocd-gitops-engineer` primary, `kubernetes-engineer` or `helm-chart-engineer` reviewer.
- Observability query/signal/alert issues -> `observability-engineer` primary, runtime owner reviewer.
- Cloudflare edge policy -> `cloudflare-edge-engineer` primary, `terraform-terragrunt-engineer` reviewer when IaC owns the change.
- Database runtime behavior -> `database-reliability-engineer` primary, `aws-cloud-engineer` reviewer for RDS/Aurora.
- Kubernetes on EKS -> `kubernetes-engineer` primary, `aws-cloud-engineer` reviewer.
- AWS infrastructure behind Kubernetes (ALB, target groups, IAM IRSA, EBS CSI) -> `aws-cloud-engineer` primary, `kubernetes-engineer` reviewer.
- Terraform creating/modifying AWS resources -> `terraform-terragrunt-engineer` primary, `aws-cloud-engineer` reviewer.
- Helm targeting Kubernetes workloads -> `helm-chart-engineer` primary, `kubernetes-engineer` reviewer.
- GitHub Actions deploying to AWS or using OIDC -> `github-actions-engineer` primary, `aws-cloud-engineer` reviewer unless IAM/Terraform is highest risk.
- GitHub Actions building Docker images -> `github-actions-engineer` primary, `docker-engineer` reviewer.
- Docker image/Dockerfile used by CI -> `docker-engineer` primary unless the change is mainly workflow behavior.

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
