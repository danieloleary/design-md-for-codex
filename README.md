# design-md-for-codex

A tiny Codex skill that makes the agent read `DESIGN.md` before frontend UI work.

Use it when you are tired of repeating the same color, spacing, typography, component, and "make it less generic" feedback.

## Quick Start

Paste this into Codex:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

Then:

1. Restart Codex.
2. Add `DESIGN.md` at the root of your repo.
3. Ask Codex for UI work.

Example prompt:

```text
$design-system Make this page follow DESIGN.md.
```

## Why DESIGN.md Rocks

`DESIGN.md` gives Codex a design source of truth that lives in the repo. Instead of re-explaining colors, typography, spacing, components, accessibility, voice, and visual no-go zones in every prompt, you write them once and let the skill make reading that file the default habit.

## What The Skill Does

The `design-system` skill tells Codex to:

1. Find the repo's `DESIGN.md`.
2. Treat it as the visual source of truth.
3. Use documented colors, type, spacing, components, motion, and accessibility rules.
4. Avoid inventing a new visual system when the repo already has one.
5. Check rendered UI at desktop and mobile sizes when frontend code changes.

## What Ships

```text
skills/design-system/
  SKILL.md
  agents/openai.yaml
  references/
    DESIGN.md
    theme.css
    tokens.json
```

The bundled `DESIGN.md` is a starter, not a rulebook. Dan's default taste leans dark-first and high-signal: monochrome command surfaces, warm editorial support surfaces, one terracotta accent, clean borders, and no generic UI soup.

Replace it with your own taste.

## Test It Yourself

1. Copy the install prompt into Codex.
2. Restart Codex.
3. Add `DESIGN.md` to a repo.
4. Run:
   ```text
   $design-system Make this page follow DESIGN.md.
   ```
5. Confirm Codex read or applied `DESIGN.md` by checking its response, diff, or rendered UI.

This repo also includes a smoke test:

```powershell
.\qa\smoke-test.ps1
```

Smoke test prerequisites: PowerShell, Python, Node/npm with `npx`, network access, and the local Codex system skills that ship with recent Codex builds.

## Staying Current

Codex and skill conventions can move fast, so this repo includes a daily GitHub Actions drift check:

```powershell
.\qa\ci-check.ps1
```

It verifies the public install path, GitHub Pages links, DESIGN.md linting with the latest validator, token parsing, required files, and common encoding problems. See `MAINTAINING.md` for the update loop.

## Repo-Local Install

Copy the skill into your project:

```text
.agents/
  skills/
    design-system/
      SKILL.md
      agents/openai.yaml
      references/
        DESIGN.md
```

Then add your project-specific `DESIGN.md` at the repo root.

## Customize

- `DESIGN.md`: your real design rules and taste.
- `SKILL.md`: the workflow Codex should follow.
- `agents/openai.yaml`: display metadata.
- `theme.css` and `tokens.json`: optional starter tokens.

## Why Dan Made It

Codex is better when it feels like it has been paying attention.

This is a small habit for keeping UI taste from disappearing between prompts. Fork it, tune it, and make it yours.
