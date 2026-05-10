# CLAUDE.md

This project is a public launch/showcase for an installable Codex skill:

```text
design-md-for-codex
```

The promise:

```text
Make Codex remember your taste.
DESIGN.md is the memory. This skill is the habit.
```

## Project Context

This repo teaches agents to read `DESIGN.md` before frontend UI work.

The install path is:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

The skill package lives at:

```text
skills/design-system/
```

The public site lives at:

```text
index.html
landing.css
```

The launch/proof assets live at:

```text
assets/demo-video.mp4
assets/demo-video-thumbnail.png
assets/share-before-after.png
assets/social-card.png
assets/repo-banner.png
assets/proof/
```

## How To Help

When editing this repo:

1. Preserve the simple install flow.
2. Keep the story useful and human, not corporate.
3. Keep Dan O'Leary credited.
4. Keep the package structure stable.
5. Keep public docs free of private/internal launch details.
6. Prefer proof over claims.
7. Test before pushing.

## Design Taste

Use `skills/design-system/references/DESIGN.md` as the visual source of truth.

The intended feel is:

- x/Grok-like dark restraint
- Claude-like warm editorial paper
- Linear-like precision
- one terracotta accent
- compact, useful, high-signal surfaces

Avoid generic AI startup visuals, blue-purple gradients, glassmorphism, decorative blobs, and card spam.

## Copy Taste

Best public posture:

```text
I made this because Codex is fast, but taste drifts.
Put the taste in DESIGN.md.
Put the habit in a skill.
```

Keep phrases like:

```text
Before: generic soup. After: governed workbench.
```

If the user provides a rough human draft, improve rhythm and clarity while preserving voice.

## Validation

Use these from repo root:

```powershell
.\qa\ci-check.ps1
.\qa\smoke-test.ps1
npm run visual-qa
python $env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py skills\design-system
git diff --check
```

Generated screenshots and visual QA output go under `output/`, which is ignored.

## Launch Files

- `LAUNCH.md`: launch packet and channel copy.
- `LAUNCH-TRACKER.md`: channel tracker and feedback queue.
- `SHARE.md`: distribution targets.
- `MAINTAINING.md` and `MAINTENANCE-CHECKLIST.md`: keeping current as Codex changes.
- `TROUBLESHOOTING.md` and `FAQ.md`: cold-user support.

If asked to launch or polish launch copy, use Dan's local `$launch-operator` skill when available.

