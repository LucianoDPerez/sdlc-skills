---
name: release
description: "Trigger: release plan, deploy, go/no-go, runbook, rollback, ship to production, postmortem. Plan a gated rollout with tested rollback and an on-call runbook."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load when tests are green and production deployment is being planned — release, hotfix, or migration cutover. Also load for incident postmortems. Do NOT load for routine CI config (that's `qa` gates' enforcement).

## Hard Rules

- Rollback plan is written, tested, and reversible-per-step BEFORE rollout; destructive steps need named human sign-off.
- Go/no-go checklist gates the release; every unchecked box is a no-go or a written accepted risk with a name.
- Risky paths ship behind a feature flag; the flag's removal is scheduled at release time, not "later".
- Smoke suite in production + a bake window with named alert thresholds before calling it done.
- Runbook exists for anything on-call must operate (`assets/runbook-template.md`).
- Postmortems are blameless: timeline, contributing factors, action items with owners and dates.

## Decision Gates

| Release type | Strategy |
|---|---|
| Regular feature batch | rolling deploy + flags for risky paths |
| Risky/critical (payments, auth, migrations) | canary: 1% → 10% → 50% → 100%, metrics-checked per step |
| Breaking external contract | deprecation window per `api-design`; sunset dates announced |
| Infrastructure/migration | blue-green or expand-contract per `erd` |

## Execution Steps

1. Inventory the changes: features, migrations (rollback per `erd`), contract changes (deprecation per `api-design`).
2. Pick the strategy from the gates; write phase table with rollback per phase.
3. Define guardrail metrics and thresholds per step (error rate, latency p95, conversion).
4. Write the go/no-go checklist; collect owners for each unchecked item.
5. Write/refresh the runbook for new operational surfaces.
6. Fill `assets/release-plan-template.md`; link the test plan.

## Output Contract

Write `docs/releases/YYYY-MM-DD-<version>.md`: change inventory, phased rollout with per-phase rollback, guardrail metrics, go/no-go checklist (all boxes checked or risk-accepted with names), runbook link, comms plan. A release plan without a rehearsed rollback fails review.

## References

- `references/rollout-patterns.md` — canary/blue-green/flags, SLO guardrails, postmortem format.

## Assets

- `assets/release-plan-template.md` — release skeleton.
- `assets/runbook-template.md` — on-call runbook.
