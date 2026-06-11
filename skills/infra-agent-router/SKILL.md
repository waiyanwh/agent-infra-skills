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
- Ask clarifying questions when safety, correctness, production impact, cost, security, or state could be affected.
- Prefer read-only inspection before writes.
- Use web search for current docs, version compatibility, release notes, provider behavior, deprecations, CVEs, and current product behavior.
- Use MCP tools when available and relevant; never assume MCP access exists.
- For AWS, use available AWS/cloud MCP tools for live troubleshooting when useful; prefer read-only queries first; check account, region, service, resource identity, recent events, logs, metrics, IAM, networking, and quotas; ask before any write, mutation, restart, scale, deploy, DNS, IAM, route table, security group, or state-changing action; redact sensitive AWS identifiers where appropriate; never print secrets or credentials.
- Never print secrets.
- Never run destructive commands without explicit approval.

## Routing Matrix

- Broad incidents, Linux, networking, DNS, TLS, cloud symptoms, SRE, incident response, and rollback planning -> `devops-sre-infra-troubleshooter`.
- Dockerfiles, Docker Compose, container image builds, BuildKit/buildx, local container runtime issues, image size/security, registry workflows, and container hardening -> `docker-engineer`.
- Kubernetes manifests, Kustomize overlays, kubectl errors, pods, deployments, services, ingress, Gateway API, RBAC, storage, scheduling, rollout safety, and live cluster debugging -> `kubernetes-engineer`.
- Argo CD applications, GitOps repos, sync health, app-of-apps, ApplicationSets, Argo Rollouts integration, targetRevision/tag flow, repo credentials, and generated app values -> `argocd-gitops-engineer`.
- Observability, logs, metrics, traces, dashboards, monitors, SLOs, Datadog, CloudWatch, Prometheus, Grafana, OpenTelemetry, alert tuning, and telemetry gaps -> `observability-engineer`.
- Cloudflare DNS, WAF, rate limits, custom rules, API Shield, mTLS, SSL/TLS, cache, Workers, redirects, bot controls, and edge 4xx/5xx/429 debugging -> `cloudflare-edge-engineer`.
- Database reliability, PostgreSQL, MySQL, RDS/Aurora, MongoDB, Redis, backups, migrations, locks, replication lag, slow queries, connection pressure, and restore planning -> `database-reliability-engineer`.
- AWS service troubleshooting, IAM permission issues, AWS networking, VPCs, subnets, routes, NACLs, security groups, Route53, ACM/TLS on AWS, ALB/NLB/ELB, CloudWatch logs/metrics/alarms, CloudTrail investigation, EKS infrastructure issues, ECS, RDS/Aurora, Lambda, S3 access/policy, SQS/SNS/EventBridge, AWS cost/quota/throttling, AWS CLI/API errors, AWS managed service debugging -> `aws-cloud-engineer`.
- Helm templates, charts, `values.yaml`, `Chart.yaml`, `_helpers.tpl`, chart dependencies, `helm lint`, `helm template`, Helm releases -> `helm-chart-engineer`.
- Terraform, OpenTofu, Terragrunt, providers, modules, state, backends, workspaces, imports, moved blocks, plans, drift -> `terraform-terragrunt-engineer`.
- GitHub Actions workflows, runners, matrices, caches, artifacts, OIDC, permissions, environments, reusable workflows, composite actions -> `github-actions-engineer`.
- Authorized bug bounty or open-source vulnerability triage, root cause analysis, deterministic validation, remediation patches, adversarial review, reports, and security PR descriptions -> `security-engineer`.

## Cross-Domain Selection

Use the domain with the greatest irreversible or production risk as primary:

- Live outage or runtime impact beats source configuration ownership.
- If the issue is Kubernetes workload/runtime behavior, choose `kubernetes-engineer` as primary and use `devops-sre-infra-troubleshooter` as reviewer for broader incident handling when needed.
- If the issue is Argo CD sync state, app source wiring, generated app values, target revisions, or Rollouts objects owned through GitOps, choose `argocd-gitops-engineer` as primary and use `kubernetes-engineer` or `helm-chart-engineer` as reviewers as needed.
- If the issue is observability query behavior, missing telemetry, noisy alerts, dashboards, monitors, SLOs, or trace/log/metric correlation, choose `observability-engineer` as primary and use the runtime owner as reviewer.
- If the issue is Cloudflare WAF/rate limits/API Shield/mTLS/DNS/proxy behavior, choose `cloudflare-edge-engineer` as primary and use `terraform-terragrunt-engineer` as reviewer when IaC owns the change.
- If the issue is database runtime behavior, migrations, backups, locks, replication, or query performance, choose `database-reliability-engineer` as primary and use `aws-cloud-engineer` as reviewer for RDS/Aurora infrastructure.
- If the issue is Kubernetes runtime behavior on EKS, choose `kubernetes-engineer` as primary and `aws-cloud-engineer` as reviewer.
- If the issue is AWS infrastructure behind Kubernetes, such as ALB, target groups, subnets, IAM roles for service accounts, EBS CSI, or AWS Load Balancer Controller, choose `aws-cloud-engineer` as primary and `kubernetes-engineer` as reviewer.
- If the request is an AWS production incident, choose `aws-cloud-engineer` as primary unless the symptom is mostly Kubernetes workload behavior.
- If the issue is a Docker image build or Dockerfile used by CI, choose `docker-engineer` as primary unless the requested change is mainly workflow triggers, permissions, artifacts, or runner behavior.
- Terraform state, backend, IAM, networking, DNS, and replacement risk usually beats chart or CI ownership.
- If Terraform creates or modifies AWS resources, choose `terraform-terragrunt-engineer` as primary and `aws-cloud-engineer` as reviewer.
- Helm release and Kubernetes manifest risk usually beats CI ownership.
- If Helm chart changes target Kubernetes workloads, choose `helm-chart-engineer` as primary and `kubernetes-engineer` as reviewer.
- If Helm chart changes target EKS with AWS integrations, choose `helm-chart-engineer` as primary and use `aws-cloud-engineer` and `kubernetes-engineer` as reviewers as needed.
- GitHub Actions is primary when the main change is workflow behavior, permissions, triggers, runners, artifacts, caches, or deployment orchestration.
- If GitHub Actions deploys to AWS or uses AWS OIDC, choose `github-actions-engineer` as primary and `aws-cloud-engineer` as reviewer unless IAM/Terraform changes are the highest-risk part.
- If GitHub Actions builds Docker images, choose `github-actions-engineer` as primary for workflow behavior and `docker-engineer` as reviewer for image/build behavior.

## Examples

User request:
“Argo CD app is OutOfSync after the tag workflow ran.”

Use skill:
`argocd-gitops-engineer`

Secondary reviewers:
`github-actions-engineer`

Reason:
The main surface is GitOps source and Argo CD application state. The workflow reviewer checks tag/update automation if needed.

User request:
“Datadog alert did not fire during the outage.”

Use skill:
`observability-engineer`

Secondary reviewers:
`devops-sre-infra-troubleshooter`

Reason:
The primary surface is monitor/query/signal behavior. SRE reviewer checks incident context and mitigation.

User request:
“Cloudflare returns 429 for staging API calls.”

Use skill:
`cloudflare-edge-engineer`

Secondary reviewers:
`terraform-terragrunt-engineer`

Reason:
The main surface is Cloudflare edge policy. Terraform reviewer checks IaC-managed rule changes.

User request:
“Aurora has high connections and slow queries after deploy.”

Use skill:
`database-reliability-engineer`

Secondary reviewers:
`aws-cloud-engineer`

Reason:
The primary surface is database runtime behavior. AWS reviewer checks RDS/Aurora infrastructure.

User request:
“GitHub Actions OIDC to AWS fails with AccessDenied.”

Use skill:
`github-actions-engineer`

Secondary reviewers:
`aws-cloud-engineer`

Reason:
The failure is in CI authentication flow. AWS reviewer checks IAM trust and permissions.

User request:
“Terraform plan changes IAM roles and security groups in AWS.”

Use skill:
`terraform-terragrunt-engineer`

Secondary reviewers:
`aws-cloud-engineer`

Reason:
Terraform owns IaC plan review. AWS reviewer checks IAM/networking blast radius.

User request:
“Docker image build fails in GitHub Actions after changing the Dockerfile.”

Use skill:
`docker-engineer`

Secondary reviewers:
`github-actions-engineer`

Reason:
The main failure surface is the Dockerfile/image build. The GitHub Actions reviewer checks workflow and runner behavior if needed.

User request:
“Pods on EKS cannot reach RDS.”

Use skill:
`aws-cloud-engineer`

Secondary reviewers:
`kubernetes-engineer`

Reason:
The likely issue is AWS networking, security groups, DNS, IAM, or RDS access. Kubernetes runtime checks may also be needed.

User request:
“CrashLoopBackOff on EKS after deploy.”

Use skill:
`kubernetes-engineer`

Secondary reviewers:
`aws-cloud-engineer`

Reason:
The primary symptom is Kubernetes runtime failure. AWS reviewer checks EKS, IAM, ECR, node, and networking dependencies if needed.

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
