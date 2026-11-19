# API review checklist (pre-review gate)

Run before requesting review; fix in the spec, not in code review.

## Resources

- [ ] Plural nouns; no verbs in paths (controller sub-resources documented as exceptions)
- [ ] Nesting ≤2 levels
- [ ] No bulk mutations on collections; bulk ops have their own resource
- [ ] GET has zero side effects

## Contract

- [ ] OpenAPI 3.1 lints clean; `operationId` unique everywhere
- [ ] Every operation has at least success + one error response defined
- [ ] Schemas defined before paths; required fields explicit; enums closed
- [ ] All collections paginate (cursor, limit ≤100); `next_cursor` in response
- [ ] Timestamps ISO 8601 UTC; casing convention stated and consistent

## Errors

- [ ] RFC 7807 problem+json; stable `type` URLs registered
- [ ] 422 with field-level `errors` for validation
- [ ] Cross-tenant access returns 404, never 403
- [ ] 429 carries `Retry-After`

## Safety

- [ ] Payment/send-class POSTs take `Idempotency-Key` (required in spec)
- [ ] Auth scheme + scopes per operation; tenancy check stated
- [ ] Webhooks: HMAC signature + timestamp + documented retry/DLQ policy
- [ ] Consumers get dedup guidance (at-least-once stated)

## Lifecycle

- [ ] Breaking changes listed with versioning decision (deprecation window ≥90d or new version) — ADR linked if public
- [ ] Additive-only changes marked as such
- [ ] RFC cited; every RFC operation covered or explicitly deferred
