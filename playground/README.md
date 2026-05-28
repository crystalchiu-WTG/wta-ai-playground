# playground/

The team-specific scaffolding for the playground pattern. Contains:

| Path | Purpose |
|---|---|
| `QUICKSTART.md` | Non-engineer setup — how a designer or PM stands up their local instance |
| `HANDOFF.md` | Engineering pickup — what an engineer does to wire the polish layer |
| `glossary.md` | Technical → plain-language mapping Claude uses when talking to non-engineers |
| `guidelines/` | Voice, colour, layout, accessibility rules. **Fill in for your team.** |
| `wishlist/` | Captured decisions, design-system gaps, and engineering work |
| `scripts/` | `verify` (discipline checks), `refresh` (make changes visible), `audit` (drift detection) |
| `prompt-log.md` | Per-branch session record (created at first save) |

See the repo root `README.md` for the high-level overview and `PATTERN.md` for the underlying pattern.

## Conventions

- **CSS class / component prefix**: defined in `CLAUDE.md` and enforced by `verify.sh`. Replace `<YOUR-PREFIX>` placeholders with the prefix your team uses.
- **Design tokens**: only the canonical token file may define raw colour / spacing / size values. Everything else references tokens. See `CLAUDE.md` for which file is canonical in your team.
- **In-scope paths**: defined in `CLAUDE.md` and enforced by both `.claude/settings.json` and `verify.sh`. Anything outside is refused.

## Per-team work checklist

When you adopt this scaffold, fill in these files for your team:

- [ ] `CLAUDE.md` — replace all `<FILL IN>` placeholders
- [ ] `.claude/settings.json` — replace `<YOUR-THEME-PATH>` and `<YOUR-PLUGIN-PATH>` with your in-scope paths
- [ ] `playground/scripts/verify.sh` — set `IN_SCOPE_REGEX`, optionally `CLASS_PREFIX_BANNED` and `TOKEN_FILE_GLOB`
- [ ] `playground/scripts/refresh.sh` — replace the stub with your platform's refresh command
- [ ] `playground/scripts/audit.sh` — set `SCAN_DIR`, `EXCLUDE_PATHS`, `VIOLATION_REGEX`
- [ ] `playground/glossary.md` — add file → page-name mappings for your codebase
- [ ] `playground/guidelines/voice.md` — write your voice rules (see template)
- [ ] `playground/guidelines/colour.md` — document token usage (see template)
- [ ] `playground/guidelines/layout.md` — document page-pattern rules (see template)
- [ ] `playground/QUICKSTART.md` — replace platform-specific setup instructions
- [ ] `playground/HANDOFF.md` — adapt to your engineering team's reality

Total time: roughly half a day for the mechanical bits, plus an afternoon for the guidelines content.
