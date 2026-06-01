# Project context

This is a **PrimeVue v4 component library**, themed with WTA brand tokens. It's a Vue 3 + Vite app that showcases PrimeVue components styled to match WTA's design language (CW Blue primary, DM Sans, WTA surface/semantic colours). It exists as a playground for designers and PMs to see and prototype WTA-branded UI without standing up a full product.

**You are usually talking to a non-engineer (designer or PM)**, not an engineer. Communicate accordingly — see "Voice rules" below.

---

## Running it

- `npm install` — install dependencies
- `npm run dev` — start the Vite dev server (hot reload; changes appear on save, no manual refresh needed)
- `npm run build` — production build

---

## In-scope paths

Read freely across the repo. **Only edit** files inside:

- `src/**` — the Vue app, components, and theme configuration
- `playground/**` — guidelines, glossary, and wishlist

Anything else is out of scope — refuse and flag (see "Red triggers" below).

---

## Voice rules — talking to non-engineers

- **Plain English.** Minimise file paths, command names, and tool output in your replies.
- After a visible change: a one-sentence summary of what changed, and a reminder that it's live on the dev server (the page hot-reloads).
- **Frame errors as choices or next steps**, not failures.
- See `playground/guidelines/voice.md` for the full WTA voice and UX-writing rules. Apply them to any user-facing copy you write (button labels, headings, messages, empty states).

---

## Design discipline

### Components

- Use existing **PrimeVue v4** components wherever possible (`primevue/button`, `primevue/select`, etc.). Compose them rather than building bespoke UI.
- Before adding a new component, check whether PrimeVue already provides one.

### Theme tokens

- The WTA theme is defined in `src/main.js` via PrimeVue's `definePreset` — the brand palette (CW Blue primary), semantic colours (success/warning/danger), surface greys, and the DM Sans font all live there.
- Prefer styling through PrimeVue's design tokens and CSS variables (`var(--p-*)`) over hardcoded hex values, so components stay consistent with the theme.
- If a request needs a colour or value not in the theme, use the **closest existing token**, mention the substitution in plain language, and append the gap to `playground/wishlist/design-system.md`.

### Layout & colour

- See `playground/guidelines/colour.md` and `playground/guidelines/layout.md` for WTA's colour and layout rules.

---

## Red triggers — refuse and flag

If a request requires any of these, **stop, do not write code**, append it to `playground/wishlist/engineering.md`, and explain in plain language that it needs engineering help:

- New external API integrations or backend/data work
- New npm dependencies (beyond what's already installed)
- Build tooling or CI changes
- Anything outside the in-scope paths above

Plain-language framing:

> "What you're asking would need engineering work — it's not something I can do directly in this playground. I've added it to the wishlist so the team can pick it up. [If possible, suggest a UI-only alternative you can prototype instead.]"

---

## Capturing decisions and gaps

- Design or scope decisions worth remembering → `playground/wishlist/decisions.md`
- Missing tokens / design-system gaps → `playground/wishlist/design-system.md`
- Work that needs engineering → `playground/wishlist/engineering.md`
- Plain-language names for technical concepts → `playground/glossary.md`
