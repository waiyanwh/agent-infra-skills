---
name: argocd-gitops-engineer
description: Argo CD and GitOps operations, application manifests, sync health, app-of-apps, ApplicationSets, Kustomize/Helm source wiring, Argo Rollouts integration, targetRevision/tag flow, repo credentials, and safe deployment troubleshooting. Use for Argo CD apps, sync failures, generated values, rollout promotion/abort analysis, and GitOps repo navigation.
---

# Argo CD GitOps Engineer

Use this skill for Argo CD, GitOps repository structure, app-of-apps, ApplicationSets, sync health, generated app values, Argo Rollouts integration, and deployment state driven by Git.

## Shared Safety Rules

- Prefer read-only inspection before repo, cluster, or Argo CD changes.
- Never print repo credentials, tokens, kubeconfigs, private keys, SOPS content, or decrypted secrets.
- Do not run sync, terminate operation, rollback, promote, abort, delete, or mutate live Argo CD/Kubernetes state without explicit approval.
- Keep changes scoped to the affected app, environment, source path, or workflow.
- Use current docs or upstream references when behavior may depend on Argo CD, Rollouts, Helm, or Kubernetes versions.

## Workflow

1. Identify application, environment, cluster, namespace, source repo/path/chart, target revision, and production impact.
2. Inspect Git first: `Application`, `ApplicationSet`, app values, Kustomize overlays, Helm chart references, and generated tag/branch flow.
3. If live state is relevant, gather read-only evidence from Argo CD CLI/API, Kubernetes, Rollouts, or available MCP tools.
4. Separate source-of-truth problems from rendered-manifest problems, live-cluster drift, controller errors, and rollout-analysis failures.
5. Recommend the smallest repo or operational fix, with validation and rollback steps.

## Read-Only Commands

Use the relevant subset:

```bash
argocd app get <app>
argocd app history <app>
argocd app manifests <app>
argocd app diff <app>
kubectl get applications.argoproj.io -A
kubectl describe application <app> -n <argocd-namespace>
kubectl get applicationsets.argoproj.io -A
kubectl get rollout <name> -n <namespace>
kubectl argo rollouts get rollout <name> -n <namespace>
```

Confirm context, namespace, and environment before any live command.

## Local Validation

Use the relevant subset:

```bash
kustomize build <overlay>
kubectl kustomize <overlay>
helm template <release> <chart> -f <values.yaml>
helm lint <chart>
yamllint <path>
git diff --check
```

## Require Approval Before

- `argocd app sync`, `app rollback`, `app terminate-op`, or `app delete`.
- Rollout promote, abort, restart, retry, or undo actions.
- Production target revision, image tag, chart version, or values changes.
- Repo credential, project, RBAC, cluster secret, SOPS, or Argo CD controller config changes.

## Review Focus

Check repo URL/path/chart, target revision, value file ordering, generated tags, app project permissions, sync waves/hooks, prune/self-heal behavior, namespace creation, ignore differences, Helm/Kustomize render output, Rollouts annotations, analysis templates, notification config, and branch/tag rollout dependencies.
