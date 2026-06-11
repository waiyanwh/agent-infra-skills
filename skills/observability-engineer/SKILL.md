---
name: observability-engineer
description: Observability, monitoring, alerting, logs, metrics, traces, dashboards, SLOs, Datadog, CloudWatch, Prometheus, Grafana, OpenTelemetry, monitor tuning, incident evidence gathering, and noisy or missing alerts. Use for telemetry investigation, monitor/query review, dashboard changes, and signal quality debugging.
---

# Observability Engineer

Use this skill for logs, metrics, traces, dashboards, monitors, SLOs, telemetry pipelines, alert quality, and incident evidence gathering.

## Shared Safety Rules

- Prefer read-only queries and local config inspection before changing monitors or dashboards.
- Never print secrets, API keys, tokens, customer data, sensitive logs, or full trace payloads.
- Treat monitor mute, deletion, threshold changes, retention changes, sampling changes, and production instrumentation changes as impact-bearing.
- Use current vendor docs when query syntax, monitor behavior, agent versions, or telemetry APIs may have changed.

## Workflow

1. Identify symptom, service, environment, time window, deployment version, alert name, and expected signal.
2. Gather read-only evidence from dashboards, monitors, logs, traces, metrics, deployment events, and recent config changes.
3. Determine whether the issue is real service behavior, telemetry ingestion, query/filter logic, missing labels/tags, cardinality, sampling, or monitor thresholding.
4. Recommend the smallest safe query, monitor, dashboard, instrumentation, or runbook change.
5. Provide validation criteria and rollback for any alerting or instrumentation change.

## Read-Only Checks

Use the relevant subset:

```bash
rg -n "datadog|monitor|dashboard|metric|trace|otel|prometheus|grafana|cloudwatch" .
kubectl logs <pod> -n <namespace> --since=<duration>
kubectl get events -n <namespace> --sort-by=.lastTimestamp
aws cloudwatch describe-alarms
aws logs filter-log-events --log-group-name <log-group-name>
```

Use vendor MCP/API/CLI tools read-only when available, and redact sensitive values.

## Require Approval Before

- Muting, deleting, enabling, disabling, or changing production monitors.
- Changing alert thresholds, notification routes, escalation policies, SLO targets, sampling, retention, or ingestion filters.
- Deploying instrumentation changes to production.
- Exporting or sharing raw logs/traces containing sensitive data.

## Review Focus

Check tag consistency, service/env/version labels, query filters, aggregation windows, rollup behavior, no-data behavior, threshold direction, evaluation delay, alert grouping, notification routing, dashboard variables, trace sampling, log parsing, metric cardinality, agent health, and deployment correlation.
