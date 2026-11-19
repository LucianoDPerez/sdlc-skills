---
name: api-design
description: "Trigger: API design, endpoints, OpenAPI, REST contract, webhooks. Produce a reviewable REST contract: resources, errors, pagination, auth, and idempotency."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load when the approved RFC adds or changes an external contract: REST endpoints, events, or webhooks. Do NOT load for internal-only refactors with no contract change.

## Hard Rules

- Model resources, not actions: plural nouns, no verbs in paths (`/orders`, not `/createOrder`).
- Every operation is defined in OpenAPI 3.1 (`assets/openapi-skeleton.yaml`) — code generates from the spec, never the reverse.
- Errors follow RFC 7807 problem+json with a stable `type` registry.
- Collections paginate; mutations on collections are forbidden (no bulk POST).
- Non-idempotent writes (payments, sends) accept an `Idempotency-Key` header.
- Auth + rate limits are specified per endpoint, not inherited implicitly.
- Every breaking change is flagged with its versioning decision per `references/rest-conventions.md`.

## Decision Gates

| Contract type | Output |
|---|---|
| CRUD resource | full OpenAPI path set |
| Long-running operation | async pattern: 202 + status resource + completion event/webhook |
| Cross-system events | event contract in the spec's `webhooks` section |
| Public/3rd-party | versioning decision REQUIRED before first release |

## Execution Steps

1. Extract operations from RFC + UX flows; list each actor × resource × action.
2. Model resources and sub-resources; keep nesting ≤2 levels.
3. Write the OpenAPI spec: schemas first, then paths, then errors.
4. Run `assets/api-review-checklist.md`; fix violations in the spec.
5. Cite the RFC; note the generated-client impact.

## Output Contract

Write `docs/api/<service>-openapi.yaml` (valid 3.1, lints clean) plus a summary in the RFC thread: resources, auth model, breaking changes list. A spec without error responses per operation and pagination per collection fails review.

## References

- `references/rest-conventions.md` — naming, pagination, filtering, versioning, auth, idempotency, webhooks, events.

## Assets

- `assets/openapi-skeleton.yaml` — spec skeleton with schemas/errors wired.
- `assets/api-review-checklist.md` — pre-review gate.
