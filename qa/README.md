# QA

Proof that the showcase points at a real skill.

## Daily CI Check

GitHub Actions runs this every day and on each push:

```powershell
.\qa\ci-check.ps1
```

It runs in the cloud and does not assume the Codex desktop app exists. It checks public URLs, required files, DESIGN.md linting, token parsing, install prompt text, and encoding artifacts.

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

It checks:

- The public GitHub skill path downloads into a temp folder.
- Required skill files exist.
- `SKILL.md` passes Codex skill validation when the local validator is available.
- The bundled `DESIGN.md` files pass `@google/design.md` lint.
- `tokens.json` parses.
- Public Pages and GitHub links are reachable.

## Manual Codex Test

1. Paste this into Codex:

   ```text
   Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
   ```

2. Restart Codex.
3. Open this repo's `qa/fixture` folder in Codex.
4. Ask:

   ```text
   $design-system Make this page follow DESIGN.md.
   ```

5. Confirm Codex read or applied `DESIGN.md` by checking the response, diff, or rendered UI:
   - dark command surface
   - terracotta primary action
   - no blue gradient
   - compact controls
   - no radius above 8px

## Saved Proof Run

The repo includes one captured proof run:

- `fixture/index.html`: intentionally loud generic starting point.
- `fixture/after.html`: output from a Codex run using `$design-system`.
- `fixture/codex-result.md`: final Codex response.
- `../assets/proof/fixture-before.png`: before screenshot.
- `../assets/proof/fixture-after.png`: after screenshot.
