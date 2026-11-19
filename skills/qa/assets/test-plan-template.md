# Test Plan: <feature-slug>

Status: draft | approved
PRD: `docs/prd/<feature-slug>.md @ <approval sha>`
RFC: `docs/rfc/NNNN-<slug>.md @ <approval sha>`
Threat model: `docs/security/<feature-slug>-threat-model.md @ <approval sha>`
Date: YYYY-MM-DD

## 1. Risk matrix

| Feature area | Impact | Likelihood | Score | Band | Depth |
|---|---|---|---|---|---|
| payments | 5 | 3 | 15 | CRITICAL | full automation + exploratory + load |

## 2. Coverage matrix (from PRD acceptance criteria)

| PRD criterion | Test | Level | Type (happy/failure/boundary) |
|---|---|---|---|
| US-1 happy path | checkout completes | E2E | happy |
| US-1 failure | card declined | integration | failure |
| US-2 … | **not covered — reason** | — | — |

No criterion without a row. "Not covered" is allowed; silence is not.

## 3. Level assignment

| Level | Count target | Framework | CI stage |
|---|---|---|---|
| unit | ~70% | | PR |
| integration | ~20% | | PR |
| E2E | ~10% | | merge + deploy |

## 4. Quality gates

| Gate | Checks | Threshold | Enforced |
|---|---|---|---|
| PR | unit+integration+coverage+lint+SAST+axe | coverage ↓ = fail | CI |
| merge | E2E smoke | 100% pass | CI |
| deploy | full E2E + perf + security | within budget | CI |
| nightly | E2E + visual + load + deps | reviewed AM | CI |

## 5. Test data & environments

- Data: factories/seeds per environment; no shared mutable fixtures.
- Environments: local / CI (ephemeral) / staging (prod-like, anonymized).

## 6. Threat-model blockers coverage

| Threat-model finding | Verifying test | Level |
|---|---|---|

## 7. Flaky policy

Classify before quarantine; product bugs → backlog; quarantine time-boxed with owner. Quarantine budget: <5% of suite.

## 8. Exploratory charters (if planned)

| Charter | Target | Duration |
|---|---|---|
