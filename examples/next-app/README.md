# Next.js Example

Use this when someone wants to see the skill in an app-router Next project.

## Try It

```powershell
cd examples/next-app
npm install
npm run dev
```

Then ask Codex:

```text
$design-system Make this landing page follow DESIGN.md.
```

Codex should read `DESIGN.md`, keep the route structure intact, and replace generic landing-page styling with the local rules.

## What To Copy

- `DESIGN.md` goes at the repo root.
- `.agents/skills/design-system/SKILL.md` is the repo-local skill.
- `app/page.jsx` and `app/globals.css` show the smallest useful app-router surface.
