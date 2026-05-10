# QA

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

Proof that the showcase points at a real skill.

## Daily CI Check

GitHub Actions runs this every day and on each push:

```powershell
.\qa\ci-check.ps1
```

It runs in the cloud and does not assume the Codex desktop app exists. It checks public URLs, required files, DESIGN.md linting, token parsing, install prompt text, and encoding artifacts.

The wrapper is split by concern:

- `check-public-contract.ps1`: contract fields, copy surfaces, and repeated install URLs.
- `check-local-assets.ps1`: required files, local links, images, encoding, and package metadata.
- `check-design-artifacts.ps1`: DESIGN.md linting, token parsing, and saved proof verification.
- `check-public-drift.ps1`: live GitHub Pages, GitHub URLs, and public archive download.

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
- React and Next starter examples include DESIGN.md and repo-local skill files.
- `SKILL.md` passes Codex skill validation when the local validator is available.
- The bundled `DESIGN.md` files pass `@google/design.md` lint.
- `tokens.json` parses.
- The saved before/after fixture matches the expected DESIGN.md invariants.
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

## Framework Examples

The React and Next examples are intentionally small. To verify they still run:

```powershell
cd examples\react-vite
npm install
npm run build

cd ..\next-app
npm install
npm run build
```

## Saved Proof Run

The repo includes one captured proof run:

- `fixture/index.html`: intentionally loud Papyrus-style generic starting point.
- `fixture/after.html`: output from a Codex run using `$design-system`, now with generated workbench imagery.
- `fixture/codex-result.md`: final Codex response.
- `../assets/proof/fixture-before.png`: before screenshot.
- `../assets/proof/fixture-after.png`: after screenshot.
- `../assets/proof/ai-workbench-wide.png`: generated workbench image used in the after proof.
- `../assets/proof/ai-workbench-detail.png`: generated detail image used in the after proof.

Verify that proof directly:

```powershell
npm run fixture-qa
```

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

## Demo Video

Regenerate the launch demo video:

```powershell
python .\qa\generate-demo-video.py
```

The generated files are:

- `../assets/demo-video.mp4`
- `../assets/demo-video-thumbnail.png`
- `output/launch-tonight/design-md-for-codex-demo.gif`
