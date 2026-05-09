# QA

This folder proves the showcase is advertising a real Codex skill, not just a pretty idea.

## Daily CI Check

GitHub Actions runs this every day and on each push:

```powershell
.\qa\ci-check.ps1
```

It is cloud-friendly and does not assume the runner has the Codex desktop app's local system-skill folders. It checks public URLs, required files, DESIGN.md linting, token parsing, install prompt text, and encoding artifacts.

## Smoke Test

Run from the repo root:

```powershell
.\qa\smoke-test.ps1
```

Prerequisites:

- PowerShell
- Python
- Node/npm with `npx`
- Network access
- Local Codex system skills, including `skill-installer` and `skill-creator`

The script checks:

- The public GitHub skill path downloads into a temp folder.
- Required skill files exist.
- `SKILL.md` passes Codex skill validation when the local validator is available.
- The bundled `DESIGN.md` files pass `@google/design.md` lint.
- `tokens.json` parses.
- Public Pages and GitHub links are reachable.

## Manual Codex Test

1. Copy this prompt into Codex:

   ```text
   Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
   ```

2. Restart Codex.
3. Open this repo's `qa/fixture` folder in Codex.
4. Ask:

   ```text
   $design-system Make this page follow DESIGN.md.
   ```

5. Confirm Codex read or applied `DESIGN.md` by checking its response, diff, or rendered UI:
   - dark command surface
   - terracotta primary action
   - no blue gradient
   - compact controls
   - no radius above 8px
