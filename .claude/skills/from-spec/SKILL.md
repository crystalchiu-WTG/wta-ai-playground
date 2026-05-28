---
name: from-spec
description: Build a prototype from a product specification file. Use when the user provides a path to a `.md` file under an `initiatives/{slug}/specs/` folder (or similar spec-source location), or asks to "prototype from a spec".
command: from-spec
---

# From-Spec — Prototype from a Product Spec

You are bridging an upstream **product-spec workflow** (e.g. ProductClaw, a PM workflow tool, or a folder of markdown specs) and this **playground**. Specs describe what should be built; this skill turns the user-facing UI parts of a spec into a real prototype on a branch inside your in-scope paths.

## When to invoke

Activate when any of the following is true:

- The user pastes a path to a file matching `**/initiatives/*/specs/*.md` (typical spec location)
- The user says "prototype from the spec" / "build a prototype from this spec" / "implement this spec"
- The user pastes spec-style frontmatter (`feature:`, `traces_to:`, `phld_reference:`) and asks for a prototype

> **FILL IN**: if your team's spec source lives somewhere else (e.g. a specific repo, a Notion export, a Linear ticket structure), document the pattern here so the skill can detect it.

## Step 1 — Locate the spec

Get the absolute path. If the user gave a relative path or partial filename, ask for the full path. Read the spec file completely. Also read (when present in the same folder):

- The product high-level design (typically `product-high-level-design.md`) for done-statement context
- The context brief (`context.md`) for problem framing

If any are missing, note it and proceed with what's available. Don't invent.

## Step 2 — Triage: is this in-scope for this playground?

The playground only prototypes UI changes inside the in-scope paths declared in `CLAUDE.md`. Many specs target areas the playground can't touch — backend services, databases, other products, etc.

Triage rules:

| Signals it IS for our playground | Signals it ISN'T |
|---|---|
| Spec references the in-scope UI surface (pages, components, copy) | Spec references an out-of-scope product or area |
| Spec is about a user-facing UI element | Spec is about database / API / deployment / infrastructure work |
| Spec frontmatter `design_area` matches an area you maintain | Spec is about a sister product on a different stack |
| The HLD's design section talks about templates / styles / layouts you control | Spec is about reports, exports, or analytics that don't render in the UI surface |

**If the spec is NOT in-scope**, respond plainly:

> "This spec is about [out-of-scope area, named clearly]. The playground only prototypes UI changes to [our in-scope surface]. For prototyping this spec, stick with whatever tool the upstream workflow recommends, or hand it directly to engineering. If you want, I can summarise what this spec asks for so you can decide where it should be prototyped."

Stop. Do not write code.

**If the spec IS in-scope**, continue.

## Step 3 — Extract the UI scope

From the spec, identify ONLY the user-facing UI behaviour. Specifically:

- Page locations, layouts, components
- Exact button labels, headings, copy
- Visible states (active, hidden, disabled, loading, empty, error)
- Visual elements (cards, banners, badges, modals)

Explicitly **exclude** from the prototype:

- Schema / database changes
- Auth, permission, or role logic
- API behaviour
- Validation logic beyond visible feedback
- Performance / caching concerns

If exclusions remove most of the spec, say so to the user:

> "Most of this spec is backend / permission / data work. The prototypable surface is small: [list what remains]. Should I proceed with just that, or is this not worth a prototype?"

## Step 4 — Start a prototype branch

Run:

```
./play new "<short-slug-from-spec-title>"
```

This puts you on `prototype/<user>/<slug>` off `main`.

## Step 5 — Prototype the UI scope

Apply all the discipline rules from `CLAUDE.md`:

- Use the team's naming / prefix convention
- Tokens read-only (closest match + flag to `playground/wishlist/design-system.md` for missing values)
- In-scope paths only
- Compose existing components before creating new ones
- Platform-specific concerns flagged where relevant
- Use the non-engineer voice (plain English, page names not file paths)

For excluded behaviour (backend, permissions, data), append entries to `playground/wishlist/engineering.md` with the spec path in the source field, e.g.:

```
Source: spec — initiatives/{slug}/specs/{feature}.md
```

So engineering can trace the wishlist item back to the originating spec.

## Step 6 — Link the prototype back to the spec

Append an entry to `playground/prompt-log.md` on the current branch:

```
## YYYY-MM-DD HH:MM
> Prototype from spec

Spec: <absolute-path-to-spec.md>
Initiative: {slug}
Done statements covered (UI only): DONE-XX, DONE-XX
Excluded (engineering work): DONE-XX (reason), DONE-XX (reason)

<one-line summary of what visibly changed in the prototype>
```

The traceability matters: when engineering eventually reviews the prototype branch, they can pull the originating spec and check the prototype against it.

## Step 7 — Self-check and hand back

Run `./play verify`. Fix any issues silently. Then tell the user in plain language:

> "Done. I've prototyped the UI parts of this spec on a fresh branch:
>
> - [What you visibly changed, in plain language]
>
> Refresh `localhost:<port>/<path>` to see it.
>
> Some parts of the spec needed engineering work, so I've added them to the wishlist: [one-line summary]. Those will get picked up when an engineer reviews the branch.
>
> When you're happy, say 'save it'."

## Notes

- This skill is intentionally narrow. It does not modify spec-source artefacts, does not write specs, does not invoke spec-source skills. It only consumes a spec as input.
- If the spec changes after the prototype is built, the prototype doesn't auto-update. Re-run this skill against the new spec; it'll create a new prototype branch.
- If the spec source isn't checked out locally, ask the user to clone it or paste the file content directly.
