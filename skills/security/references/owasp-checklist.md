# OWASP Top 10 design checklist

Run against the DESIGN (RFC/API/ERD), not the code. Violations are findings in the threat model.

## A01 Broken access control

- [ ] Every operation names its authorization rule (role/scope/tenant check) — default deny.
- [ ] Object-level checks (IDOR): owning `id` ≠ authorized; cross-tenant reads return 404.
- [ ] Admin plane separated; admin actions audited.
- [ ] No client-trusted authorization (hidden fields, "is_admin" in JWT accepted without server check).

## A02 Cryptographic failures

- [ ] TLS everywhere external; internal service-to-service encrypted or explicitly justified.
- [ ] PII encrypted at rest; keys in a KMS, never in code/config.
- [ ] Passwords hashed (argon2/bcrypt); no reversible storage of credentials.
- [ ] No home-grown crypto.

## A03 Injection

- [ ] Parameterized queries only (ORM or prepared statements); dynamic SQL named and reviewed.
- [ ] Template/HTML rendering escapes by default; rich text sanitized server-side.
- [ ] OS command execution: no user input reaches a shell.

## A04 Insecure design

- [ ] Threat model exists (this skill) — its blockers resolved before merge.
- [ ] Rate limits and quota per identity on every public write.
- [ ] Business flows have abuse cases: enumeration, bulk scraping, self-dealing.

## A05 Security misconfiguration

- [ ] No default credentials; debug endpoints disabled in prod by design.
- [ ] CORS allowlist explicit; no `*` with credentials.
- [ ] Secrets from a vault/env, never committed.

## A06 Vulnerable components

- [ ] Lockfiles pinned; SAST/deps scanning in CI gates the merge.
- [ ] Known-CVE policy stated (e.g., no high ≥7 days unfixed).

## A07 Auth failures

- [ ] Session/token lifetimes stated; refresh rotation; revoke path exists.
- [ ] MFA available on privileged accounts; login throttling + lockout design.
- [ ] Password reset is an auth path: single-use, time-boxed tokens, no user enumeration.

## A08 Integrity failures

- [ ] Webhooks signed (HMAC + timestamp + replay window); CI pipeline has provenance attestation.
- [ ] Deserialization of untrusted data avoided or schema-validated.
- [ ] Auto-updates of code/config verified (signed).

## A09 Logging & monitoring failures

- [ ] Security events logged: auth failures, authz denials, admin actions, data exports.
- [ ] No PII/credentials in logs (stated per log point).
- [ ] Alert thresholds defined with owners; audit trail tamper-resistant (append-only).

## A10 SSRF

- [ ] Outbound fetches of user-supplied URLs: allowlist scheme/host, block link-local/metadata IPs, no redirect following, response size/time caps.
