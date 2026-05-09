# design-md-for-codex

A Codex skill that makes the agent read `DESIGN.md` before frontend UI work.

Use it when you want Codex to follow your product's colors, typography, spacing, components, accessibility rules, and visual no-go zones without re-prompting them every time.

## TL;DR

- Codex can build UI quickly.
- Fast UI can still drift from your product.
- `DESIGN.md` gives your design system a place to live in the repo.
- This skill makes reading that file the default first step.
- Result: fewer mystery colors, random shadows, soft cards, and "make it less generic" loops.

## Why

You ask Codex for a dashboard. It ships something decent.

Then you ask for a settings page, and suddenly the spacing is different, the cards got puffier, the accent color wandered off, and the whole thing feels like it came from a different product.

That is not because Codex cannot design. It is because your design system is living in chat instead of the repo.

This skill gives Codex a repeatable first step: read the repo's `DESIGN.md`, then make UI decisions from that file.

## What the skill does

The `design-system` skill tells Codex to:

1. Find the repo's `DESIGN.md`.
2. Treat it as the visual source of truth.
3. Use documented colors, type, spacing, components, motion, and accessibility rules.
4. Avoid inventing a new visual system when the repo already has one.
5. Check rendered UI at desktop and mobile sizes when frontend code changes.

## Who this is for

- Teams and solo builders who want Codex UI work to stay consistent across screens.
- Designers and design engineers who want agents to respect product rules.
- People building apps with Codex who are tired of re-explaining the same UI taste.
- Anyone making small, useful skills that friends and the community can reuse.

## What is included

```text
skills/design-system/
  SKILL.md
  agents/openai.yaml
  references/
    DESIGN.md
    theme.css
    tokens.json
```

The bundled `DESIGN.md` is an example, not a prison. It starts with a warm, restrained product direction: editorial light surfaces, precise dark mode, one terracotta accent, borders before shadows, and no generic SaaS soup.

Replace it with your own taste.

## Install

### Repo-local

Copy this into your project:

```text
.agents/
  skills/
    design-system/
      SKILL.md
      agents/openai.yaml
```

Then put `DESIGN.md` at the root of your repo.

### From GitHub

After publishing this repo, install it with:

```text
$skill-installer install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

Restart Codex after installing a new skill.

## Use it

```text
$design-system Make this page follow DESIGN.md.
```

Or just ask for UI work and let Codex choose the skill when the request matches.

## Customize

- `DESIGN.md`: your actual taste, tokens, components, and design rules.
- `SKILL.md`: the workflow Codex should follow.
- `agents/openai.yaml`: the display name, short description, and default prompt.
- `theme.css` and `tokens.json`: optional starter artifacts for implementation.

## Validate

```powershell
npx @google/design.md lint skills/design-system/references/DESIGN.md
Get-Content skills/design-system/references/tokens.json | ConvertFrom-Json
```

## Why Dan made it

I made this because I kept wanting Codex to build like it had been paying attention.

Not perfect. Not magic. Just a small habit that keeps product taste from disappearing between prompts.

If it helps you, fork it, tune the `DESIGN.md`, and make something sharper for your own friends.
