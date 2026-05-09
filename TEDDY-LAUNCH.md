# Teddy Launch Desk

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

This file turns the `design-md-for-codex` launch into an operator workflow Teddy can run with Dan.

Teddy's job is not just to post. Teddy should help Dan launch, listen, follow up, and keep the repo useful.

## Operating Rule

Teddy can prepare everything.

Teddy should ask Dan before sending:

- Public X posts.
- Public forum or Discord posts.
- Emails.
- DMs.
- Replies that represent Dan publicly.

Teddy can act without extra approval for:

- Drafting copy.
- Creating reminders.
- Building a reply tracker.
- Summarizing feedback.
- Checking GitHub stars, forks, issues, releases, and Pages status.
- Preparing Dan's LinkedIn post for Dan to paste or publish himself.

## Launch Command

Give Teddy this:

```text
Run the design-md-for-codex launch desk. Prepare the launch sequence, drafts, reminders, and feedback tracker. Use the repo, live site, LAUNCH.md, SHARE.md, and assets. Ask Dan before sending public posts, emails, or DMs.
```

## Assets Teddy Should Use

- Repo: `https://github.com/danieloleary/design-md-for-codex`
- Site: `https://danieloleary.github.io/design-md-for-codex/`
- Install prompt:

  ```text
  Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
  ```

- Social card: `assets/social-card.png`
- Proof image: `assets/share-before-after.png`
- Before proof: `assets/proof/fixture-before.png`
- After proof: `assets/proof/fixture-after.png`
- Generated workbench image: `assets/proof/ai-workbench-wide.png`

## Launch Sequence

### Day 0: Prep

Teddy should:

- Confirm `main` is green in GitHub Actions.
- Confirm GitHub Pages is live.
- Confirm the latest release is visible.
- Prepare posts from `LAUNCH.md`.
- Prepare the friend email below.
- Create a simple tracker with columns: person/channel, sent, reply, action, follow-up date.
- Use `LAUNCH-TRACKER.md` as the tracker template.
- Ask Dan whether to launch today.

### Day 1: Public Launch

Teddy should prepare:

- X post from Teddy's X account, using `assets/share-before-after.png`.
- LinkedIn post for Dan to publish personally.
- OpenAI Forum / Discord post.
- GitHub release bump or pinned issue if needed.

Approval gate:

```text
Dan, I have the X post, OpenAI Forum/Discord post, and friend email ready. Do you want me to send the Teddy-controlled ones now?
```

### Day 2: Follow-Up

Teddy should:

- Summarize reactions.
- Collect bugs and questions.
- Draft replies.
- Identify useful feature requests.
- Remind Dan to reply personally to high-signal builders.
- Ask whether to post a short demo clip.

### Day 3: Distribution Push

Teddy should:

- Prepare submissions or posts for skill directories from `SHARE.md`.
- Draft a lightweight "what I learned from launch" post.
- Create GitHub issues for any improvements people asked for.
- Suggest the next release if feedback points to one.

## X Post For Teddy

I helped Dan ship a tiny Codex skill for people tired of re-prompting taste.

Install one skill. Add `DESIGN.md`. Now Codex starts UI work from your design rules.

Before: Papyrus soup.
After: governed workbench.

Repo:
https://github.com/danieloleary/design-md-for-codex

Install:

```text
Use $skill-installer to install https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system
```

## LinkedIn Handoff For Dan

Dan should post this himself from LinkedIn:

```text
I made a small Codex skill for a problem I kept running into: AI UI taste drift.

Codex can build fast, but if taste only lives in chat, the UI starts wandering.

So I made a tiny skill that tells Codex to read DESIGN.md before building, reviewing, or refactoring UI.

DESIGN.md is the memory. This skill is the habit.

Repo:
https://github.com/danieloleary/design-md-for-codex
```

## Email Draft

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

## Reply Triage

Teddy should classify replies as:

- `bug`: install, skill discovery, DESIGN.md lint, docs, broken link.
- `idea`: feature, example, packaging, plugin, demo, visual direction.
- `user-help`: someone wants help installing or adapting it.
- `signal`: thoughtful feedback from a builder worth Dan's attention.
- `share`: someone reposted, starred, forked, or submitted it somewhere.

For every `bug`, Teddy should create a draft GitHub issue.

For every `signal`, Teddy should draft a personal reply for Dan.

For every `user-help`, Teddy should answer with the install prompt, the test command, and the minimal repo example.

## Metrics Teddy Should Watch

- GitHub stars.
- Forks.
- Issues.
- Pull requests.
- Release views/downloads if available.
- Pages URL health.
- X replies/reposts/bookmarks if available.
- Email replies.
- OpenAI Forum or Discord reactions.

## Next Best Automations

- Daily launch digest for 7 days.
- Reply tracker.
- Demo video checklist.
- Directory submission tracker.
- Weekly "keep this skill current with Codex" check.
- Backlog of examples people request.
