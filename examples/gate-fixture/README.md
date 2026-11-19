# Gate fixture: a citation that MUST fail

`docs/downstream.md` cites `docs/upstream.md @ <sha>` where the sha predates the file's existence — the approval cannot cover the current text. `verify-gate.sh` must reject it; CI asserts the failure on every push:

```bash
bash skills/sdlc/assets/verify-gate.sh --root examples/gate-fixture docs/downstream.md
# expected: FAIL docs/downstream.md: 'docs/upstream.md' changed after approval (sha ...) — approval void, back to review
```
