---
version: alpha
name: design-md-for-codex Showcase
description: Root design guidance for the public showcase. The packaged starter design system lives at skills/design-system/references/DESIGN.md.
colors:
  void: "#0F1012"
  panel: "#17191D"
  paper: "#F5F4ED"
  ivory: "#FBFAF6"
  ink: "#141413"
  muted-ink: "#43423E"
  line-dark: "#303238"
  line-paper: "#E2DFD6"
  primary: "#AA4B2F"
  terracotta: "#AA4B2F"
  terracotta-dark: "#85351F"
  focus-blue: "#5AA9FF"
typography:
  display:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 64px
    fontWeight: 780
    lineHeight: 0.98
    letterSpacing: 0
  h1:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 44px
    fontWeight: 760
    lineHeight: 1.03
    letterSpacing: 0
  h2:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 30px
    fontWeight: 760
    lineHeight: 1.08
    letterSpacing: 0
  body:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 16px
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: 0
  mono:
    fontFamily: JetBrains Mono, SFMono-Regular, Consolas, monospace
    fontSize: 13px
    fontWeight: 500
    lineHeight: 1.5
    letterSpacing: 0
rounded:
  control: 6px
  panel: 8px
spacing:
  xs: 8px
  sm: 12px
  md: 18px
  lg: 32px
  xl: 56px
---

# design-md-for-codex Showcase Design

This root `DESIGN.md` is the source of truth for the GitHub Pages showcase and public repository docs.

The installable starter that ships inside the skill lives at `skills/design-system/references/DESIGN.md`. Keep that file generally reusable. Keep this root file specific to the showcase.

## Taste Profile

Warm like Claude, restrained like X/xAI, precise like Linear.

Use dark command surfaces for the install and demo flow. Use warm paper sections for explanation, proof, and credits. The page should feel immediate, useful, and calm, not like a SaaS marketing template.

## Layout

- First screen: one clear promise, one copy action, one install prompt.
- Demo: video-forward, wide, and easy to play.
- Proof: before and after images large enough to inspect.
- Sections: few, direct, and separated by quiet borders.
- Mobile: stack early, preserve readable type, and never force horizontal scroll.

## Components

- Buttons use 6px radius, strong labels, and one terracotta primary action.
- Panels use 8px radius, thin borders, and almost no shadow.
- Code blocks wrap safely and must not overflow on 320px screens.
- Links to files should look practical and clickable, not decorative.

## No-Go Zones

- No gradient blobs, glass cards, giant rounded SaaS cards, or decorative clutter.
- No fake one-click install claims. The reliable flow is copy prompt, paste into Codex, restart.
- No launch-ops noise on the landing page. Keep launch materials in repo docs.
- No root-page copy that sounds like an internal process note.

## QA

Before shipping page changes, run:

```powershell
npm run visual-qa
.\qa\ci-check.ps1
```

Check the generated screenshots at `output/browser-qa/` for desktop and mobile balance.
