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
- Helm chart paths: `<paths or none>`
- GitHub Actions notes: `<workflow paths, reusable workflows, runner notes>`

## Production Safety Notes

- Production environments: `<names or none>`
- Approval requirements: `<who or what must approve production-impacting changes>`
- Rollback notes: `<rollback command or runbook link>`
- Sensitive areas: `<state, IAM, networking, DNS, secrets, data stores, etc.>`

Do not commit secrets, kubeconfigs, private keys, tokens, account IDs, or long-lived credentials.
