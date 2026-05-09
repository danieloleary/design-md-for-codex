# Maintenance Checklist

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

Codex changes fast. This repo should keep proving the same thing: the skill installs, `DESIGN.md` lints, the showcase links work, and the workflow stays simple for humans.

## Weekly

- Check the latest `Stay current` GitHub Action.
- Run `.\qa\ci-check.ps1`.
- Run `.\qa\smoke-test.ps1`.
- Run `npm run visual-qa` after landing page, image, or copy-button changes.
- Confirm the live site loads: https://danieloleary.github.io/design-md-for-codex/
- Confirm the install prompt still works:

  ```text
  Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
  ```

- Search public files for private/internal launch notes before posting. Keep internal helper names, private execution notes, and unpublished automation details out of public docs.

  ```powershell
  rg -n "internal-only|private-helper|launch desk" README.md index.html LAUNCH.md LAUNCH-TRACKER.md SHARE.md
  ```

## Monthly

- Re-read `skills/design-system/SKILL.md` against current Codex skill behavior.
- Re-lint every `DESIGN.md` file with the latest validator.
- Review install instructions in `README.md`, `index.html`, `LAUNCH.md`, and `SHARE.md`.
- Check that GitHub Pages still serves these public files:
  - `skills/design-system/references/DESIGN.md`
  - `assets/social-card.png`
  - `assets/share-before-after.png`
  - `LAUNCH.md`
  - `SHARE.md`
- Refresh `LAUNCH-TRACKER.md` with new feedback, repeated questions, bugs, and useful examples.

## Before A New Release

- Run:

  ```powershell
  .\qa\ci-check.ps1
  .\qa\smoke-test.ps1
  npm run visual-qa
  python $env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py skills\design-system
  git diff --check
  ```

- Browser-check the site at `320`, `390`, `768`, `1024`, and `1440`.
- Confirm the copy button works.
- Confirm no horizontal overflow.
- Confirm no broken images.
- Confirm GitHub Actions and Pages are green after push.
- Cut a release only when the change improves install reliability, skill behavior, docs clarity, examples, or proof.

## When Codex Changes

If `$skill-installer`, skill discovery, skill front matter, or Codex restart behavior changes:

- Update the install prompt everywhere.
- Update `qa/smoke-test.ps1`.
- Update `qa/ci-check.ps1`.
- Update `README.md` and `index.html`.
- Add a short note to the release notes.
- Prefer plain, tested instructions over one-click claims unless the one-click path is actually verified.

## What To Improve Next

- Add a React or Next.js example repo.
- Add a Mac/Linux smoke-test note if the install path differs.
- Add a short demo video or GIF once the workflow is stable enough to record cleanly.
- Collect real `DESIGN.md` examples from friends and builders.
- Submit to skill directories only after the install path has stayed green for a few daily checks.
