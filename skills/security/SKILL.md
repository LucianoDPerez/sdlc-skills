---
name: security
description: "Trigger: threat model, STRIDE, security review, attack surface, OWASP. Model threats for a designed feature and map mitigations before implementation."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load after the RFC (and API spec, if any) is approved, before implementation — or when auditing an existing feature's security. Do NOT load for style-guide compliance or dependency bumps (those are CI jobs).

## Hard Rules

- Draw the trust boundaries and name what crosses each (`references/stride-reference.md`).
- Every element gets all six STRIDE categories answered — "N/A" needs a one-line why.
- Threats are rated (severity × likelihood) and ranked; mitigations map to threats by id.
- Unmitigated threats are listed as accepted risks with a named accepter, never dropped.
- Run the OWASP checklist (`references/owasp-checklist.md`) against the design; violations become blocking findings.
- Data classification drives handling rules: PII fields are listed by name, not hand-waved.

## Decision Gates

| Scope | Depth |
|---|---|
| Single feature in existing trust zone | element-level STRIDE + OWASP checklist |
| New service / boundary / auth path | full system STRIDE + entry/exit points inventory |
| Post-incident / audit | diff model + retro on what the model missed |

## Execution Steps

1. Enumerate elements and data flows from the RFC; mark trust boundaries.
2. Run STRIDE per element; list threats with id, severity, likelihood.
3. Map mitigations; for each: control type (prevent/detect/respond) and where it lives.
4. Run the OWASP checklist; merge violations into the findings list.
5. Classify data touched (PII/financial/internal) and state handling rules.
6. Fill `assets/threat-model-template.md`; cite the RFC.

## Output Contract

Write `docs/security/<feature-slug>-threat-model.md`: diagram with boundaries, STRIDE table, ranked findings (blocker / accepted risk), OWASP checklist results, and residual risks with named accepters. A model with zero threats named is a failed model.

## References

- `references/stride-reference.md` — element→STRIDE matrix, boundaries, risk rating.
- `references/owasp-checklist.md` — Top-10 controls against designs.

## Assets

- `assets/threat-model-template.md` — output skeleton.
