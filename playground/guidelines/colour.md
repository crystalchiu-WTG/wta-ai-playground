# Colour usage

> **FILL IN**: this is a template. Replace the bracketed sections with your team's actual rules. Colour is the rule most likely to drift if not pinned down, so be specific.

How `<YOUR TEAM>` uses brand colour in the UI. These rules apply on top of the design tokens defined in `<path-to-your-tokens-file>`.

## Tokens, in plain English

> **FILL IN**: list your token families and what each one means / when it's used. Example structure:

| Token family | Use for |
|---|---|
| `<token-family-1>` | primary actions, branded elements |
| `<token-family-2>` | success states, positive moments |
| `<token-family-3>` | warnings, attention-needed |
| `<token-family-4>` | errors, destructive actions |
| `<token-family-5>` | accent / highlight (sparingly) |
| `<neutral scale>` | surfaces, text, borders, shadows |

## When each colour gets used

> **FILL IN**: be specific about what gets which colour. Examples:
>
> - **Primary actions** (Submit, Save, Continue): always `<your primary token>`.
> - **Secondary actions** (Cancel, Back): `<your secondary token>`, never `<your primary>`.
> - **Destructive actions** (Delete, Remove): `<your destructive token>`.
> - **Information notices**: `<your info token>` background, `<your info text>` text.
> - **Success messages**: `<your success token>`.
> - **Inline links in body copy**: `<your link token>`, not `<your primary>`.

## The hard rules

- **Never use a raw hex / px / rem value outside the canonical token file.** If a value isn't in the token file, use the closest existing token and log the gap in `playground/wishlist/design-system.md`. Never add a new token without design-system review.
- **One primary action per view.** If two things look equally important, neither is.
- **Accent colours are for moments, not surfaces.** Use sparingly to draw the eye to one thing on a page.
- **Contrast must hit WCAG 2.1 AA at minimum** (4.5:1 for body text, 3:1 for large text and UI components). The token combinations below have been verified — if you compose colours outside these, run a contrast check.

## Approved combinations

> **FILL IN**: list the token pairs that have been verified for contrast. Anything not on this list shouldn't be used together without checking.

| Foreground | Background | Use |
|---|---|---|
| `<token>` | `<token>` | body text on default surface |
| `<token>` | `<token>` | inverted text on dark surface |
| `<token>` | `<token>` | text on accent surface |

## Don't

- ❌ `<example of what NOT to do>`
- ❌ Mixing token families on the same component (e.g. primary background with destructive text)
- ❌ Using the brand colour as a generic neutral (it competes with content)
- ❌ Using accent colours for entire backgrounds (overwhelms)

## Notes for Claude

When a designer asks for a colour that isn't in the token list: use the closest existing token, mention the substitution in plain language ("I used our closest mint tone — it's slightly different from the exact shade you asked for"), and append the gap to `playground/wishlist/design-system.md`. Never propose adding a new token.
