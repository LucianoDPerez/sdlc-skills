# Test Plan: tenant-export

Status: approved
Date: 2026-11-23
PRD: `docs/prd/tenant-export.md @ c7cd90e`
RFC: `docs/rfc/0001-tenant-export.md @ 7ed2900`
Threat model: `docs/security/tenant-export-threat-model.md @ 467c508`
Approved by: Dev Patel (platform lead), 2026-11-23

## 1. Risk matrix

| Feature area | Impact | Likelihood | Score | Band | Depth |
|---|---|---|---|---|---|
| cross-tenant isolation | 5 | 2 | 10 | HIGH | full automation |
| export job pipeline | 4 | 3 | 12 | HIGH | automation + load |
| signed URL lifecycle | 3 | 3 | 9 | MEDIUM | automation |
| CSV serialization | 2 | 4 | 8 | MEDIUM | snapshot automation |

## 2. Coverage matrix (from PRD acceptance criteria)

| PRD criterion | Test | Level | Type |
|---|---|---|---|
| US-1 happy | POST → 202 + job runs async, non-export p95 unaffected | integration | happy |
| US-1 failure | same Idempotency-Key → SAME job id (no duplicate) | integration | boundary |
| US-2 happy | completed job → single-use signed URL, 15-min TTL | integration | happy |
| US-2 failure | failed job → status=failed + RFC 7807 problem with retryability | integration | failure |
| guardrail | API p95 ≤200ms with 5 large exports running | load | boundary |

## 3. Level assignment

| Level | Count target | Framework | CI stage |
|---|---|---|---|
| unit | ~70% (serializer, job policy) | pytest | PR |
| integration | ~20% (job pipeline, IDOR, URL lifecycle) | testcontainers-postgres + minio | PR |
| E2E | ~10% (full export journey on the largest fixture tenant) | Playwright-API | merge + deploy |

## 4. Quality gates

| Gate | Checks | Threshold | Enforced |
|---|---|---|---|
| PR | unit + integration + lint + SAST | coverage ↓ = fail | CI |
| merge | E2E export journey | 100% pass | CI |
| deploy | load (p95 with exports running) | ≤200ms | CI |
| nightly | retention job + storage lifecycle | reviewed AM | CI |

## 5. Test data & environments

- Factory tenants with seeded row counts (1k, 100k, 5M rows); ephemeral storage in CI; production fixture uses anonymized data only.

## 6. Threat-model blockers coverage

| Threat-model finding | Verifying test | Level |
|---|---|---|
| F1 CSV injection | serializer pins dangerous-cell prefixing on =,+,-,@,tab | unit |
| T1 IDOR | tenant A GETs tenant B's job → 404 (no oracle) | integration |
| T2 URL replay | second use of signed URL → 403; expiry honored | integration |
| T3 capacity | p95 guardrail under 5 concurrent exports | load |

## 7. Flaky policy

Classify before quarantine; storage lifecycle flakes → time-boxed quarantine, budget <5%, owner Dev Patel.

## 8. Exploratory charters

| Charter | Target | Duration |
|---|---|---|
| export while tenant data mutates mid-stream | consistency of artifact | 90 min |
