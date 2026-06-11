# Repository Agent Instructions

Keep this file repo-specific. Do not paste global skill prompts here.

## Repo Purpose

- Purpose: <what this repository owns>

## Commands

- Build: `<build command>`
- Test: `<test command>`
- Lint: `<lint command>`
- Deploy: `<deploy command>`

## Paths

- Terraform paths: `<paths or none>`
- Docker paths: `<Dockerfile, compose files, image build notes or none>`
- Kubernetes paths: `<manifest, kustomize, namespace, cluster notes or none>`
- Argo CD/GitOps paths: `<Application, ApplicationSet, app-of-apps, rollout, image/tag flow notes or none>`
- Helm chart paths: `<paths or none>`
- GitHub Actions notes: `<workflow paths, reusable workflows, runner notes>`
- AWS notes: `<accounts/profiles/regions/resources or none; avoid hard-coded sensitive IDs unless already present and relevant>`
- Cloudflare notes: `<zones, hostnames, WAF/rate-limit/API Shield/Terraform paths or none>`
- Observability notes: `<dashboard, monitor, log, trace, metric, SLO, or runbook paths or none>`
- Database notes: `<engine, migration paths, backup/restore notes, data-safety constraints or none>`

## Production Safety Notes

- Production environments: `<names or none>`
- Approval requirements: `<who or what must approve production-impacting changes>`
- Rollback notes: `<rollback command or runbook link>`
- Sensitive areas: `<state, IAM, networking, DNS, secrets, data stores, etc.>`

Do not commit secrets, kubeconfigs, private keys, tokens, account IDs, or long-lived credentials.

## Skill Examples

Use Docker skill directly:

```text
Use skill: docker-engineer

Task:
Review this Dockerfile for build, security, and runtime issues.
```

Use Kubernetes skill directly:

```text
Use skill: kubernetes-engineer

Task:
Debug why this Deployment is stuck in CrashLoopBackOff.
```

Use Argo CD/GitOps skill directly:

```text
Use skill: argocd-gitops-engineer

Task:
Debug why this Argo CD application is OutOfSync after the tag workflow ran.
```

Use observability skill directly:

```text
Use skill: observability-engineer

Task:
Review why this Datadog alert did not fire during the incident window.
```

Use Cloudflare skill directly:

```text
Use skill: cloudflare-edge-engineer

Task:
Debug why Cloudflare returns 429 for staging API requests.
```

Use database reliability skill directly:

```text
Use skill: database-reliability-engineer

Task:
Review this PostgreSQL migration for lock and rollback risk.
```

Use AWS skill directly:

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

Use router:

```text
Use skill: infra-agent-router

Task:
EKS pods cannot connect to RDS.
```

For AWS-related troubleshooting, use available MCP tools when useful, never assume AWS MCP access exists, prefer read-only MCP or CLI inspection first, ask before write actions, and never print AWS credentials or secrets.
