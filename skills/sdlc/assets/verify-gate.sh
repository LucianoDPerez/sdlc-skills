#!/usr/bin/env bash
# verify-gate.sh — deterministic approval-gate check for the sdlc pipeline.
#
# Usage: verify-gate.sh [--root DIR] <artifact> [<artifact>...]
#
# A stage artifact passes its gate when:
#   1. it exists,
#   2. it names a human approver — a line "Approved by: <name> (<role>), <date>"
#      (a "# Approved by:" comment in YAML headers is accepted),
#   3. every upstream citation "<path> @ <sha>" resolves to an existing file
#      unchanged since the cited commit: `git diff <sha> -- <path>` is empty.
#
# Exit 0 = gate holds. Any FAIL line = gate broken; the artifact returns to review.

set -u

ROOT="."
case "${1:-}" in
  --root) ROOT="${2:?verify-gate.sh: --root needs a directory}"; shift 2 ;;
esac

if [ $# -lt 1 ]; then
  echo "usage: verify-gate.sh [--root DIR] <artifact> [<artifact>...]"
  exit 2
fi

fail=0
for artifact in "$@"; do
  path="${ROOT%/}/$artifact"

  # 1. existence
  if [ ! -f "$path" ]; then
    echo "FAIL $artifact: file not found"
    fail=1
    continue
  fi

  # 2. named human approver (template placeholders like "<name>" are rejected)
  if ! grep -Eq '^#? ?Approved by: [A-Za-z]' "$path"; then
    echo "FAIL $artifact: missing 'Approved by: <name> (<role>), <date>'"
    fail=1
  fi

  # 3. approval integrity of upstream citations
  citations=$(grep -oE '[A-Za-z0-9/._-]+ @ [0-9a-f]{7,40}' "$path" | sort -u)
  while IFS= read -r cit; do
    [ -n "$cit" ] || continue
    cpath=${cit%% @ *}
    csha=${cit##* @ }
    if [ ! -f "${ROOT%/}/$cpath" ]; then
      echo "FAIL $artifact: cited '$cpath' not found"
      fail=1
    elif ! git rev-parse --verify --quiet "${csha}^{commit}" >/dev/null 2>&1; then
      echo "FAIL $artifact: cited sha $csha is not a commit in this repo"
      fail=1
    elif [ -n "$(git diff "$csha" -- "${ROOT%/}/$cpath")" ]; then
      echo "FAIL $artifact: '$cpath' changed after approval (sha $csha) — approval void, back to review"
      fail=1
    fi
  done <<< "$citations"
done

[ "$fail" -eq 0 ] && echo "OK: gate verified: $*"
exit "$fail"
