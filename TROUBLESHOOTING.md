# Troubleshooting

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

Start here when the skill does not feel magical yet.

## The Skill Does Not Appear

1. Paste the install prompt into Codex:

   ```text
   Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
   ```

2. Restart Codex.
3. Try:

   ```text
   $design-system Make this page follow DESIGN.md.
   ```

If it still does not appear, run `.\qa\smoke-test.ps1` from this repo. That confirms the public GitHub skill folder downloads and validates.

## Codex Did Not Read DESIGN.md

Make sure your repo has a `DESIGN.md` at the root. The skill looks there first, then checks nearby design/documentation folders.

Try a more explicit prompt:

```text
$design-system Read DESIGN.md first, then make this page follow its colors, spacing, typography, components, and no-go zones.
```

In the response, look for the design file Codex read and the rules it applied.

## The GitHub Install URL Fails

Check that the URL points to the skill folder, not the repo root:

```text
https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

The folder should contain:

```text
SKILL.md
agents/openai.yaml
references/DESIGN.md
references/theme.css
references/tokens.json
```

## DESIGN.md Lint Fails

Run:

```powershell
npx @google/design.md lint skills/design-system/references/DESIGN.md
```

Common fixes:

- Make sure referenced token names exist.
- Keep color values as valid hex colors.
- Keep YAML indentation consistent.
- Use quoted values when a token reference contains braces.

## The Page Looks Broken On Mobile

Run the visual QA:

```powershell
npm install
npm run visual-qa
```

Screenshots and metrics are written to `output/browser-qa/`.

The check covers `320`, `390`, `768`, `1024`, and `1440` widths. It fails on horizontal overflow, broken images, or copy-button failure.

If Playwright says the browser is missing, run:

```powershell
npx playwright install chromium
```

## The Skill Works But The Design Is Not Yours

That is expected. The bundled `DESIGN.md` is a starter.

Replace `skills/design-system/references/DESIGN.md` or add your own repo-root `DESIGN.md`. Codex should treat your closest repo design file as the source of truth.

## Good Bug Report

Open an issue with:

- Codex version, if known.
- Operating system.
- Install prompt used.
- Whether Codex was restarted.
- Where `DESIGN.md` lives.
- The exact command or prompt that failed.
- Screenshot or terminal output if useful.
