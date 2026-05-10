# Examples

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

Smallest useful install plus two framework starters.

Copy `examples/minimal-repo/.agents/skills/design-system` into a project. Then copy or customize `examples/minimal-repo/DESIGN.md` at the project root.

For a fuller starter kit, adapt `skills/design-system/references/`.

## Pick One

- `minimal-repo`: smallest possible repo-local skill shape.
- `react-vite`: small React app with Vite, a starter `DESIGN.md`, and deliberately generic UI to improve.
- `next-app`: small Next app-router project with the same local skill pattern.

The resulting project shape is:

```text
their-repo/
  DESIGN.md
  .agents/
    skills/
      design-system/
        SKILL.md
```

Then tell Codex:

```text
$design-system Make this page match DESIGN.md.
```

Restart Codex after adding a new skill.

For feedback, the best path is a PR with a real example or an issue with a before/after screenshot. See `../FEEDBACK.md`.
