#!/usr/bin/env bash
# verify.sh — sanity check Claude's work before declaring a change "done".
#
# Runs cheap, fast checks that don't require the product to be running.
# Claude is instructed (in CLAUDE.md) to run this after every change and
# surface only the plain-language summary to the user.
#
# Engineering will extend this with platform-specific linters, accessibility
# checks, and end-to-end smoke tests over time. The v0.1 covers the discipline
# most likely to drift.
#
# FILL IN: edit the IN_SCOPE_REGEX and CLASS_PREFIX_REGEX below for your team.
#
# Usage:
#   playground/scripts/verify.sh
#
# Exit codes:
#   0  all good
#   1  one or more checks failed (with explanation)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$REPO_ROOT"

# ============================================================
# CONFIGURATION — fill in for your team
# ============================================================

# Anchored regex of paths that AI is allowed to edit.
# Add or remove paths as needed. Keep in sync with .claude/settings.json.
IN_SCOPE_REGEX='^(src/components/|src/styles/|src/content/|playground/|CLAUDE\.md)'

# Optional: regex matching a class / component prefix you DO want to enforce.
# Leave empty ("") to skip this check.
CLASS_PREFIX_REQUIRED=""        # e.g. "(^|[^a-zA-Z0-9_])myteam-" — flag missing prefix

# Optional: regex matching a class / component prefix you DON'T want introduced.
# Leave empty ("") to skip this check.
CLASS_PREFIX_BANNED=""          # e.g. "(^|[^a-zA-Z0-9_])legacy-" — flag if reintroduced

# Optional: path glob for files that should ONLY contain design tokens.
# If a raw hex / px / rem value appears outside this file in a CSS/SCSS diff, flag it.
# Leave empty to skip the raw-value check.
TOKEN_FILE_GLOB=""              # e.g. "src/styles/tokens.scss"

# ============================================================

failures=0
report=""

note() { report+="$1"$'\n'; }

# ----------------------------------------------------------------------
# Check 1: nothing edited outside the in-scope paths.
# ----------------------------------------------------------------------
out_of_scope=$(git diff --name-only HEAD 2>/dev/null | grep -vE "$IN_SCOPE_REGEX" || true)

if [[ -n "$out_of_scope" ]]; then
    note "✗ Edits found outside the allowed area:"
    while IFS= read -r f; do note "    $f"; done <<< "$out_of_scope"
    note "  Only edit files matching: $IN_SCOPE_REGEX"
    failures=$((failures + 1))
else
    note "✓ All changes inside the allowed area."
fi

# ----------------------------------------------------------------------
# Check 2: no banned class prefixes added.
# ----------------------------------------------------------------------
if [[ -n "$CLASS_PREFIX_BANNED" ]]; then
    added_banned=$(git diff HEAD 2>/dev/null \
        | grep -E '^[+]' \
        | grep -E "$CLASS_PREFIX_BANNED" \
        | grep -v '^[+][+][+]' || true)

    if [[ -n "$added_banned" ]]; then
        note "✗ Banned class / component prefix found in new code."
        note "    First offender: $(echo "$added_banned" | head -1)"
        failures=$((failures + 1))
    else
        note "✓ No banned prefixes introduced."
    fi
fi

# ----------------------------------------------------------------------
# Check 3: no raw design values added outside the token file.
# ----------------------------------------------------------------------
if [[ -n "$TOKEN_FILE_GLOB" ]]; then
    added_raw=$(git diff HEAD -- '*.scss' '*.css' 2>/dev/null \
        | grep -E '^[+]' \
        | grep -v '^[+][+][+]' \
        | grep -v "$TOKEN_FILE_GLOB" \
        | sed 's|//.*||' \
        | grep -E '#[0-9a-fA-F]{3,8}([^0-9a-fA-F]|$)' \
        | grep -vE '^[[:space:]]*#' || true)

    if [[ -n "$added_raw" ]]; then
        note "✗ Raw colour values added outside the token file."
        note "  Use design tokens from $TOKEN_FILE_GLOB. If the value you want"
        note "  doesn't exist, use the closest token and log the gap in"
        note "  playground/wishlist/design-system.md."
        note "    First offender: $(echo "$added_raw" | head -1 | sed 's/^[[:space:]]*//')"
        failures=$((failures + 1))
    else
        note "✓ No raw colours added."
    fi
fi

# ----------------------------------------------------------------------
# Check 4: prompt-log was updated on this branch (if there's been activity).
# ----------------------------------------------------------------------
changed_files=$(git diff --name-only HEAD 2>/dev/null | wc -l | tr -d ' ')

if [[ "$changed_files" -gt 0 ]]; then
    if git diff --name-only HEAD 2>/dev/null | grep -q 'playground/prompt-log.md'; then
        note "✓ Prompt log updated."
    else
        note "⚠ Prompt log (playground/prompt-log.md) wasn't updated this session."
        note "  Append the latest prompt + a one-line summary so reviewers have context."
    fi
fi

# ----------------------------------------------------------------------
# Output
# ----------------------------------------------------------------------
echo "$report"

if [[ $failures -eq 0 ]]; then
    echo "All checks passed."
    exit 0
else
    echo "$failures check(s) failed. Fix the issues above and try again."
    exit 1
fi
