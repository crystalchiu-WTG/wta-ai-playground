# The Playground Pattern

A way of wiring AI assistance into a product team's git workflow so that prompts produce real artefacts inside the team's actual codebase, with hard guardrails, plain-language interfaces for non-engineers, and clean handoff to engineering review.

This is a **pattern**, not a tool. It works for any product team — web, mobile, desktop, internal tools, library code — regardless of platform, stack, or whether the team does eLearning, fintech, healthcare, or anything else. The implementation is per-team; the shape is constant.

---

## The problem it solves

Most product teams have the same three pain points around AI assistance today:

1. **AI output is disconnected from the real product.** Designers prototype in HTML that doesn't use the team's components. PMs draft specs in tools that engineering then has to translate. The AI produces work that has to be rebuilt before it ships.
2. **Non-engineers can't safely prompt against the codebase.** Without guardrails, AI happily edits authentication, schema, or third-party code. Without translation, AI output reads like a CI log. So the AI sits in a separate sandbox and never touches anything that matters.
3. **Decisions and gaps evaporate.** Every prompt session produces context that's lost the moment the tab closes. There's no shared memory of "we tried this, it didn't work because X, here's what we'd need."

The playground pattern addresses all three by anchoring the AI workflow to the team's git repo, with explicit scope rules, plain-language voice, and persistent capture of decisions and gaps.

---

## The shape

A `playground/` directory inside the team's existing repo, plus a top-level `play` script and a `.claude/` configuration:

```
your-repo/
├── CLAUDE.md                ← role-aware instructions for the project
├── play                     ← single command wrapping the workflow
├── .claude/
│   ├── settings.json        ← permission allowlist, prompt-routing hooks
│   └── skills/              ← team-specific workflow skills
└── playground/
    ├── README.md            ← what this is, who uses it
    ├── QUICKSTART.md        ← non-engineer setup, ~half a day
    ├── HANDOFF.md           ← engineer pickup, ~2–3 days to polish
    ├── glossary.md          ← technical → plain mapping
    ├── guidelines/          ← voice, brand, layout rules
    ├── wishlist/
    │   ├── decisions.md     ← captured decisions
    │   ├── design-system.md ← gaps in tokens / components
    │   └── engineering.md   ← work that needs a real engineer
    └── scripts/
        ├── verify           ← "is this change inside our rules?"
        ├── refresh          ← "make the change visible"
        └── audit            ← "where is drift accumulating?"
```

Everything in this tree is committed to git. Prompt history lives in `playground/prompt-log.md` on each branch. Nothing important lives only in chat.

---

## The five universal needs

Every product team needs these, regardless of platform:

1. **A guardrail layer.** What AI can edit, what it can't, what triggers an outright refusal. Encoded in `CLAUDE.md` and enforced by `.claude/settings.json` permissions plus pre-edit hooks.

2. **A discipline layer.** Automated checks that keep generated work consistent with the team's standards. The `verify` script runs after every change — confirms in-scope paths, lint passes, naming conventions hold, no raw values where tokens should be.

3. **A translation layer.** Plain language for the non-engineers prompting (PMs, designers); technical detail for the engineers reviewing. The `glossary.md` and voice rules in `CLAUDE.md` handle this. Without translation, only engineers can use the tool.

4. **A capture layer.** Wishlists, decision logs, and prompt history that survive sessions. Captured in plain markdown so it's reviewable and searchable. The wishlist files become real backlog evidence over time.

5. **A workflow layer.** Branch-per-experiment, save / discard semantics, handoff to review. The `./play` wrapper hides git from non-engineers while preserving the underlying git workflow for engineering.

---

## How it works in practice

A typical session, regardless of team:

1. A PM or designer runs `./play new "homepage hero variant"`. New branch created, clean state.
2. They prompt Claude in plain English: *"Try a more prominent hero with the secondary brand colour."*
3. Claude reads the relevant components, the design tokens, and the guidelines, then edits files inside the allowed scope.
4. The `verify` script runs automatically. If it fails, Claude fixes silently and retries.
5. The `refresh` script makes the change visible in whatever the team's preview environment is.
6. The user iterates: *"smaller, less padding, use the warm accent instead."*
7. When satisfied: *"save it."* Claude commits to the branch, appends to the prompt log, pushes (optional).
8. Engineering picks up the branch when they have capacity, reviews like any other contribution.

Nothing reaches `main` without review. Nothing escapes the team's standards along the way.

---

## What's universal vs what's per-team

| Universal (works for any team) | Per-team (you fill in) |
|---|---|
| The directory shape | Which paths are in-scope |
| The `./play` command surface | Which platform `refresh` targets |
| The wishlist file structure | The actual guideline content |
| The verify-on-save discipline | The lint rules and conventions |
| The plain-language translation pattern | The glossary mappings for your codebase |
| The branch-per-experiment workflow | Your branch naming conventions |
| The HANDOFF + QUICKSTART doc pair | Your team's setup specifics |
| The from-spec bridge pattern | Where your specs come from |

About 80% of the implementation is pattern; 20% is team content.

---

## What this is NOT

Worth being explicit about scope:

- **Not a SaaS or platform.** No central server, no shared multi-tenant anything. Each team's playground lives in their own repo.
- **Not a replacement for design tools.** Figma still exists. Linear / Jira still exist. The playground complements them.
- **Not auto-shipping.** Prompted output never reaches production without normal review. The playground produces *candidates*, not deployments.
- **Not for solo work.** The discipline matters because multiple people use it. A single developer prompting at their desk doesn't need this.
- **Not a chat history.** Prompts and decisions are persistent artefacts in git, not ephemeral conversation logs.

---

## Where to start

If you're a new joiner on a product team and want to introduce this:

1. **Read this doc.** Decide if the shape matches your team's pain points.
2. **Clone the starter kit** (this repo). Strip the bits you don't need.
3. **Spend ~2 hours filling in team-specific content.** In-scope paths, a glossary stub, a half-page of voice rules.
4. **Try one prompt end-to-end yourself.** It will probably fail the first time. Iterate.
5. **Show one colleague.** Don't propose a team-wide rollout. Let adoption spread sideways.
6. **Layer in bridges over time.** Spec source integration, Figma sync, deploy previews — each as you hit the need.

Total time to a working v0.1: roughly half a day of setup plus an afternoon of content. Total time to a team-wide useful tool: 4–6 weeks of organic growth, not a big-bang rollout.

---

## The honest caveat

The pattern is only as good as the content the team fills in. A playground with no guidelines, no glossary, no honest in-scope rules is just chatGPT with extra steps. The discipline of *writing the team-specific content* is where the real value lives. The scaffolding makes that work feel small instead of impossible, which is the whole point.
