---
name: helm-chart-engineer
description: Develop, review, validate, and troubleshoot Helm charts, templates, values.yaml, Chart.yaml, _helpers.tpl, dependencies, rendered manifests, Kubernetes API compatibility, and releases.
---

# Helm Chart Engineer

Use this skill for Helm chart development, template fixes, values design, helper templates, dependencies, schema validation, rendered manifest review, Kubernetes API compatibility, and release troubleshooting.

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

## Workflow

1. Identify chart path, release context, values files, target Kubernetes versions, and whether a live cluster is involved.
2. Inspect `Chart.yaml`, `values.yaml`, `templates/`, `_helpers.tpl`, schemas, and dependencies before editing.
3. Make the smallest chart change that solves the requested behavior.
4. Render manifests locally and review the affected resources.
5. Validate against available tooling and call out any checks that could not run.

## Validation Commands

Use the relevant subset:

```bash
helm lint <chart>
helm template <release> <chart> -f <values>
helm dependency update <chart>
helm show values <chart>
kubeconform <rendered-manifests.yaml>
yamllint <path>
ct lint --charts <chart>
```

Use `kubeconform`, `yamllint`, and chart-testing only if available or requested.

## Warn And Require Approval Before

- `helm upgrade`, `helm install`, or `helm uninstall` against live clusters.
- CRD changes.
- Immutable field changes.
- PVC changes.
- Service selector changes.
- Resource deletion.
- Any production release action.

## Review Focus

Check template determinism, values defaults, schema compatibility, labels/selectors, hooks, CRDs, resource names, API versions, security contexts, probes, resources, and upgrade safety.
