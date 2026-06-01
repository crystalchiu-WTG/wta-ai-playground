# WTA PrimeVue component library

A [PrimeVue v4](https://primevue.org) component library themed with WTA brand tokens, built on Vue 3 and Vite. It's a playground for seeing and prototyping WTA-branded UI: PrimeVue components styled with CW Blue, DM Sans, and the WTA colour palette.

## Quick start

```bash
npm install
npm run dev
```

Then open the dev server URL it prints (default `http://localhost:5173`). The page hot-reloads as you edit.

```bash
npm run build      # production build
npm run preview    # preview the production build
```

## What's in here

```
.
├── index.html                 ← app entry
├── src/
│   ├── main.js                ← PrimeVue setup + WTA theme (definePreset)
│   └── App.vue                ← component gallery
├── CLAUDE.md                  ← rules for working in this repo with Claude Code
└── playground/
    ├── glossary.md            ← plain-language names for technical concepts
    ├── guidelines/            ← voice, colour, layout rules
    └── wishlist/              ← captured decisions, design-system gaps, eng work
```

## The WTA theme

The brand theme is defined in [`src/main.js`](src/main.js) using PrimeVue's `definePreset`:

- **Primary** — CW Blue (`#371EE1`) with navy hover/active shades
- **Semantic** — WTA success (`#18794E`), warning (`#c97a00`), danger (`#CE2C31`)
- **Surfaces** — the WTA grey palette
- **Font** — DM Sans

All components inherit from these tokens, so the whole library stays consistent.

## Adding components

Import PrimeVue components and drop them into `src/App.vue` (or new components under `src/`). They pick up the WTA theme automatically. See the [PrimeVue docs](https://primevue.org) for the full component list.
