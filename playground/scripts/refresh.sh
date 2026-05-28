#!/usr/bin/env bash
# refresh.sh — make Claude's edits visible in the local preview.
#
# What "refresh" means is platform-specific. FILL IN below for your team:
#
#   - Hot-reload frameworks (Next.js, Vite, Webpack dev server): probably nothing
#     needed; the dev server picks up file changes automatically.
#   - Server-rendered apps with caches (Moodle, Drupal, Rails with caching):
#     run a cache-purge command.
#   - Compiled assets (SCSS that compiles separately, esbuild): run a build.
#   - Container-based dev: docker exec into the container to do the above.
#
# Used as a manual command (run after edits to templates / lang / layout files).
# Engineering may wire this into Claude Code as a PostToolUse hook later.

set -euo pipefail

# ============================================================
# CONFIGURATION — fill in for your team's platform
# ============================================================

# Examples (uncomment + adapt one):

# --- Moodle / IOMAD via docker exec ---
# CONTAINER="$(docker ps --format '{{.Names}}' 2>/dev/null | grep -iE '(moodle|iomad)' | head -1 || true)"
# if [[ -z "$CONTAINER" ]]; then
#     echo "Couldn't find a running container. Run 'docker ps' to see what's up."
#     exit 1
# fi
# docker exec "$CONTAINER" php /var/www/html/admin/cli/purge_caches.php

# --- Vite / Next.js (no action — dev server hot-reloads) ---
# echo "Hot reload is automatic. Just refresh your browser."

# --- Rails dev with caching ---
# rails dev:cache 2>/dev/null || true

# --- Drupal via drush ---
# docker exec <container> drush cache:rebuild

# --- Stub: replace this with your platform's refresh command ---
echo "playground/scripts/refresh.sh is not yet configured for your platform."
echo "Edit it to add the command your platform needs to make changes visible."
echo "Examples are in the script comments."
exit 0
