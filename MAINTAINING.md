# Maintaining This Skill

Codex and the surrounding skill ecosystem move quickly, so this repo has two update loops.

## Daily Drift Check

The GitHub Action in `.github/workflows/stay-current.yml` runs every day and on every push. It checks that:

- The public install prompt still points at a real skill folder.
- The GitHub Pages showcase and important public files return `200`.
- `DESIGN.md` files pass the latest `@google/design.md` linter.
- `tokens.json` parses.
- The page avoids common encoding artifacts.
- Required skill, example, and QA files are present.

If the daily job fails, treat it as a maintenance signal. Usually the fix will be one of:

- Update the install wording if Codex changes skill-installer phrasing.
- Update `skills/design-system/SKILL.md` if Codex skill conventions change.
- Update `skills/design-system/references/DESIGN.md` if the DESIGN.md validator gets stricter.
- Update the showcase links if GitHub Pages behavior or repo paths change.

## Manual Release Check

Before sharing a new release, run:

```powershell
.\qa\smoke-test.ps1
```

That script uses the local Codex system skill-installer helper, installs the public GitHub skill into a temp folder, validates the package when the local validator exists, lints the design files, parses tokens, and prints the manual Codex QA prompt.

Then run the human fixture:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

Restart Codex, open `qa/fixture`, and ask:

```text
$design-system Make this page follow DESIGN.md.
```

The result should move the fixture away from its intentionally generic blue-gradient starting point and toward the local `DESIGN.md` rules.
