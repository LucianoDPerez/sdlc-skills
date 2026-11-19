---
name: ux-ui
description: "Trigger: UX, UI, wireframe, screens, views, user flow, design system, accessibility. Specify flows, screen states, and design tokens before implementation."
license: Apache-2.0
metadata:
  author: luchop
  version: "1.0"
---

## Activation Contract

Load after a PRD is approved, before or alongside the RFC, for any user-facing surface. Also load on any request to design screens, flows, views, wireframes, or component specs. Do NOT load for internal-only APIs or data work with no UI.

## Hard Rules

- Every screen MUST specify all states: empty, loading, error, success (`references/screen-states.md`).
- Every flow MUST map back to a PRD user story and cover its failure path.
- WCAG 2.2 AA is non-negotiable; run the checklist in `references/accessibility.md` before sign-off.
- Use design tokens, never one-off hex/pixel values; extend the existing system if one exists.
- Specify structure and behavior, not decoration — no pixel-level art direction in this artifact.
- Real copy beats lorem ipsum; label every placeholder as such.

## Decision Gates

| Situation | Fidelity |
|---|---|
| Exploring flow options | low-fi boxes + arrows |
| PRD approved, flow agreed | mid-fi wireframe with real copy |
| Handoff to implementation | high-fi: tokens, components, states |
| Interaction risk (drag, timing, gestures) | clickable prototype |

| Platform | Conventions source |
|---|---|
| Consumer web | `references/design-system.md` patterns |
| Admin/dashboard | tables + filters + forms patterns |
| Mobile | platform patterns (iOS/Android), thumb reach, 44px targets |
| React implementation | map inventory to shadcn via `references/framework-handoff.md` |
| Angular implementation | map inventory to Material/CDK via `references/framework-handoff.md` |

## Execution Steps

1. Extract user journeys and acceptance criteria from the PRD; list failure branches.
2. Draw flows (mermaid) covering happy path + every error/recovery branch.
3. Build the screen inventory; assign each screen its states and entry points.
4. Specify components and token deltas per screen against the design system.
5. Run the accessibility checklist; fix violations in the spec, not after build.
6. Write `assets/ux-spec-template.md` filled out.

## Output Contract

Write `docs/ux/<feature-slug>.md`: flows (with failure paths), screen inventory table, per-screen state specs, component/token deltas, accessibility pass results, and open questions. A screen without all four states fails review.

## References

- `references/screen-states.md` — state matrix, flow notation, fidelity levels.
- `references/design-system.md` — tokens, component inventory, platform patterns.
- `references/accessibility.md` — WCAG 2.2 AA checklist and test procedure.
- `references/framework-handoff.md` — React (shadcn) and Angular (Material/CDK) implementation lanes.

## Assets

- `assets/ux-spec-template.md` — output skeleton.
