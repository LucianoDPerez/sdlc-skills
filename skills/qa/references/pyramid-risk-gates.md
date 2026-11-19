# Pyramid, risk, gates, stacks

## Risk matrix (drives everything)

Impact (1–5: money, users, data) × Likelihood (1–5: change frequency, complexity, past incidents). Score bands:

| Band | Depth | Automation |
|---|---|---|
| CRITICAL 15–25 | full automation + exploratory + load | every commit + monitoring |
| HIGH 10–14 | full automation + periodic exploratory | every PR |
| MEDIUM 5–9 | happy path + key errors automated | recommended |
| LOW 1–4 | manual or skip | optional |

Payments, auth, and data export are CRITICAL by default. A feature with no score isn't untested — it's unscored, which blocks the plan.

## Pyramid shapes

| Shape | Symptom | Fix |
|---|---|---|
| Healthy (70/20/10) | fast CI, stable suite | maintain |
| Ice cream cone (E2E-heavy) | 45+ min CI, breaks on every UI change | freeze E2E growth; decompose to unit/integration |
| Hourglass (no integration middle) | unit-green, broken seams | invest in service-boundary tests + contract tests |

Targets: unit 70–80%, integration 15–20%, E2E 5–10%. CI PR signal <15 min. Flakiness <2%.

## Quality gates (all enforced in CI)

- **PR**: unit+integration pass; coverage does not decrease; lint/typecheck clean; SAST/dep scan no new high; axe-core a11y (frontend); ≥1 review.
- **Merge**: E2E smoke vs preview deploy.
- **Deploy**: full E2E on staging; performance within budget; security scan clean; rollback verified.
- **Nightly**: full E2E, visual regression, load (CRITICAL paths), dep vulnerabilities. Reviewed each morning.

## Frameworks per stack

| Level | React | Angular |
|---|---|---|
| Unit | Vitest/Jest + Testing Library | Jest/Web Test Runner + TestBed |
| Integration | Testing Library + MSW | TestBed + MSW (HTTP mocking) |
| API contract | Playwright APIRequestContext / Schemathesis | same — spec-first, stack-agnostic |
| E2E | Playwright | Playwright (same suite as React lane via role/test-id contract) |
| A11y | axe-core (Playwright) | axe-core + CDK a11y assertions |
| Visual regression | Playwright screenshots | Playwright screenshots |
| Load | k6 (HTTP — stack-agnostic) | k6 |

## Flaky policy

1. Reproduce; classify: timing (add waits at the right abstraction), test bug, or PRODUCT bug.
2. Product bugs go back to the backlog with the failing assertion attached — quarantine is the last resort, time-boxed, with an owner and ticket.
3. Quarantine count is a tracked metric; >5% quarantined = the suite is lying to you.

## Anti-patterns

- Coverage theater: 100% line coverage, zero assertion quality — coverage is a floor, not the goal.
- Testing the implementation (mocks everywhere) instead of behavior.
- One giant E2E "god test" per feature — split by flow, assert at the lowest level that can fail.
- Suites that pass with the feature broken — every test must fail when its criterion is broken at least once (prove it).
