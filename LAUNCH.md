# Launch Plan

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

## Launch Packet

- Repo: https://github.com/danieloleary/design-md-for-codex
- Live site: https://danieloleary.github.io/design-md-for-codex/
- Install prompt:

  ```text
  Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
  ```

- One-line pitch: Make Codex remember your taste. `DESIGN.md` is the memory. This skill is the habit.
- Three-line pitch: Codex can build fast, but UI taste drifts without a source of truth. Put the rules in `DESIGN.md`. Install this skill so Codex reads those rules before building, reviewing, or refactoring UI.
- Hero asset: `assets/social-card.png`
- Proof asset: `assets/share-before-after.png`
- Demo video: `assets/demo-video.mp4`
- Demo video thumbnail: `assets/demo-video-thumbnail.png`
- Repo banner: `assets/repo-banner.png`
- Best proof link: `qa/fixture/codex-result.md`
- Maintenance proof: `MAINTENANCE-CHECKLIST.md`

## Launch Calendar

### Day 0: Ship The Useful Thing

- Run `.\qa\ci-check.ps1` and `.\qa\smoke-test.ps1`.
- Confirm GitHub Actions are green and Pages is live.
- Post on X with `assets/share-before-after.png`.
- Publish the GitHub release notes.
- Send the short friend DM to 5-10 builders who will give real feedback.
- Track every reply in `LAUNCH-TRACKER.md`.

### Day 1: Explain The Habit

- Post the LinkedIn version with the repo link and install prompt.
- Share in OpenAI Forum or Discord with a direct ask for Codex skill feedback.
- Reply to every install question with the same simple path: install, restart, add `DESIGN.md`, run `$design-system`.
- Turn confusing replies into README fixes.

### Day 3: Show The Proof

- Share the before/after asset again with a shorter caption.
- Ask for examples from people who tried it in real repos.
- Open GitHub issues for bugs, install friction, or unclear docs.
- Add one small improvement based on the strongest repeated question.

### Day 7: Make It A Community Object

- Submit to relevant skill and DESIGN.md directories from `SHARE.md`.
- Ask for one contributor to add a framework-specific example.
- Cut a follow-up release only if there is a real fix or useful example.
- Update `LAUNCH-TRACKER.md` with what worked, what confused people, and what to build next.

## Launch Checklist

- Confirm `.\qa\ci-check.ps1` and `.\qa\smoke-test.ps1` pass.
- Confirm GitHub Pages shows the latest before/after proof.
- Confirm `MAINTENANCE-CHECKLIST.md` still matches the workflow.
- Attach `assets/social-card.png` to X and LinkedIn.
- Attach `assets/share-before-after.png` when the post is about proof.
- Attach `assets/demo-video.mp4` when the post should feel more alive than a screenshot.
- Link to the repo and the live showcase.
- Pin the install prompt near the top of every long post.
- Use `LAUNCH-TRACKER.md` to track channels, replies, follow-ups, and launch metrics.
- Keep private helpers and internal execution notes out of the public repo.

## One-Liner

Make Codex remember your taste. `DESIGN.md` is the memory. This skill is the habit.

## X Post

I made a tiny Codex skill for people tired of re-prompting taste.

Install one skill. Add `DESIGN.md`. Now Codex starts UI work from your design rules.

Before: Papyrus soup.
After: governed workbench.

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

## X Video Post

I made a tiny Codex skill that makes UI taste stick.

`DESIGN.md` is the memory.
The skill is the habit.

Before: generic soup.
After: governed workbench.

Repo:
https://github.com/danieloleary/design-md-for-codex

Attach:
`assets/demo-video.mp4`

## LinkedIn Post

I made a small Codex skill that solves a very familiar AI UI problem: taste drift.

Codex can build fast, but without a source of truth it can invent new spacing, colors, button shapes, and layout patterns screen by screen.

The fix is simple:

1. Put your design taste in `DESIGN.md`.
2. Install this skill.
3. Ask Codex to build, review, or refactor UI.

`DESIGN.md` is the memory. This skill is the habit.

Repo:
https://github.com/danieloleary/design-md-for-codex

Install prompt:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

## OpenAI Forum / Discord Post

I built a tiny Codex skill around `DESIGN.md`.

The goal: stop re-prompting visual taste every time Codex touches UI. The skill tells Codex to find and read `DESIGN.md` first, apply the documented colors/type/spacing/component rules, and verify desktop/mobile when UI changes.

Install:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

Repo:
https://github.com/danieloleary/design-md-for-codex

Would love feedback from anyone building UI with Codex, agent skills, or DESIGN.md files.

## GitHub Release Copy

`design-md-for-codex` is ready to try.

It packages one Codex skill:

```text
skills/design-system
```

The skill makes Codex read `DESIGN.md` before UI work, then apply the repo's colors, type, spacing, component rules, accessibility notes, and no-go zones.

This release includes:

- GitHub install path.
- Starter `DESIGN.md`, CSS theme, and design tokens.
- Minimal repo example.
- QA fixture with before/after proof.
- Daily drift check for Codex and DESIGN.md changes.
- Launch kit and sharing copy.

Install:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

## Common Replies

### What is DESIGN.md?

`DESIGN.md` is a design system file that lives in the repo. It gives agents the rules they need to build UI without guessing: colors, type, spacing, components, accessibility, voice, and the stuff not to do.

### Why a skill?

Because rules only help if Codex reads them. The skill turns "please remember my taste" into a repeatable habit: find `DESIGN.md`, read it first, apply it, and verify the result.

### Is this Dan's taste or mine?

The starter has Dan's default taste: dark command surfaces, warm paper sections, terracotta accent, tight borders, no generic UI soup. Replace the `DESIGN.md` with your own taste and keep the habit.

### Does it keep up with Codex changes?

The repo has a daily GitHub Action plus local smoke tests. See `MAINTAINING.md` and `MAINTENANCE-CHECKLIST.md`.

## Friend DM

I made a little Codex skill you might actually use.

It makes Codex read `DESIGN.md` before touching UI, so you stop re-explaining colors, spacing, and "make it less generic" every time.

Paste this into Codex:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

Then restart Codex and try:

```text
$design-system Make this page follow DESIGN.md.
```

## Email To Builder Friends

Subject: Tiny Codex skill for keeping UI taste from drifting

Hey,

I made a small Codex skill that makes the agent read `DESIGN.md` before touching UI.

The idea is simple: put design taste in the repo, then make Codex build from that source of truth instead of re-prompting the same preferences every session.

Repo:
https://github.com/danieloleary/design-md-for-codex

Install:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

If you try it, I would love the sharpest feedback you have.

Dan

## Release Notes

Launch-ready pass:

- Rewrote public copy around `Make Codex remember your taste`.
- Added Dan O'Leary credit.
- Added launch and sharing docs.
- Added social/share image kit.
- Added a demo video and thumbnail.
- Kept the real before/after proof as the credibility anchor.
- Verified install path, DESIGN.md linting, skill validation, responsive layout, and live Pages assets.
