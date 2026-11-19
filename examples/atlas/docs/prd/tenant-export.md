# PRD: tenant-export

Status: approved
Date: 2026-11-18
Author: Maya Chen (CTO)
Discovery brief: `docs/discovery/tenant-export.md @ 1a14374`
Approved by: Maya Chen (CTO), 2026-11-18

## 1. Executive summary

We're building a tenant-scoped, async data export API for enterprise data engineers to satisfy data-portability clauses, which will move enterprise trial-to-paid conversion from 11% to 15% within 60 days.

## 2. Problem statement

- Enterprise deals stall in legal review on data lock-in (discovery §2: 3 lost deals, 5 of 6 active negotiations request the clause).
- Ad-hoc scrape scripts by 2 customers show the demand is real (tickets #4102, #4419).

## 3. Target users

- Primary: enterprise data engineer — API-first, no UI expected, reads OpenAPI directly.
- Secondary: compliance officer — reads the docs page, never calls the API.

## 4. Strategic context

- Ladders to the H1 enterprise-segment goal; the clause is now a hard gate in 5 of 6 active negotiations.
- Why now: legal confirmed clause language ("documented export capability") — assumption #1 validated 2026-11-17.

## 5. Solution overview

Async export jobs via the public API: request an export (CSV or JSON), receive a job id, poll for completion, download via a short-lived signed URL. Machine-facing end to end.

## 6. Success metrics

| Type | Metric | Baseline | Target | Measured |
|---|---|---|---|---|
| Primary | enterprise trial → paid conversion | 11% | 15% | 2027-01-15 |
| Input | negotiations passing legal without lock-in objection | 1/6 | 6/6 | deal records |
| Guardrail | API p95 latency (non-export endpoints) | 180ms | must not exceed 200ms | dashboard |

## 7. User stories & acceptance criteria

### Story 1: request an export
As a tenant data engineer, I want to request an export of my tenant's data via API, so I can comply with my data-portability clause.
- Scenario: happy — Given a tenant-scoped token, When I POST an export request, Then I receive 202 with a job id, And the job runs asynchronously without blocking other API traffic.
- Scenario: failure — Given the same job (same Idempotency-Key) is already running, When I POST again, Then I receive the SAME job id, not a duplicate job.

### Story 2: retrieve the result
As a tenant data engineer, I want to poll my export job and download the result, so I can ingest it on my side.
- Scenario: happy — Given my job completed, When I GET the job, Then I receive a signed URL valid for 15 minutes, single-use.
- Scenario: failure — Given the job failed (e.g., tenant data changed mid-read), When I GET the job, Then I receive status=failed with an RFC 7807 problem describing retryability.

## 8. Out of scope

| Excluded | Why |
|---|---|
| UI for exports | persona is API-first; a UI adds nothing procurement asks for |
| Recurring scheduled exports | no requested-by evidence; separate feature if asked |
| Formats beyond CSV/JSON | negotiation clauses name neither; keep it minimal |

## 9. Dependencies & risks

- Dependencies: object storage for artifacts (existing infra); `background_jobs` table (existing infra).
- Risks: expensive export saturating shared API capacity → async + rate limits + row cap (owner: Dev Patel); signed URL leakage → short TTL, single-use (owner: Dev Patel).

## 10. Open questions

- 🔵 Include soft-deleted records? — owner: Maya Chen — needed by RFC 2026-11-20.
