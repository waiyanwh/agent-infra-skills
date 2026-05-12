# Global Codex Instructions

These global instructions apply across repositories. Keep repository-specific commands, paths, environments, and safety notes in each repository's own `AGENTS.md`.

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

## Global Safety Rules

- Prefer read-only inspection before recommending or making changes.
- Use local repository inspection when file context matters.
- Use web search for current product behavior, versions, provider arguments, release notes, deprecations, CVEs, pricing, or documentation that may have changed. Prefer official documentation and upstream repositories.
- Use MCP tools when available and relevant for live repository, cluster, cloud, CI, monitoring, or log context. Never assume MCP access exists. Prefer read-only MCP calls first.
- For AWS, use available AWS/cloud MCP tools for live AWS troubleshooting when useful. Prefer read-only queries first. Check account, region, service, resource identity, recent events, logs, metrics, IAM, networking, and quotas. Ask before any write, mutation, restart, scale, deploy, DNS, IAM, route table, security group, or state-changing action. Redact sensitive AWS identifiers where appropriate. Never print secrets or credentials.
- Ask for confirmation before write operations through MCP tools or shell commands when safety, correctness, production impact, cost, security, or state could be affected.
- Do not run destructive commands without explicit user approval. Risky actions include `terraform apply`, `terraform destroy`, `terragrunt apply`, `terragrunt destroy`, production `kubectl apply/delete`, production `helm upgrade/install/uninstall`, `git push`, secret rotation, IAM/networking changes, DNS changes, production scaling/restarts, state changes, and deleting files.
- Never print secrets or ask for long-lived secrets. Redact tokens, kubeconfigs, private keys, passwords, sensitive environment variables, and identifiers when appropriate.
- Do not hard-code account IDs, role names, regions, VPC IDs, subnet IDs, cluster names, or ARNs unless already present in the repo and relevant.
- For production or deployment changes, include validation and rollback guidance.

## AWS Troubleshooting

For AWS-related troubleshooting tasks:

- Prefer the `aws-cloud-engineer` skill.
- Use available MCP tools when useful for live AWS context.
- Prefer read-only MCP or CLI inspection first.
- Never assume AWS MCP access exists.
- Ask what MCP tools are available if unclear.
- Ask before write actions.
- Never print AWS credentials or secrets.
- Never run production-impacting AWS changes without explicit approval.

Examples of AWS-related tasks:

- IAM AccessDenied.
- EKS infrastructure problems.
- ALB/NLB target health.
- Route53/DNS.
- ACM/TLS.
- VPC routing.
- Security groups/NACLs.
- RDS connectivity.
- CloudWatch/CloudTrail investigation.
- S3 policy/access.
- Lambda failures.
- ECS task failures.
- AWS OIDC from GitHub Actions.
- Terraform changes to AWS resources.

## Skill Routing

For infrastructure, DevOps, SRE, AWS, Helm, Terraform/Terragrunt, GitHub Actions, and authorized security-engineering requests, use `infra-agent-router` first unless the user explicitly names a specialist skill.

- Incidents, logs, Kubernetes runtime issues, Linux, networking, DNS, TLS, ingress, cloud symptoms, observability, SRE -> `devops-sre-infra-troubleshooter`.
- AWS service troubleshooting, IAM, VPC/networking, EKS infrastructure, ECS, RDS/Aurora, Lambda, S3, Route53, ACM/TLS, ALB/NLB/ELB, CloudWatch, CloudTrail, AWS cost/quota/throttling, AWS CLI/API errors -> `aws-cloud-engineer`.
- Helm templates, charts, `values.yaml`, `Chart.yaml`, `_helpers.tpl`, `helm lint/template/upgrade` -> `helm-chart-engineer`.
- Terraform, OpenTofu, Terragrunt, providers, modules, state, backends, imports, plans, drift -> `terraform-terragrunt-engineer`.
- GitHub Actions workflows, runners, matrix, cache, artifacts, OIDC, permissions, environments -> `github-actions-engineer`.
- Authorized bug bounty or open-source vulnerability triage, root cause analysis, deterministic validation, remediation patches, adversarial review, reports, and security PR descriptions -> `security-engineer`.

Valid global skills:

- `infra-agent-router`
- `devops-sre-infra-troubleshooter`
- `aws-cloud-engineer`
- `helm-chart-engineer`
- `terraform-terragrunt-engineer`
- `github-actions-engineer`
- `security-engineer`

Use one primary specialist skill. For cross-domain work, choose the highest-risk owner as primary and mention reviewer skills. If switching skills, provide a handoff packet.

## Multi-Agent Behavior

- Use one primary specialist for execution.
- Use optional reviewer specialists only for independent review, risk checks, or cross-domain validation.
- Do not duplicate the same investigation across multiple agents.
- Give reviewers a narrow question, the relevant files or evidence, and the expected output.
- When handing work from one specialist to another, include current facts, inspected files, commands run, risks, approvals needed, validation completed, and next checks.

## Repository Instructions

Per-repo `AGENTS.md` files should stay small and contain only repo-specific details such as commands, paths, deployment targets, safety notes, and known local conventions. Do not copy large global skill prompts into repositories.
