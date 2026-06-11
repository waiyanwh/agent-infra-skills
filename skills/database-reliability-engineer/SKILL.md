---
name: database-reliability-engineer
description: Database reliability and operations for PostgreSQL, MySQL, RDS/Aurora, MongoDB, Redis, backups, migrations, connection pressure, locks, replication lag, slow queries, schema-change safety, restore planning, and data-impacting incident triage. Use for database runtime issues, safe migration review, backup/restore checks, and DB connectivity debugging.
---

# Database Reliability Engineer

Use this skill for database incidents, schema-change safety, migrations, backups/restores, replication, locks, connection pressure, slow queries, and data-impacting operational risk.

## Shared Safety Rules

- Prefer read-only inspection before database or infrastructure changes.
- Never print credentials, connection strings, customer data, dumps, query results with sensitive data, or backup contents.
- Ask before writes, schema changes, failovers, restarts, restores, imports, exports, deletes, vacuum/reindex on production, parameter changes, or connection-killing commands.
- Use current vendor docs when behavior depends on database engine, cloud provider, version, extension, or migration tool.

## Workflow

1. Identify database engine, version, environment, cluster/instance, database/schema, workload, symptom, time window, and production impact.
2. Inspect local IaC, migration files, application config references, and runbooks first.
3. Gather read-only evidence: health/status, events, metrics, logs, locks, connections, replication, slow queries, and recent deployments.
4. Separate app/query behavior from DB capacity, network/IAM/security group, parameter, storage, backup, replication, and migration problems.
5. Recommend the smallest safe fix with validation, rollback, and data-safety notes.

## Read-Only Checks

Use the relevant subset:

```bash
rg -n "migration|schema|postgres|mysql|aurora|rds|mongodb|redis|database|db_" .
aws rds describe-db-instances
aws rds describe-db-clusters
aws rds describe-events
aws cloudwatch describe-alarms
```

SQL examples must be read-only unless approval is explicit:

```sql
select now();
select version();
select * from pg_stat_activity;
select * from pg_locks;
show max_connections;
```

Redact names and values when needed.

## Require Approval Before

- DDL/DML writes, migrations, rollbacks, imports, exports, restores, failovers, restarts, or parameter changes.
- Killing sessions, changing connection pools, changing backup retention, enabling/disabling replication, or modifying indexes in production.
- Running queries that may be expensive on production without confirming impact.

## Review Focus

Check migration reversibility, lock behavior, transaction scope, index build mode, table size, query plans, connection limits, pool settings, storage headroom, replication lag, backup/restore readiness, maintenance windows, encryption/KMS access, network/security groups, least privilege, and rollback strategy.
