# Playground starter kit

A starter scaffold for wiring AI assistance (Claude Code) into a product team's git workflow. Designers and PMs prompt Claude in plain English; Claude produces real artefacts inside the team's actual codebase, with hard guardrails so output stays on-brand and inside scope. Engineers review like any other contribution.

This repo is **the scaffold**. You clone it, fill in the parts that are specific to your team and product, and you have a working playground in a few days. The pattern itself (the *why* and the *shape*) is documented in `PATTERN.md`.

---

## Who this is for

Product teams that want:

- PMs / designers prompting Claude against the real codebase, without engineers babysitting.
- Hard rules about what AI can touch (theme files, copy, layout) and what it can't (auth, schema, dependencies).
- Plain-language output for non-technical users; persistent capture of decisions and gaps in git.
- A clean handoff to engineering for review and merge.

It works for any product — web app, mobile app, internal tool, eLearning platform, anything — regardless of stack, framework, or whether your team is large or small.

It does NOT replace your design tools, your spec tools, or your engineering review. It complements them.

---

## What's in the scaffold

```
.
├── README.md                  ← you're here
├── PATTERN.md                 ← the concept, in 2 pages
├── CLAUDE.md                  ← the rulebook Claude reads every session (FILL IN team-specific bits)
├── play                       ← single-command wrapper (new / save / refresh / verify / discard / status / help)
├── config.example.yml         ← example configuration (copy to config.yml, fill in)
├── LICENSE                    ← MIT
├── .claude/
│   ├── settings.json          ← permission allowlist (FILL IN your in-scope paths)
│   └── skills/
│       └── from-spec/         ← skill to prototype from a product spec file
└── playground/
    ├── README.md              ← scaffold overview
    ├── QUICKSTART.md          ← non-engineer setup (FILL IN your platform specifics)
    ├── HANDOFF.md             ← engineer pickup brief
    ├── glossary.md            ← technical → plain-language mapping (FILL IN)
    ├── guidelines/            ← voice, colour, layout, accessibility rules (FILL IN)
    ├── wishlist/              ← captured decisions, design-system gaps, eng work
    └── scripts/
        ├── verify.sh          ← discipline checks (configurable)
        ├── refresh.sh         ← make changes visible (configurable per platform)
        └── audit.sh           ← surface drift in tokens / conventions
```

About 80% of the files are usable as-is. The 20% you fill in — marked **FILL IN** above — is the team-specific content: which paths Claude can edit, your voice rules, your design tokens, your platform's refresh command.

---

## How to use it

1. **Read `PATTERN.md`** (5 minutes). Decide if the shape fits your team.
2. **Clone or fork this repo** into a place where you can experiment, then copy the scaffold into your team's real product repo.
3. **Fill in the FILL IN sections** in `CLAUDE.md`, `.claude/settings.json`, `playground/glossary.md`, and the guideline templates. Half a day total.
4. **Adapt `play refresh`** to your platform — whatever command makes a change visible (cache purge, hot reload, container restart). One line of bash usually.
5. **Try one prompt yourself.** Open Claude Code in your repo, ask for a small visible change. Iterate until it works end-to-end.
6. **Show one colleague.** Don't propose a team-wide rollout. Let adoption spread sideways.
7. **Layer in bridges over time** — spec source integration, Figma sync, deploy previews — each as you hit the need.

Total time to v0.1: roughly half a day of setup + an afternoon of content. Total time to a team-wide useful tool: 4–6 weeks of organic growth.

---

## What's documented where

| Read | When |
|---|---|
| `PATTERN.md` | Before you decide whether to use this. |
| `README.md` (you're here) | First, to see what's in the kit. |
| `playground/QUICKSTART.md` | When a non-engineer wants to set up their local instance. |
| `playground/HANDOFF.md` | When engineering needs to do the wiring (cache hook, lint integration, seed data). |
| `CLAUDE.md` | When you want to understand or change the rules Claude follows. |
| `.claude/skills/from-spec/SKILL.md` | If you want Claude to prototype from a product spec file (e.g. from a PM workflow tool). |

---

## Origin

This scaffold was extracted from the WTA Academy UX playground (`WiseTechGlobal/WTA.Ramen`, branch `wip/ux-moodle-playground`), which is the worked example for the WTA team running Moodle/IOMAD with a custom theme. The pattern is generic; the WTA playground is the proof-of-concept.

If you adapt this for another team and learn something we should bake back in, raise an issue or a PR.
