# Engineering wishlist

Things designers / PMs asked for that require engineering work — schema changes, integrations, business logic, core platform changes, new dependencies, etc.

Claude appends entries automatically when a prompt hits a red trigger (see `CLAUDE.md`). The designer gets a plain-language explanation; the technical details land here for the engineering team.

---

## Entries

_(none yet)_

---

## Entry template

```
## <short title>

- **Branch:** prototype/<user>/<slug>  (or N/A if no branch was created)
- **Source:** <prompt-derived / spec at <path> / direct request>
- **Date:** YYYY-MM-DD
- **Ask:** <what the user prompted, verbatim>
- **Why it can't be done in the playground:** <plain reason, e.g. "needs a new database table">
- **What would be needed:** <rough technical sketch — leave for engineer to refine>
- **Suggested size:** S / M / L  (Claude's guess — engineer to confirm)
- **Workaround used in the prototype (if any):** <e.g. "stubbed with placeholder text", "linked to a static page">
```
