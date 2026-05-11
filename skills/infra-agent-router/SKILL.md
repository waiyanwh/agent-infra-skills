---
name: infra-agent-router
description: Route DevOps, SRE, infrastructure, AWS cloud, Helm, Terraform/Terragrunt, and GitHub Actions requests to exactly one primary specialist skill, with optional reviewer skills and handoff packets for cross-domain work.
---

# Infra Agent Router

Use this skill when a request involves infrastructure, DevOps, SRE, AWS cloud, Kubernetes runtime behavior, Helm charts, Terraform/OpenTofu/Terragrunt, or GitHub Actions and the best specialist is not already explicit.

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

- Incidents, logs, Kubernetes runtime issues, Linux, networking, DNS, TLS, ingress, cloud symptoms, observability, SRE, incident response, rollback planning -> `devops-sre-infra-troubleshooter`.
- AWS service troubleshooting, IAM permission issues, AWS networking, VPCs, subnets, routes, NACLs, security groups, Route53, ACM/TLS on AWS, ALB/NLB/ELB, CloudWatch logs/metrics/alarms, CloudTrail investigation, EKS infrastructure issues, ECS, RDS/Aurora, Lambda, S3 access/policy, SQS/SNS/EventBridge, AWS cost/quota/throttling, AWS CLI/API errors, AWS managed service debugging -> `aws-cloud-engineer`.
- Helm templates, charts, `values.yaml`, `Chart.yaml`, `_helpers.tpl`, chart dependencies, `helm lint`, `helm template`, Helm releases -> `helm-chart-engineer`.
- Terraform, OpenTofu, Terragrunt, providers, modules, state, backends, workspaces, imports, moved blocks, plans, drift -> `terraform-terragrunt-engineer`.
- GitHub Actions workflows, runners, matrices, caches, artifacts, OIDC, permissions, environments, reusable workflows, composite actions -> `github-actions-engineer`.

## Cross-Domain Selection

Use the domain with the greatest irreversible or production risk as primary:

- Live outage or runtime impact beats source configuration ownership.
- If the issue is Kubernetes runtime behavior on EKS, choose `devops-sre-infra-troubleshooter` as primary and `aws-cloud-engineer` as reviewer.
- If the issue is AWS infrastructure behind Kubernetes, such as ALB, target groups, subnets, IAM roles for service accounts, EBS CSI, or AWS Load Balancer Controller, choose `aws-cloud-engineer` as primary and `devops-sre-infra-troubleshooter` as reviewer.
- If the request is an AWS production incident, choose `aws-cloud-engineer` as primary unless the symptom is mostly Kubernetes runtime behavior.
- Terraform state, backend, IAM, networking, DNS, and replacement risk usually beats chart or CI ownership.
- If Terraform creates or modifies AWS resources, choose `terraform-terragrunt-engineer` as primary and `aws-cloud-engineer` as reviewer.
- Helm release and Kubernetes manifest risk usually beats CI ownership.
- If Helm chart changes target EKS with AWS integrations, choose `helm-chart-engineer` as primary and `aws-cloud-engineer` as reviewer.
- GitHub Actions is primary when the main change is workflow behavior, permissions, triggers, runners, artifacts, caches, or deployment orchestration.
- If GitHub Actions deploys to AWS or uses AWS OIDC, choose `github-actions-engineer` as primary and `aws-cloud-engineer` as reviewer unless IAM/Terraform changes are the highest-risk part.

## Examples

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
“Pods on EKS cannot reach RDS.”

Use skill:
`aws-cloud-engineer`

Secondary reviewers:
`devops-sre-infra-troubleshooter`

Reason:
The likely issue is AWS networking, security groups, DNS, IAM, or RDS access. Kubernetes runtime checks may also be needed.

User request:
“CrashLoopBackOff on EKS after deploy.”

Use skill:
`devops-sre-infra-troubleshooter`

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
