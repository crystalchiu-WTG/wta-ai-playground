# Playground — Quickstart (no engineering required)

A guide for a non-engineer (designer or PM) standing up the playground for the first time. Polish (auto cache hook, lint integration, seed data, etc.) lands when engineering wires the rest. This gets you a working prompt loop.

**Time:** ~half a day if your local environment cooperates; up to a full day if not.

---

## What you'll have at the end

- The product running locally at `localhost:<port>`.
- Claude Code in VS Code, pointed at this repo.
- A working `CLAUDE.md` telling Claude how to behave.
- Ability to prompt *"change the homepage hero to use the warm accent colour"* and see it appear.

## What you won't have yet

- Automatic refresh after Claude edits files (you may need to run one command).
- Realistic seed data (you use what's in your dev environment).
- Automated lint in CI (Claude self-checks via `CLAUDE.md` rules and `verify.sh`).

> **FILL IN**: list any other gaps specific to your team — multi-tenancy testing, missing personas, etc.

---

## Step 1 — Get the product running locally

> **FILL IN**: this is the most team-specific part. Document the exact steps to run your product locally. Examples:
>
> - "Follow `README.md` → `Local Dev Setup`. You'll need Node 20+, Postgres, and `pnpm install`."
> - "Run `docker compose up`. Open `localhost:3000`."
> - "Follow the team Wiki's `Onboarding` page — it covers VPN, the internal registry, and the dev seed."
>
> If setup fails, point at: IT for environmental issues (VPN, packages, permissions), engineering only if the failure is code-level.

**Sanity check:** `localhost:<port>` loads the product in your browser. Log in as a test user.

## Step 2 — Install Claude Code

1. Open VS Code.
2. Install the **Claude Code** extension from the marketplace.
3. Open this repo as your workspace.
4. Sign in to Claude when prompted.

## Step 3 — Fill in the team-specific bits

> **FILL IN**: confirm whoever set up this playground has filled in:
>
> - `CLAUDE.md` (the `<FILL IN>` placeholders)
> - `.claude/settings.json` (the `<YOUR-THEME-PATH>` placeholders)
> - `playground/scripts/verify.sh` (the IN_SCOPE_REGEX line)
> - `playground/scripts/refresh.sh` (replace the stub)
> - `playground/glossary.md` (file → page-name mappings)
> - `playground/guidelines/*.md` (voice, colour, layout)
>
> If any aren't done, the playground will still work but with weaker guardrails. Flag back to whoever owns this setup.

## Step 4 — Try the first prompt

In Claude Code, type something specific and small, e.g.:

> Change the homepage hero copy to "Welcome back, [name]" and shift the call-to-action button to the warm accent colour.

Claude will:
1. Read existing components to learn your house style.
2. Edit files inside the in-scope paths.
3. Tell you which page to refresh.

Open the relevant URL and refresh.

> **FILL IN**: if your platform needs a manual refresh step beyond a browser refresh (e.g. cache purge), document the exact command here. For example: "If the change doesn't appear, run `./play refresh`."

## Step 5 — Iterate

Prompt Claude:

- *"Make the headline smaller."*
- *"Use sentence case instead."*
- *"Add a small dismissible banner above it announcing the spring promotion."*

Each prompt should produce a visible change you can see in the browser. When you're happy:

> Save it.

Claude responds *"Saved as a draft for the engineering team to review later."*

If you want to throw the prototype away and start over: *"discard it."*

---

## Optional: commands you can run yourself

You usually won't need these — Claude runs them when you ask in plain English. But if you want to use them directly:

```
./play status              what's changed, which branch you're on
./play new "<thing>"       start a new prototype branch
./play verify              run the discipline checks
./play refresh             reload the product so a change appears
./play save                commit your work as a draft
./play discard             throw away the current prototype
./play help                show this list
```

When you eventually want to **share the prototype with engineering**, push it:

```bash
git push -u origin $(git branch --show-current)
```

(Or ask Claude: *"share this with engineering."*)

---

## Prototyping from a product spec

If a PM has already produced a specification (e.g. from ProductClaw, Notion, Linear, or a markdown spec file), the playground can prototype the UI directly from it. Paste this prompt:

> Read the spec at `<absolute-path-to-spec.md>`. Build a prototype implementing the user-facing UI it describes. Skip anything backend, schema, permission, or business-logic related — flag those instead. Use existing components and tokens only. When done, link the prototype back to the spec in the prompt log.

Claude will check the spec is in-scope (not for a different product, a different stack, or a backend-only feature). If it isn't, Claude will tell you so plainly and stop.

---

## What to do if something feels broken

| Symptom | Probably means | Try |
|---|---|---|
| Claude edits a file but the page doesn't change | Cache / build / template issue | Hard-refresh (Ctrl+Shift+R). If still nothing, run `./play refresh`. |
| Claude says it can't do something | Red trigger — needs engineering | Read its plain-language explanation; it'll have added an entry to `playground/wishlist/engineering.md`. |
| Claude wants to add a new colour / value | Design-system gap | It'll use the closest existing token and log the gap in `playground/wishlist/design-system.md`. This is correct. |
| Claude touches a file outside the allowed area | Shouldn't happen — flag it | Stop, paste the file path back to Claude, ask why. If unsure, ask engineering. |
| Local setup won't start | Environmental | Check the team's setup docs. Ask IT, not engineering, for environmental issues. |
