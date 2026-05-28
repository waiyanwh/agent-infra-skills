---
name: kubernetes-engineer
description: Develop, review, validate, and troubleshoot Kubernetes manifests, Kustomize overlays, kubectl workflows, workloads, Services, Ingress, Gateway API, RBAC, ConfigMaps/Secrets references, probes, resources, scheduling, storage, rollout safety, and live cluster debugging. Use for Kubernetes YAML, kubectl errors, pod/deployment/service issues, namespace/RBAC problems, and cluster-runtime evidence gathering.
---

# Kubernetes Engineer

Use this skill for Kubernetes manifest work, Kustomize overlays, kubectl troubleshooting, workload debugging, service/ingress connectivity, RBAC, scheduling, storage, rollout safety, and cluster-runtime evidence gathering.

## Shared Safety Rules

- Think before coding; state assumptions and ask when unclear.
- Prefer simple solutions and surgical changes.
- Do not refactor unrelated files.
- Define success criteria and validate changes.
- Prefer read-only inspection before writes.
- Use MCP tools when available and relevant; never assume cluster MCP access exists.
- Use web search for current Kubernetes behavior, API removals, version compatibility, controller behavior, CVEs, and provider-specific details when they may have changed.
- Never print secrets, kubeconfigs, tokens, private keys, cloud credentials, or sensitive environment variables.
- Never run production-impacting Kubernetes changes without explicit approval.

## Workflow

1. Identify cluster, context, namespace, environment, Kubernetes version, ownership path, and production impact.
2. Inspect local manifests first: raw YAML, `kustomization.yaml`, overlays, generated manifests, policies, RBAC, and deployment tooling.
3. If a live cluster is involved, gather read-only evidence before recommending changes.
4. Determine whether another skill owns the primary surface: Helm charts -> `helm-chart-engineer`; AWS/EKS infrastructure -> `aws-cloud-engineer`; Terraform-managed Kubernetes resources -> `terraform-terragrunt-engineer`.
5. Make the smallest manifest or operational recommendation that matches the evidence.
6. Validate with dry-run, render, schema, and rollout checks where practical.

## Read-Only Cluster Commands

Use the relevant subset, with sensitive names redacted when needed:

```bash
kubectl config current-context
kubectl get pods -n <namespace>
kubectl describe pod <pod> -n <namespace>
kubectl logs <pod> -n <namespace> --previous
kubectl get events -n <namespace> --sort-by=.lastTimestamp
kubectl get deploy,sts,ds,svc,ingress -n <namespace>
kubectl rollout status deployment/<name> -n <namespace>
kubectl rollout history deployment/<name> -n <namespace>
kubectl auth can-i <verb> <resource> -n <namespace>
kubectl top pods -n <namespace>
```

## Local Validation Commands

Use the relevant subset:

```bash
kubectl apply --dry-run=client -f <manifest>
kubectl apply --dry-run=server -f <manifest>
kubectl diff -f <manifest>
kubectl kustomize <overlay>
kustomize build <overlay>
kubeconform <rendered-manifests.yaml>
yamllint <path>
```

Use server-side dry-run and `kubectl diff` only when the target cluster/context is confirmed.

## Warn And Require Approval Before

- `kubectl apply`, `delete`, `patch`, `edit`, `replace`, `annotate`, or `label` against a live cluster.
- `kubectl rollout restart`, `rollout undo`, or `scale`.
- `kubectl drain`, `cordon`, `uncordon`, or node taints.
- Secret, ConfigMap, RBAC, admission policy, CRD, PVC, StorageClass, or Namespace changes.
- Any production release, restart, scaling, deletion, or state change.

## Review Focus

Check API versions, selectors, labels, namespaces, immutable fields, rollout strategy, probes, resources, security context, service account/RBAC, ConfigMap/Secret references, image pull behavior, scheduling constraints, topology spread, PDBs, HPA/VPA behavior, storage semantics, ingress/gateway routing, network policies, and upgrade safety.
