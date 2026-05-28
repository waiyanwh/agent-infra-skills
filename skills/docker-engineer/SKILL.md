---
name: docker-engineer
description: Build, review, validate, and troubleshoot Dockerfiles, Docker Compose, container images, BuildKit/buildx, multi-stage builds, image size/security, registry workflows, local container runtime issues, and CI container build behavior. Use for Dockerfile edits, compose.yaml/docker-compose.yml, .dockerignore, image build failures, container networking/volumes/logging, and container hardening.
---

# Docker Engineer

Use this skill for Dockerfile development, Docker Compose review, image build debugging, container runtime troubleshooting, registry workflow review, and container security hardening.

## Shared Safety Rules

- Think before coding; state assumptions and ask when unclear.
- Prefer simple solutions and surgical changes.
- Do not refactor unrelated files.
- Define success criteria and validate changes.
- Prefer read-only inspection before writes.
- Use web search for current Docker behavior, base image changes, CVEs, deprecations, and registry/provider details when they may have changed.
- Never print secrets, registry tokens, private keys, kubeconfigs, cloud credentials, or sensitive environment variables.
- Never run destructive Docker commands without explicit approval.

## Workflow

1. Identify whether the task concerns build, runtime, Compose, registry, security, or CI behavior.
2. Inspect the relevant files first: `Dockerfile`, `.dockerignore`, `compose.yaml`, `docker-compose.yml`, entrypoint scripts, package manager files, and CI workflow files.
3. Check base images, build context, layer order, cache behavior, secret handling, ports, volumes, users, signals, health checks, and runtime environment.
4. Make the smallest Docker or Compose change that solves the observed problem.
5. Validate locally with the safest relevant command and report any validation that could not run.

## Validation Commands

Use the relevant subset:

```bash
docker build --progress=plain -t <image>:<tag> .
docker buildx build --load -t <image>:<tag> .
docker compose config
docker compose build
docker run --rm <image>:<tag>
docker inspect <container-or-image>
docker logs <container>
hadolint Dockerfile
trivy image <image>:<tag>
```

Use `hadolint`, `trivy`, `dive`, or similar tools only if available or requested.

## Warn And Require Approval Before

- `docker push` or `docker buildx build --push`.
- `docker compose up`, `docker compose down`, or container restarts against shared, remote, or production environments.
- `docker system prune`, `docker volume rm`, or other cleanup that can delete data.
- Removing, force-stopping, or replacing non-local containers.
- Writing registry credentials, secrets, or long-lived tokens to files.

## Review Focus

Check deterministic builds, small build contexts, multi-stage boundaries, cache reuse, package pinning, rootless/non-root runtime, secret leakage, `.dockerignore`, signal handling, entrypoints, health checks, image size, vulnerability exposure, platform compatibility, and Compose service dependencies.
