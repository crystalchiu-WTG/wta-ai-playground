#!/usr/bin/env bash
# audit.sh — surface drift in tokens / conventions across the codebase.
#
# Where verify.sh checks the current diff, audit.sh scans the whole tree
# to find pre-existing drift — places where the team has accumulated
# raw values, banned prefixes, or convention violations.
#
# Useful as a regular health-check or before a cleanup sprint.
#
# FILL IN: edit the configuration block below for your team.
#
# Usage:
#   playground/scripts/audit.sh           # full report
#   playground/scripts/audit.sh --count   # just the offender count
#   playground/scripts/audit.sh --strict  # exit 1 if offenders found (for CI)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# ============================================================
# CONFIGURATION — fill in for your team
# ============================================================

# Directory to scan (typically your design / theme / style root).
SCAN_DIR="$REPO_ROOT/src/styles"

# File glob to scan (e.g. all SCSS/CSS).
SCAN_GLOB="*.scss"

# Files to exclude from the scan (e.g. the canonical token file itself).
# Use paths or patterns separated by spaces inside the find -path exclusions.
EXCLUDE_PATHS=("*/tokens.scss" "*/vendor/*")

# What pattern counts as a violation. Default: raw hex colour values.
VIOLATION_REGEX='#[0-9a-fA-F]{3,8}([^0-9a-fA-F]|$)'

# Human label for what's being scanned.
VIOLATION_LABEL="raw hex colour"

# ============================================================

MODE="report"
case "${1:-}" in
    --count)  MODE="count" ;;
    --strict) MODE="strict" ;;
    --help|-h) sed -n '2,18p' "$0"; exit 0 ;;
esac

# Build the find exclusion clauses.
FIND_ARGS=("$SCAN_DIR" -type f -name "$SCAN_GLOB")
for excl in "${EXCLUDE_PATHS[@]}"; do
    FIND_ARGS+=(! -path "$excl")
done

TARGETS=()
while IFS= read -r line; do
    TARGETS+=("$line")
done < <(find "${FIND_ARGS[@]}" 2>/dev/null | sort)

total=0
offenders_by_file=()

for f in "${TARGETS[@]}"; do
    rel="${f#$REPO_ROOT/}"
    matches="$(sed 's|//.*||' "$f" 2>/dev/null \
        | grep -nE "$VIOLATION_REGEX" \
        | grep -vE '^[[:space:]]*#' \
        || true)"
    if [[ -n "$matches" ]]; then
        count=$(echo "$matches" | wc -l | tr -d ' ')
        total=$((total + count))
        offenders_by_file+=("$rel"$'\t'"$count"$'\t'"$matches")
    fi
done

case "$MODE" in
    count) echo "$total" ;;
    report|strict)
        if [[ $total -eq 0 ]]; then
            echo "✓ No ${VIOLATION_LABEL} found in $SCAN_DIR."
            exit 0
        fi
        echo "${VIOLATION_LABEL^} occurrences in $SCAN_DIR:"
        echo "─────────────────────────────────────────────────────"
        for entry in "${offenders_by_file[@]}"; do
            file="${entry%%$'\t'*}"
            rest="${entry#*$'\t'}"
            count="${rest%%$'\t'*}"
            lines="${rest#*$'\t'}"
            echo
            echo "  $file ($count)"
            while IFS= read -r line; do
                lineno="${line%%:*}"
                content="${line#*:}"
                content="$(echo "$content" | sed -E 's/^[[:space:]]+//')"
                printf "    %5s  %s\n" "L$lineno" "$content"
            done <<< "$lines"
        done
        echo
        echo "─────────────────────────────────────────────────────"
        echo "$total ${VIOLATION_LABEL}(s). Replace with tokens from your design-system file."
        [[ "$MODE" == "strict" ]] && exit 1 || exit 0
        ;;
esac
