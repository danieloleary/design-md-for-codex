---
version: starter
name: React Workbench UI
colors:
  void: "#0F1012"
  surface: "#17191D"
  paper: "#F6F1E8"
  paper-strong: "#FFFDF8"
  text: "#F7F4EC"
  text-dark: "#151515"
  muted: "#A8A29A"
  muted-dark: "#6F6A62"
  border: "#2A2C30"
  border-light: "#DDD5C8"
  primary: "#9F442B"
  accent: "#C96442"
typography:
  body:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 15px
    lineHeight: 1.55
rounded:
  control: 6px
  panel: 8px
spacing:
  xs: 6px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 24px
---

# React Workbench UI

Build React UI like a compact product workbench: dark command surfaces first, warm paper for review, one terracotta accent, thin borders, and no decorative filler.

Do:

- Keep the first viewport useful.
- Use dark surfaces for controls, filters, logs, and app state.
- Use warm paper surfaces for summaries, notes, and reading.
- Keep controls compact and obvious.
- Use the existing React component structure before adding abstractions.
- Verify desktop and mobile widths after UI changes.

Don't:

- Add generic purple or blue SaaS gradients.
- Add pill buttons unless a component rule explicitly asks for them.
- Use shadows where a border works.
- Nest cards inside cards.
- Change behavior while doing a visual cleanup.
