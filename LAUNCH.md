# Launch Plan

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

Ship target: later today, May 11, 2026.

## Launch Packet

- Repo: https://github.com/danieloleary/design-md-for-codex
- Live site: https://danieloleary.github.io/design-md-for-codex/
- Demo video: https://danieloleary.github.io/design-md-for-codex/assets/demo-video.mp4
- Primary asset: `assets/share-before-after.png`
- Backup asset: `assets/social-card.png`
- Repo banner: `assets/repo-banner.png`
- Best proof: `qa/fixture/codex-result.md`
- Framework examples:
  - `examples/react-vite`
  - `examples/next-app`
- Feedback path: `FEEDBACK.md`
- Install prompt:

  ```text
  Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
  ```

## Core Story

One-line pitch:

```text
Make Codex remember your taste. DESIGN.md is the memory. This skill is the habit.
```

Three-line pitch:

```text
Codex can build fast, but UI taste drifts without a source of truth.
Put the rules in DESIGN.md.
Install this skill so Codex reads those rules before building, reviewing, or refactoring UI.
```

Human version:

```text
I made this because I got tired of telling Codex the same design taste over and over.

DESIGN.md puts taste in the repo.
The skill makes Codex read it first.

Less re-prompting. Less generic soup. More UI that feels like it belongs to the project.
```

## Ship Today Checklist

### T-90 Minutes: Verify

- Run `.\qa\ci-check.ps1`.
- Run `.\qa\smoke-test.ps1`.
- Run `npm run visual-qa`.
- Confirm GitHub Actions are green.
- Confirm Pages is live.
- Open the live site once on desktop and phone.
- Confirm these links work:
  - https://github.com/danieloleary/design-md-for-codex
  - https://danieloleary.github.io/design-md-for-codex/
  - https://github.com/danieloleary/design-md-for-codex/tree/main/examples/react-vite
  - https://github.com/danieloleary/design-md-for-codex/tree/main/examples/next-app

### T-45 Minutes: Stage

- Attach `assets/share-before-after.png` to the first X post.
- Keep `assets/demo-video.mp4` ready for the second X post or reply.
- Keep the live site and repo links open.
- Copy the X post, LinkedIn post, and friend DM from this file.
- Decide whether to publish a GitHub release today or after first feedback.

### T-0: Post

Recommended order:

1. X launch post.
2. Reply to your own X post with install prompt and demo link.
3. Send 5-10 friend DMs.
4. Post OpenAI Forum or Discord feedback ask.
5. LinkedIn post later, after the X post has a little air.

### T+30 Minutes: Work The Replies

- Reply fast to install confusion.
- Ask anyone technical to open an issue or PR.
- Track useful replies in `LAUNCH-TRACKER.md`.
- Turn repeated questions into README or FAQ changes tonight.

### T+24 Hours: Follow Proof

- Share the demo video or before/after again.
- Mention the React and Next examples.
- Ask for one real PR: better DESIGN.md, better example, or sharper docs.

## What To Ask For

Use GitHub issues for:

- install bugs
- skill discovery problems
- broken links
- confusing docs
- DESIGN.md lint surprises

Use pull requests for:

- better examples
- better `DESIGN.md` starters
- framework notes
- sharper copy
- compatibility fixes

Best ask:

```text
Try it on one real screen. If Codex still drifts, show me the DESIGN.md, the prompt, and the diff. Issues for bugs, PRs for fixes.
```

## X Launch Post

Attach: `assets/share-before-after.png`

```text
I made a tiny Codex skill for a problem I keep hitting: taste drift.

Codex can build fast. But without a source of truth it starts inventing spacing, colors, button shapes, and layout patterns screen by screen.

So I made DESIGN.md the memory.
And this skill the habit.

Install one skill. Add DESIGN.md. Ask Codex to build, review, or refactor UI from your rules.

Repo:
https://github.com/danieloleary/design-md-for-codex

Made for friends, builders, and people tired of generic AI UI.
```

Reply to your own X post:

```text
Install prompt:

Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system

Then restart Codex and try:

$design-system Make this page follow DESIGN.md.

Live demo:
https://danieloleary.github.io/design-md-for-codex/
```

## Short X Alt

Attach: `assets/social-card.png`

```text
Make Codex remember your taste.

DESIGN.md is the memory.
This tiny skill is the habit.

Repo:
https://github.com/danieloleary/design-md-for-codex
```

## X Video Follow-Up

Attach: `assets/demo-video.mp4`

```text
The whole trick:

1. Put design rules in DESIGN.md
2. Install the Codex skill
3. Ask for a UI pass

Before: generic soup.
After: governed workbench.

Demo + repo:
https://danieloleary.github.io/design-md-for-codex/
```

## LinkedIn Post

Attach: `assets/share-before-after.png`

```text
I made a small Codex skill for a problem I keep running into: taste drift.

AI coding agents are fast, but without a source of truth they can invent a new visual system every screen: spacing, colors, button shapes, cards, gradients, all of it.

The fix is simple:

1. Put your design taste in DESIGN.md.
2. Install this Codex skill.
3. Ask Codex to build, review, or refactor UI from those rules.

DESIGN.md is the memory. The skill is the habit.

The repo includes:
- the skill package
- a starter DESIGN.md
- React and Next examples
- before/after proof
- a smoke test and daily checks

Repo:
https://github.com/danieloleary/design-md-for-codex

Live demo:
https://danieloleary.github.io/design-md-for-codex/

Made for friends, builders, and people tired of generic AI UI.
```

## OpenAI Forum / Discord Post

```text
I built a tiny Codex skill around DESIGN.md and would love feedback from people using Codex for UI work.

Goal: stop re-prompting visual taste. The skill makes Codex find and read DESIGN.md before building, reviewing, or refactoring UI, then apply the documented colors/type/spacing/component/accessibility rules.

Install:

Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system

Repo:
https://github.com/danieloleary/design-md-for-codex

Live demo:
https://danieloleary.github.io/design-md-for-codex/

I am especially looking for:
- does the skill match current Codex skill best practices?
- does install/restart behavior feel clear?
- what would make the React or Next examples more useful?
- where does Codex still drift even after reading DESIGN.md?

Issues for bugs. PRs very welcome for better examples, better DESIGN.md starters, or compatibility notes.
```

## Friend DM

```text
I made a little Codex skill I think you might actually use.

It makes Codex read DESIGN.md before touching UI, so you stop re-explaining colors, spacing, and "make it less generic" every time.

Repo:
https://github.com/danieloleary/design-md-for-codex

Would love one sharp test: try it on one screen and send me the diff. If it works, amazing. If it drifts, even better feedback.
```

## Email To Builder Friends

Subject:

```text
Tiny Codex skill for keeping UI taste from drifting
```

Body:

```text
Hey,

I made a small Codex skill that makes the agent read DESIGN.md before touching UI.

The idea is simple: put design taste in the repo, then make Codex build from that source of truth instead of re-prompting the same preferences every session.

Repo:
https://github.com/danieloleary/design-md-for-codex

Live demo:
https://danieloleary.github.io/design-md-for-codex/

Install:

Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system

If you try it, I would love the sharpest feedback you have. Best possible test: use it on one real screen and send me the diff.

Dan
```

## GitHub Release Copy

Title:

```text
Design.md for Codex: same-day launch candidate
```

Body:

```text
This release packages a tiny Codex skill that makes agents read DESIGN.md before UI work.

The skill helps Codex:
- find the repo design source
- apply colors, type, spacing, components, accessibility rules, and no-go zones
- avoid inventing a new visual system every screen
- verify desktop and mobile after UI changes

This launch pass includes:
- GitHub install path
- starter DESIGN.md, theme.css, and tokens.json
- minimal repo example
- React + Vite example
- Next app-router example
- before/after proof fixture
- demo video
- smoke test, visual QA, and daily drift checks

Install:

Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

## Common Replies

### What is DESIGN.md?

`DESIGN.md` is a design system file that lives in the repo. It gives agents the rules they need to build UI without guessing: colors, type, spacing, components, accessibility, voice, and the stuff not to do.

### Why a skill?

Because rules only help if Codex reads them. The skill turns "please remember my taste" into a repeatable habit: find `DESIGN.md`, read it first, apply it, and verify the result.

### Is this Dan's taste or mine?

The starter has Dan's default taste: dark command surfaces, warm paper sections, terracotta accent, tight borders, no generic UI soup. Replace the `DESIGN.md` with your own taste and keep the habit.

### Does it work with React or Next?

Yes. The repo now includes small React + Vite and Next app-router examples. They are deliberately simple so people can test whether Codex reads `DESIGN.md` and improves the UI without changing behavior.

### Does it keep up with Codex changes?

The repo has a daily GitHub Action plus local smoke tests. See `MAINTAINING.md` and `MAINTENANCE-CHECKLIST.md`.

## Tonight's Success Bar

Minimum good launch:

- X post live.
- 5 friend DMs sent.
- OpenAI Forum or Discord post live.
- At least 3 people asked to try one screen.
- Any confusion captured in `LAUNCH-TRACKER.md`.

Great launch:

- One issue opened by someone else.
- One PR or concrete example request.
- One person tries the React or Next example.
- One README/FAQ fix made from real feedback.
