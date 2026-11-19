# Rollout patterns, guardrails, postmortems

## Strategies

| Pattern | How | When | Rollback |
|---|---|---|---|
| Rolling | replace instances gradually | default for stateless services | redeploy previous tag |
| Canary | 1% → 10% → 50% → 100%; metrics gate each step | risky changes; new critical paths | revert traffic to 100% stable (minutes) |
| Blue-green | two full environments, flip the router | infra/big-bang cutovers | flip back |
| Feature flags | dark deploy, enable per cohort | everything user-visible; default for risky paths | flag off (seconds) |

Canary step criteria: hold each step long enough to see the slowest guardrail metric (bake ≥ error-budget latency of your alerts); no auto-proceed on red.

## Guardrail metrics (per release, thresholds stated in the plan)

- Error rate (5xx + domain errors) vs baseline
- Latency p95/p99 vs baseline
- Saturation: CPU/mem/queue depth
- Business KPI: conversion/activation/checkout completion — the metric the PRD promised
- Alert: any guardrail outside threshold during bake → automatic no-go / rollback decision point

## SLO touchpoints

If the service has SLOs: state the release's expected error-budget consumption; a release projected to burn >30% of the monthly budget needs a named approver.

## Runbook essentials

Everything an on-call at 3 AM needs — nothing more: health checks, common alerts with first actions, escalation path, operational procedures (rotate key, force-flag-off, replay stuck queue), and "when in doubt, roll back".

## Postmortem format (blameless, within 5 business days)

1. **Summary** — impact in user/business terms; duration; severity.
2. **Timeline** — UTC, from first detection to resolution; include detection lag.
3. **Contributing factors** — system conditions, not people ("the alert routed to an unused channel", not "X ignored it").
4. **What went well / What went poorly** — detection, mitigation, comms.
5. **Action items** — each with owner + date; at least one that removes this incident CLASS, not just this instance.
6. Link the ADR if the fix changes an architectural decision.

## Anti-patterns

- Friday deploys without canary + instant rollback — schedule risk, not courage.
- Rollback "plans" that were never rehearsed — a rollback tested only in theory is a hope.
- Flags that live forever — removal ticket created at release time, age tracked as tech debt.
- Postmortems that name people — you get hidden incidents next time; blameless is not politeness, it's signal integrity.
