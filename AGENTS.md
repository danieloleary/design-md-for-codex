# AGENTS.md

This repo is `design-md-for-codex`: a public showcase and installable Codex skill package.

Core message:

```text
Make Codex remember your taste.
DESIGN.md is the memory. This skill is the habit.
```

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

## What Matters

- Primary repo: https://github.com/danieloleary/design-md-for-codex
- Live site: https://danieloleary.github.io/design-md-for-codex/
- Release: https://github.com/danieloleary/design-md-for-codex/releases/tag/v0.1.4
- Install prompt:

  ```text
  Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
  ```

- Demo video: `assets/demo-video.mp4`
- Proof image: `assets/share-before-after.png`
- Social card: `assets/social-card.png`

## Skill Package

Keep this structure intact:

```text
skills/design-system/
  SKILL.md
  agents/openai.yaml
  references/
    DESIGN.md
    theme.css
    tokens.json
```

The skill should make Codex read `DESIGN.md` before frontend UI work and apply documented colors, typography, spacing, components, accessibility rules, and no-go zones.

## Design Direction

When editing the landing page or assets, use the repo's own design system:

- dark command-surface restraint
- warm paper/ivory support sections
- terracotta as the main accent
- tight borders before shadows
- simple responsive layouts
- no generic SaaS blue, blobs, glass, or overproduced AI decoration

If changing UI, read `skills/design-system/references/DESIGN.md` first.

## Launch Voice

Public copy should sound like a builder sharing something useful:

- warm, sharp, practical, a little opinionated
- no corporate launch fluff
- no overclaiming one-click magic unless tested
- preserve Dan's human voice when editing drafts
- credit Dan O'Leary

Useful line:

```text
Before: generic soup. After: governed workbench.
```

## Public / Private Boundary

Keep private operators, internal helper names, unpublished automation details, and personal execution notes out of public files.

Before publishing public docs, search for private/internal leakage.

## QA Commands

Run the relevant checks before pushing:

```powershell
.\qa\ci-check.ps1
.\qa\smoke-test.ps1
npm run visual-qa
python $env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py skills\design-system
git diff --check
```

Use `npm run visual-qa` after landing page, image, video, or copy-button changes. It checks `320`, `390`, `768`, `1024`, and `1440`.

Regenerate launch media:

```powershell
python .\qa\generate-launch-assets.py
python .\qa\generate-demo-video.py
```

## Launch Docs

- `LAUNCH.md`: copy, launch packet, and channel posts.
- `LAUNCH-TRACKER.md`: release status, channels, replies, metrics.
- `SHARE.md`: where to share and what to ask by channel.
- `MAINTAINING.md`: daily drift checks.
- `MAINTENANCE-CHECKLIST.md`: weekly/monthly upkeep.
- `TROUBLESHOOTING.md`: cold-user install and validation help.
- `FAQ.md`: short public answers.

Dan also has a local `$launch-operator` skill for turning rough launch drafts into channel-ready posts, proof assets, QA checks, and follow-up tracking.

