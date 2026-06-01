# playground/

Design content for the WTA PrimeVue component library — the rules and context that keep prototypes on-brand and capture decisions over time.

| Path | Purpose |
|---|---|
| `glossary.md` | Technical → plain-language mapping used when talking to non-engineers |
| `guidelines/` | Voice, colour, and layout rules for WTA UI |
| `wishlist/` | Captured decisions, design-system gaps, and engineering work |

## Conventions

- **Theme tokens**: the WTA theme lives in `src/main.js` (PrimeVue `definePreset`). Style through PrimeVue tokens / CSS variables rather than hardcoded values. See `CLAUDE.md`.
- **In-scope paths**: defined in `CLAUDE.md` and `.claude/settings.json`. Anything outside is refused.

## Filling in the guidelines

The guideline templates still have `FILL IN` sections to complete with WTA's actual rules:

- [ ] `playground/guidelines/voice.md` — WTA voice and UX-writing rules
- [ ] `playground/guidelines/colour.md` — colour and token usage
- [ ] `playground/guidelines/layout.md` — layout and page-pattern rules
- [ ] `playground/glossary.md` — plain-language names for technical concepts
