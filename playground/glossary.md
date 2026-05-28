# Glossary — technical names → plain names

When talking to non-engineers, **never** use the left-column terminology. Use the right column instead. Extend this file as you encounter terms designers and PMs need translated.

This file is read by Claude when the `CLAUDE.md` voice rules apply, so every entry directly affects how Claude communicates.

## Files / templates / components

> **FILL IN**: list the files, templates, or components that come up often, and what to call them in plain English. Examples below — replace with your codebase.

| Technical | Say instead |
|---|---|
| `<file or component path>` | `<page name / component label a user would recognise>` |
| `src/components/Header.tsx` | the site header |
| `src/pages/dashboard.tsx` | the dashboard |
| `templates/welcome.mustache` | the welcome banner |

## URLs — where designers can see things

| Designer wants to see | URL |
|---|---|
| Homepage | `localhost:<port>/` |
| Dashboard | `localhost:<port>/<path>` |

> **FILL IN**: list the main URLs of your local dev environment.

## Concepts

| Technical | Say instead |
|---|---|
| token / `$prefix-*` variable | brand colour / size / spacing |
| BEM / class prefix | naming convention |
| renderer / template / component | how a page section is built |
| lint check | style rule check |
| commit / push / branch | save as a draft for the team |
| PR / merge | reviewed and shipped |
| in-scope path | the area I'm allowed to change |
| red trigger | something only engineering can do |
| wishlist | the list of things waiting for the engineering team |

> **FILL IN**: add team-specific concept translations — your product-specific terms (e.g. proper nouns like "Quickstart", "Workspace", "Engagement"), framework jargon, multi-tenancy terms.
