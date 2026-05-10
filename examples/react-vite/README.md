# React + Vite Example

Use this when a friend says, "Cool, but show me how it fits in a normal React app."

## Try It

```powershell
cd examples/react-vite
npm install
npm run dev
```

Then ask Codex:

```text
$design-system Make this dashboard follow DESIGN.md.
```

Codex should read `DESIGN.md`, keep the React behavior intact, and move the UI toward the local rules: dark command surface, warm review surface, terracotta primary action, tight spacing, and no invented gradients.

## What To Copy

- `DESIGN.md` goes at the repo root.
- `.agents/skills/design-system/SKILL.md` is the repo-local skill.
- `src/App.jsx` and `src/styles.css` are intentionally small so the design pass is easy to review.
