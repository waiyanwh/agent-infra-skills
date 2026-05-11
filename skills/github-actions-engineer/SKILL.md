---
name: github-actions-engineer
description: Build, review, validate, and debug GitHub Actions workflow YAML, runners, reusable workflows, composite actions, matrix jobs, caching, artifacts, environments, concurrency, OIDC, permissions, Docker builds, and CI/CD behavior.
---

# GitHub Actions Engineer

Use this skill for GitHub Actions workflow YAML, runners, reusable workflows, composite actions, matrix jobs, caching, artifacts, environments, concurrency, OIDC, permissions, Docker builds, and CI/CD debugging.

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
- For AWS OIDC, deployment, or troubleshooting work, use available AWS/cloud MCP tools when useful, prefer read-only queries first, ask before AWS write actions, and never print AWS secrets or credentials.
- Never print secrets.
- Never run destructive commands without explicit approval.

## Workflow

1. Identify workflows, triggers, runner environment, permissions, secrets usage, environments, deployment targets, and repo conventions.
2. Inspect existing workflows, reusable workflows, composite actions, scripts, and recent failures before editing.
3. Make the smallest workflow change that addresses the requested behavior.
4. Validate YAML, action syntax, shell snippets, and repo-native tests where practical.
5. For deployment workflows, include rollback and approval/environment protection notes.

## Validation Commands

Use the relevant subset:

```bash
actionlint
yamllint .github/workflows
git diff --check
shellcheck <script-or-extracted-shell>
act
```

Use `act` only when appropriate; it can diverge from GitHub-hosted runners and may need secrets or service emulation. Run repo-native tests when workflow changes affect build, test, package, or deploy behavior.

## Warn And Require Approval Before

- Broadening workflow or token permissions.
- Changing deployment triggers.
- Using `pull_request_target`.
- Exposing secrets in logs, artifacts, caches, or pull request contexts.
- Weakening environment protection.
- Changing OIDC trust policy.
- Disabling tests.
- Pushing commits or tags.

## Review Focus

Check least-privilege `permissions`, event safety, secret exposure, cache key correctness, artifact retention, matrix coverage, concurrency cancellation, pinned actions where appropriate, Docker build provenance, OIDC audience/subject assumptions, and deployment gates.
