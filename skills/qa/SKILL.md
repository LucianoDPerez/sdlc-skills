---
name: qa
description: "Trigger: test strategy, test plan, QA, coverage, quality gates, test the PRD. Produce a risk-ranked test plan where every acceptance criterion maps to a test."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load after the threat model, before implementation — or when planning a release's verification. Also load to review an existing test suite's health. Do NOT load for writing a single test (that's implementation work).

## Hard Rules

- Risk matrix before test list: features scored Impact × Likelihood drive testing depth (`references/pyramid-risk-gates.md`).
- Coverage matrix is mandatory: every PRD acceptance criterion → a test, or an explicit "not covered + why".
- Pyramid targets stated (unit:integration:E2E ≈ 70:20:10); an inverted suite is reported as a finding.
- Every quality gate names a pass/fail threshold enforced in CI; a gate that can be clicked past is documentation.
- Flaky policy: classify root cause before quarantine; quarantining a real bug is how it escapes.
- Test data and environments are stated, not assumed.

## Decision Gates

| Need | Output |
|---|---|
| New feature, pre-implementation | test plan from template + coverage matrix |
| Release verification | release gate checklist (feeds `release`) |
| Suite health audit | pyramid shape diagnosis + flake report |
| Exploratory pass before ship | charters (SBTM), 60–90 min sessions |

## Execution Steps

1. Extract acceptance criteria and threat-model blockers as the test basis.
2. Score features in the risk matrix; set depth per band.
3. Build the coverage matrix; every gap is "not covered + reason", never silent.
4. Assign tests to pyramid levels; pick frameworks per the stack table in the references.
5. Define gates (PR / merge / deploy / nightly) with thresholds.
6. Fill `assets/test-plan-template.md`; link RFC + threat model.

## Output Contract

Write `docs/qa/<feature-slug>-test-plan.md`: risk matrix, coverage matrix (no uncovered-silent rows), level assignments with frameworks, gates with thresholds, flaky and test-data policies. A plan whose coverage matrix can't be diffed against the PRD fails review.

## References

- `references/pyramid-risk-gates.md` — risk bands, pyramid shapes, gates, frameworks per stack.

## Assets

- `assets/test-plan-template.md` — output skeleton.
