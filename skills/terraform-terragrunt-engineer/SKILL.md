---
name: terraform-terragrunt-engineer
description: Work on Terraform, OpenTofu, and Terragrunt modules, providers, state, backends, workspaces, dependency blocks, imports, moved blocks, plan review, drift analysis, and safe IaC refactoring.
---

# Terraform Terragrunt Engineer

Use this skill for Terraform, OpenTofu, Terragrunt, modules, providers, state, backends, workspaces, dependency blocks, imports, moved blocks, plan review, drift analysis, and safe infrastructure-as-code refactoring.

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
- For AWS-related troubleshooting or AWS resource review, use available AWS/cloud MCP tools when useful, prefer read-only queries first, ask before AWS write actions, and never print AWS secrets or credentials.
- Never print secrets; redact plan values when they reveal secrets or sensitive identifiers.
- Never run destructive commands without explicit approval.

## Workflow

1. Identify toolchain: Terraform, OpenTofu, Terragrunt, versions, backend, workspace, environment, and affected paths.
2. Inspect module structure, provider constraints, backend config, variables, outputs, lock files, and repo-specific instruction files before editing.
3. Prefer minimal HCL changes that preserve state addresses unless the user requested refactoring.
4. For refactors, use `moved` blocks when possible and explain state impact.
5. Validate formatting and static checks before planning.
6. Review plans for replacements, deletes, IAM/networking/DNS impact, and cost or security changes.

## Validation Commands

Use the relevant subset:

```bash
terraform fmt -check -recursive
terraform validate
terraform plan
terragrunt hclfmt --check
terragrunt validate
terragrunt plan
tflint
checkov -d <path>
tfsec <path>
```

Use `tflint`, `checkov`, and `tfsec` only if available or requested. Treat `plan` as read-only but still environment-sensitive because it may contact providers and expose sensitive values.

## Warn And Require Approval Before

- `terraform apply`, `tofu apply`, or `terragrunt apply`.
- `terraform destroy`, `tofu destroy`, or `terragrunt destroy`.
- Backend migration.
- `state rm`, `state mv`, import operations, or `force-unlock`.
- Resource replacement.
- IAM changes.
- Networking changes.
- Production DNS changes.
- Any stateful or irreversible operation.

## Review Focus

Check state address stability, provider version compatibility, backend safety, dependency ordering, lifecycle rules, `for_each` key stability, import/moved block correctness, least privilege, network blast radius, and rollback options.
