# QA

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

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
- Launch images and sharing docs exist.
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
   - no Papyrus/fantasy type or loud gradient
   - governed generated imagery
   - compact controls
   - no radius above 8px

## Saved Proof Run

The repo includes one captured proof run:

- `fixture/index.html`: intentionally loud Papyrus-style generic starting point.
- `fixture/after.html`: output from a Codex run using `$design-system`, now with generated workbench imagery.
- `fixture/codex-result.md`: final Codex response.
- `../assets/proof/fixture-before.png`: before screenshot.
- `../assets/proof/fixture-after.png`: after screenshot.
- `../assets/proof/ai-workbench-wide.png`: generated workbench image used in the after proof.
- `../assets/proof/ai-workbench-detail.png`: generated detail image used in the after proof.

## Visual QA

Run from the repo root after landing page, image, or copy-button changes:

```powershell
npm install
npm run visual-qa
```

The script starts a local static server, opens the page in Playwright Chromium, and checks:

- widths `320`, `390`, `768`, `1024`, and `1440`
- no horizontal overflow
- no broken images
- copy button status changes after click

Screenshots and metrics are written to `output/browser-qa/`.

## Launch Images

Regenerate the sharing kit after proof screenshots or launch copy change:

```powershell
python .\qa\generate-launch-assets.py
```

The generated files are:

- `../assets/social-card.png`
- `../assets/repo-banner.png`
- `../assets/share-before-after.png`
