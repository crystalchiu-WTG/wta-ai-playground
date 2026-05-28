# Layout & page patterns

> **FILL IN**: this is a template. Replace the bracketed sections with your team's actual rules.

How `<YOUR TEAM>` lays out pages. These rules cover the structural decisions that span every page — what must be present, what's optional, what gets used where.

## Foundations

> **FILL IN**: state your fundamental layout choices.
>
> - **Grid**: `<your column system / max-width / breakpoints>`
> - **Spacing scale**: `<your spacing token names>`
> - **Vertical rhythm**: `<your line-height / spacing rules>`
> - **Container width**: `<max content width and reasoning>`

## Required elements

Every page must contain:

> **FILL IN**: list the must-haves. Example:
>
> - A clear `<h1>` describing what the page is about
> - Primary navigation
> - A breadcrumb or back affordance (where the page isn't a top-level destination)
> - A consistent footer (or none, but consistently)

## Page patterns

> **FILL IN**: list the major page archetypes in your product and what's expected of each. Examples:

### Dashboard

> A dashboard must include: greeting / context, what's-new / activity feed, primary action, secondary navigation.
> Avoid: empty grids of cards with no content yet (use a single guided empty state instead).

### Detail page

> A detail page must include: hero / context for the entity, primary actions, supporting metadata, related items where relevant.
> Avoid: walls of fields with no hierarchy.

### List / catalogue page

> A list page must include: filter / sort affordances, item count, the items, pagination or load-more.
> Avoid: lists with no way to narrow them once they exceed one screen.

### Form

> A form must include: a clear title, grouped fields, inline validation, a primary submit + a secondary cancel.
> Avoid: forms longer than one screen without sectioning.

## State patterns

Every interactive surface must handle:

> **FILL IN**: be specific about each state.

| State | Required content |
|---|---|
| Empty | `<what to show, what next action to offer>` |
| Loading | `<spinner / skeleton / inline label?>` |
| Error | `<inline / banner / modal? what message?>` |
| Success | `<inline confirmation / toast / page change?>` |
| Disabled / readonly | `<visual treatment, accessibility>` |

## Composition

- **Compose existing components before creating new ones.** Check the component folder first.
- **One primary action per view.** See `colour.md`.
- **Don't reinvent containers.** Use existing cards, banners, panels.
- **New patterns need a flag.** If a page genuinely needs a layout that doesn't exist, add it to `playground/wishlist/design-system.md` and use the closest existing pattern in the prototype.

## Responsive behaviour

> **FILL IN**: state your breakpoints and what happens at each.

| Breakpoint | What changes |
|---|---|
| `<small / mobile>` | `<e.g. nav collapses to drawer; cards stack 1-up>` |
| `<medium / tablet>` | `<e.g. cards 2-up; nav still collapsed>` |
| `<large / desktop>` | `<e.g. cards 3-up; nav inline>` |

Test every prototype at the team's lowest supported width before saving.

## Accessibility (minimum)

> **FILL IN**: extract from `accessibility.md` if it exists, or write the basics here.
>
> - All interactive elements have a discernible label (visible text or `aria-label`).
> - Focus order matches visual order.
> - Headings are sequential (no skipping levels).
> - Contrast hits WCAG 2.1 AA (see `colour.md`).
> - Forms have explicit `<label>` associations.

## Don't

> **FILL IN**: list anti-patterns specific to your product. Examples:
>
> - ❌ Modals stacking on modals
> - ❌ Carousels for primary content (low engagement, fragile on mobile)
> - ❌ Hover-only interactions (broken on touch)
> - ❌ Page-level loading spinners with no skeleton
