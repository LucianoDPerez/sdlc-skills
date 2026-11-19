# Release Plan: <version>

Status: draft | go | no-go
Date: YYYY-MM-DD
Test plan: link
Threat model: link

## 1. Change inventory

| Type | Change | Rollback available | Reference |
|---|---|---|---|
| feature | | flag off | PRD link |
| migration | | expand/contract step | ERD link |
| contract | | deprecation window | OpenAPI link |

## 2. Rollout strategy

Strategy: rolling | canary | blue-green | flags

| Phase | Scope | Hold criteria (guardrail green) | Rollback action |
|---|---|---|---|
| 1 | 1% / staging | error rate, p95, KPI within threshold | revert traffic / flag off |
| 2 | 10% | | |
| … | 100% | | |

Flag removal ticket: <id>, scheduled <date>.

## 3. Guardrail metrics

| Metric | Baseline | Threshold | Bake window |
|---|---|---|---|
| 5xx rate | | +X% max | 30 min per step |
| p95 latency | | | |
| <PRD primary metric> | | | |

## 4. Go/no-go checklist

- [ ] All quality gates green (test plan §4)
- [ ] Rollback rehearsed in staging
- [ ] Migration backups/snapshot taken (dated)
- [ ] Destructive steps signed off by: <name>
- [ ] Flags configured + default-off where risky
- [ ] Runbook current and linked
- [ ] Comms: who is told, when (channel)
- [ ] On-call aware of the change window

Unchecked = no-go, or accepted risk: | Risk | Accepted by | Date |

## 5. Post-deploy verification

- [ ] Smoke suite green in production
- [ ] Guardrails held for bake window
- [ ] Primary PRD metric trending to target

## 6. Runbook

Link: `docs/runbooks/<service>.md` (or embedded if short)

## 7. Rollback trigger criteria

State them numerically ("5xx >2× baseline for 5 min → roll back"), so the 3 AM decision is a rule, not a judgment call.
