---
name: devops-sre-infra-troubleshooter
description: Troubleshoot DevOps, SRE, infrastructure, Kubernetes runtime, Linux, networking, DNS, TLS, ingress, cloud symptoms, observability, incidents, and rollback planning with safe read-first workflows.
---

# DevOps SRE Infra Troubleshooter

Use this skill for incidents, runtime failures, Kubernetes debugging, Linux host issues, networking, DNS/TLS/ingress, cloud infrastructure symptoms, observability, and rollback planning.

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
- Never print secrets; redact tokens, kubeconfigs, private keys, passwords, sensitive environment variables, and account identifiers when appropriate.
- Never run destructive commands without explicit approval.

## Workflow

1. Define the symptom, scope, affected environment, blast radius, and success criteria.
2. Confirm whether the target is production or otherwise high-impact.
3. Gather read-only evidence first from local files, logs, Kubernetes MCP, cloud MCP, monitoring context, or safe shell commands.
4. Build a short hypothesis list and eliminate causes with targeted checks.
5. Recommend or implement the smallest safe fix that matches the evidence.
6. For production or deployment changes, include validation and rollback guidance.

## Safe Read-Only Command Examples

Use only when appropriate to the environment and with secrets redacted:

```bash
kubectl get pods -A
kubectl describe pod <pod> -n <namespace>
kubectl logs <pod> -n <namespace> --previous
kubectl get events -A --sort-by=.lastTimestamp
kubectl rollout status deployment/<name> -n <namespace>
kubectl rollout history deployment/<name> -n <namespace>
top
free -m
df -h
ss -tulpn
ip addr
ip route
dig <name>
curl -v <url>
journalctl -u <service>
```

## Warn And Require Approval Before

- `kubectl delete`.
- `kubectl apply`.
- Production restarts.
- Production scaling.
- `helm upgrade`, `helm install`, or `helm uninstall` against production.
- Cloud IAM, networking, or DNS changes.
- Secret rotation or changes to credentials.
- Any stateful, destructive, or irreversible operation.

## Output Style

Lead with findings, risk, and next action. For incidents, include current status, likely cause, evidence, mitigation, validation, rollback, and open questions.
