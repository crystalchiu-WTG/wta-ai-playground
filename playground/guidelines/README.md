# Guidelines

The team-specific UX content layer of the playground. These files tell Claude *how* your team wants UI built — voice, colour usage, layout patterns, accessibility, anything else.

## Files

| File | What it covers |
|---|---|
| `voice.md` | How copy reads: tone, person, capitalisation, vocabulary, punctuation, button labels, error / empty / success patterns |
| `colour.md` | When each brand token gets used: primary actions, secondary, semantic colours (success / warning / error), surface vs accent |
| `layout.md` | Page-level patterns: what every dashboard / detail page / list page must contain; empty / loading / error states |

> **FILL IN**: extend with additional files as your team needs them — for example:
>
> - `accessibility.md` — WCAG 2.1 AA checklist, focus order rules, alt-text conventions
> - `motion.md` — animation durations, easing, `prefers-reduced-motion` behaviour
> - `forms.md` — label position, required indicators, error placement, inline validation
> - `responsive.md` — breakpoints, what collapses, what stays

## How to write them — the unpopular answer

Don't try to write all the rules upfront. Most design-guideline projects fail by trying to write a comprehensive book before the system exists. Instead:

**Seed phase (one afternoon)** — write 5–10 rules everyone already agrees on. Stuff like *"All primary buttons use the brand colour. Body copy is sentence case. Headings are statements, not questions."* Half a page each, max.

**Growth phase (ongoing)** — every time Claude does something off-brand, the team captures it as a one-line rule in the relevant file. After 2–3 weeks of real designer usage, you have a doc grounded in actual decisions, not speculation.

**Promotion phase (later)** — when rules stop changing, engineering moves them into a proper Claude Code skill that auto-loads.

## Format

Each file should be **prescriptive and code-shaped**, not aspirational:

- ❌ "Be accessible" — useless.
- ✅ "Body text must hit 4.5:1 contrast against its background. The only approved combos are: X on Y, A on B, C on D." — enforceable.

Use tables with `Right / Wrong` examples wherever possible. Use the team's actual token names and component names — these files become Claude's reference, so accuracy matters more than elegance.

## How Claude uses them

Claude is told in `CLAUDE.md` to read the relevant guideline file before any UI change. When a designer's request conflicts with a written rule, Claude mentions the conflict in plain language before acting (*"our guideline says buttons stay one of three colours — want to use the closest match?"*) and lets the designer decide.

Never silently override a guideline. Always make the conflict visible.
