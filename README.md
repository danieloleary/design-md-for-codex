# design-md-for-codex

A tiny Codex skill that makes the agent read `DESIGN.md` before frontend UI work.

Use it when you are tired of repeating the same color, spacing, typography, component, and "make it less generic" feedback.

## Quick Start

```text
$skill-installer install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

Then:

1. Restart Codex.
2. Add `DESIGN.md` at the root of your repo.
3. Ask Codex for UI work.

Example prompt:

```text
$design-system Make this page follow DESIGN.md.
```

## What It Does

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

## Validate

```powershell
npx @google/design.md lint skills/design-system/references/DESIGN.md
Get-Content skills/design-system/references/tokens.json | ConvertFrom-Json
```

## Why Dan Made It

Codex is better when it feels like it has been paying attention.

This is a small habit for keeping UI taste from disappearing between prompts. Fork it, tune it, and make it yours.
