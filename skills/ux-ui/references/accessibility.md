# Accessibility: WCAG 2.2 AA checklist

Two phases — never mix them. **Spec-time** items are verified against the UX spec document itself (states, tokens, copy) and their results belong in the spec's Accessibility pass section. **Implementation-time** items are verified against the running UI; they are NOT claimable at spec time — the ux skill hands them to `qa` as the accessibility test procedure. "Later" is a violation, not a deferral.

## Spec-time (verified on the document)

- [ ] Every image's alt text is specified (decorative → `alt=""` noted in the spec).
- [ ] No information conveyed by color alone: states specify icon/label/pattern alongside color.
- [ ] Target size ≥24×24px (2.2) declared in tokens — aim 44px on touch.
- [ ] Focus order specified per screen; no trap-by-design in any flow.
- [ ] Form fields: `<label>` association, error text via `aria-describedby`, and announcement strategy (`aria-live="polite"` or error summary `role="alert"`) written into the state specs.
- [ ] Validation copy states what happened and how to fix: "Enter a date in DD/MM/YYYY format", never "Invalid input".
- [ ] Page `<title>` unique per screen; landmarks (nav, main, header) specified.
- [ ] Icons-only buttons have accessible names (`aria-label`); link text describes destination.
- [ ] Heading hierarchy: one `h1` per screen, no skipped levels.
- [ ] Motion spec obeys `prefers-reduced-motion`; modals specify focus trap, focus return, and `Esc` close.
- [ ] Native elements first: real `<button>`, `<a>`, `<select>` in the component inventory; ARIA only when native can't (first rule of ARIA).

## Implementation-time (verified on the running UI — owned by `qa`)

- [ ] Text contrast ≥4.5:1 (≥3:1 for text ≥24px or ≥18.66px bold; UI components and focus indicators ≥3:1), measured on state variants — disabled text is the classic failure.
- [ ] Content reflows at 320px width and 400% zoom without horizontal scroll or overlap.
- [ ] Every action reachable by keyboard: tab order matches the spec, no keyboard traps in practice.
- [ ] Focus indicator visible and never fully obscured by sticky headers (2.2: focus-not-obscured).
- [ ] No drag-only interactions survive implementation; click/pointer alternatives work (2.2).
- [ ] No content flashing >3×/s; auto-playing/carousel content has a pause control.
- [ ] Screen-reader smoke pass (VoiceOver/NVDA): labels, errors, and dynamic updates announced.
- [ ] axe-core clean on every spec'd screen × states (empty/error variants often break contrast).

## Test procedure (qa runs this, in order)

1. axe-core (Playwright) on every spec'd screen × states.
2. Keyboard-only pass: complete each primary flow without the mouse.
3. Screen-reader smoke: one pass per flow.
4. Manual contrast spot-check on state variants.

Automated tools catch ~30% of issues — steps 2–4 are mandatory, not optional.
