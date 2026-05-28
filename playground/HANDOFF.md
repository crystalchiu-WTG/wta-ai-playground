# Playground — Engineering Handoff

This document is for an engineer wiring the playground's polish layer for a team. Most of the discipline and content has been done by design / PM; this is the short list of things only an engineer can do.

Reading this end-to-end + executing the steps should take roughly **2–3 days**.

## What's already in place (verify before adding more)

| Layer | What should exist | Confirm by |
|---|---|---|
| Rules | `CLAUDE.md` with team-specific in-scope paths, prefix, voice rules | Open and scan — all `<FILL IN>` placeholders should be replaced |
| Permissions | `.claude/settings.json` allowlist tuned to in-scope paths | `<YOUR-THEME-PATH>` placeholders should be replaced |
| Discipline | `playground/scripts/verify.sh` with IN_SCOPE_REGEX set | Run it: should pass on a clean main; should fail on a deliberate violation |
| Refresh stub | `playground/scripts/refresh.sh` | Currently a stub. Replace with the actual command — this is task 1 below |
| Content | `playground/guidelines/*.md`, `glossary.md`, wishlist files | Filled in with team-specific content |

## Tasks, in order

### 1. Wire the refresh command (~half a day)

Replace the stub in `playground/scripts/refresh.sh` with whatever makes a change visible on your platform. Examples:

```bash
# Server-rendered with caching (Moodle, Drupal, Rails-with-caching):
docker exec <container-name> <cache-purge-command>

# Hot-reload frameworks (Next.js, Vite, Webpack):
echo "Hot reload is automatic. Refresh your browser."

# Compiled assets:
npm run build:dev
```

Then wire it as a Claude Code `PostToolUse` hook in `.claude/settings.json` so it runs automatically after every Claude edit. Match on file globs that need refresh (templates, lang files, compiled SCSS — not source files that hot-reload):

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "filePattern": "<glob-for-files-that-need-refresh>",
        "hooks": [{ "type": "command", "command": "./playground/scripts/refresh.sh" }]
      }
    ]
  }
}
```

The hook should be quiet on success and surface errors to Claude only. Without this, designers will hit "I changed it but nothing happened" friction constantly.

### 2. Build out the verify script (~half a day)

The shipped `verify.sh` covers path-scope, prefix, raw-value, and prompt-log checks. Add team-specific checks:

- **Stylelint / eslint / etc.** Run only on changed files in scope, fail on errors.
- **Template / Mustache / JSX balance check.** Catches half-finished edits.
- **A11y smoke check** if you have a tool like `axe-core` configured.
- **Cross-tenant / per-role concerns** specific to your product.

Each check should be cheap (run in a few seconds), produce a single clear message on failure, and translate the failure into plain language Claude can surface to a non-engineer.

### 3. Seed data + persona logins (~1–2 days, optional but high-value)

If designers will be prototyping against the product, they need realistic content. Generic dev-environment defaults make prototypes look fake. Concretely:

- A `playground/seed/` directory with realistic content fixtures (use the AI to generate them — see below).
- A small CLI script that imports them into your local dev environment.
- 2–3 test users at different roles / states / tenants if your product is multi-tenant. A `./play login <persona>` switcher is gold.
- A `./play reset` that wipes and re-imports the seed.

For the content itself: one prompt to Claude generates a JSON file of realistic entities (courses, products, articles, customers, whatever your product is about). Avoids stripping prod backups.

### 4. Bridge to your spec source (~1 day, optional)

If your team uses a PM workflow tool that produces structured specs (ProductClaw, Notion-via-API, Linear, a folder of markdown specs):

- Configure `.claude/skills/from-spec/SKILL.md` to recognise your spec format.
- Add the spec-source repo URL or location to the skill so Claude knows where to look.
- Optionally: add a `./play from-spec <path>` shortcut that invokes the skill.

The skill already handles triage (is this spec in-scope for the playground?), scope filtering (UI only), and traceability back to the originating spec.

### 5. Permissions audit (~1 hour)

Run the playground with a real designer for one session. After, use the `fewer-permission-prompts` skill (or just look at the prompt log) to identify safe operations that triggered permission prompts. Add them to the `.claude/settings.json` allowlist. Designers will rage-quit otherwise.

### 6. The first acceptance test

Sit with a designer. Ask them to run one prompt cold — *"add a small banner to [page] about [topic]"*. If they get a visible result they can screenshot without your help, the playground is alive.

If they get stuck, the failure point tells you what to fix next.

---

## Things you deliberately should NOT do

- **Don't auto-merge prototype branches.** They're meant for review, not deployment.
- **Don't add tokens / components without design review** even if a wishlist entry asks for them. The wishlist is evidence; design owns the response.
- **Don't broaden the in-scope paths without explicit reason.** Each broadening reduces the guardrail. If a designer needs a new path, they should ask, not have it silently added.
- **Don't replace the `./play` wrapper with raw git invocation.** The wrapper hides git from non-engineers; bypassing it breaks the model.

## Known risks to mitigate

- **Stale prototype branches** if review cadence slips. Suggest a rule: any `prototype/*` branch not reviewed in 6 weeks gets closed by its author or auto-archived.
- **Cache invalidation is the single highest-risk piece.** Bulletproof step 1 above before going wider.
- **Brand drift** if guidelines are sparse. The `audit.sh` script catches accumulated drift; run it periodically.

## One-page summary for non-technical stakeholders

> A local environment a non-engineer can run on their laptop, with Claude Code preloaded with our team's brand and product rules. They prompt Claude to make UI changes — recolour a button, add a banner, rearrange a card. Claude follows our rules automatically and produces real code on a branch. When engineering has time, they review the branch like any other contribution. Designers never need to write code; engineers never get unreviewed code in production. The wishlist files tell us which design-system gaps designers keep hitting and which features people keep asking for — real evidence to drive the design-system and engineering backlogs.
