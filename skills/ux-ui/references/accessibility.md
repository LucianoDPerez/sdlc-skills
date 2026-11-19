# Accessibility: WCAG 2.2 AA checklist

Run every item before sign-off. "Later" is a violation, not a deferral.

## Perceivable

- [ ] Text contrast ≥4.5:1 (≥3:1 for text ≥24px or ≥18.66px bold); UI components and focus indicators ≥3:1.
- [ ] Non-decorative images have alt text; decorative images use `alt=""`.
- [ ] No information conveyed by color alone (add icon/label/pattern).
- [ ] Content reflows at 320px width and 400% zoom without horizontal scroll or overlap.

## Operable

- [ ] Every action reachable by keyboard: tab order matches visual/logical order, no keyboard traps.
- [ ] Focus indicator visible on every interactive element and never fully obscured by sticky headers (2.2: focus-not-obscured).
- [ ] Target size ≥24×24px (2.2) — aim 44px on touch.
- [ ] No drag-only interactions; provide click/pointer alternatives (2.2).
- [ ] Motion obeys `prefers-reduced-motion`; no content flashing >3×/s; auto-playing/carousel content has pause control.
- [ ] Modals trap focus while open, return focus to the trigger on close, close on `Esc`.

## Understandable

- [ ] Page `<title>` unique per screen; landmarks (nav, main, header) present.
- [ ] Form fields: programmatic `<label>` association, error text linked via `aria-describedby`, errors announced (`aria-live="polite"` or error summary with `role="alert"`).
- [ ] Validation errors state what happened and how to fix: "Enter a date in DD/MM/YYYY format", never "Invalid input".
- [ ] Icons-only buttons have accessible names (`aria-label`); link text describes destination.

## Robust

- [ ] Native elements first: real `<button>`, `<a>`, `<select>`; ARIA only when native can't do it (first rule of ARIA).
- [ ] Custom widgets (combobox, tabs, tree) follow the matching ARIA pattern including keyboard behavior.
- [ ] Heading hierarchy: one `h1` per screen, no skipped levels.
- [ ] Dynamic updates (toasts, inline results) use live regions; route changes move focus to the new view's heading.

## Test procedure (order matters)

1. Automated: axe-core (Playwright) on every spec'd screen × states (empty/error variants often break contrast).
2. Keyboard-only pass: complete the screen's primary flow without touching the mouse.
3. Screen-reader smoke: one pass (VoiceOver/NVDA) per flow; labels, errors, and updates announced.
4. Manual contrast spot-check on state variants (disabled text is the classic failure).

Automated tools catch ~30% of issues — steps 2–4 are mandatory, not optional.
