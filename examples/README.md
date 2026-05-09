# Examples

Made by Dan O'Leary for friends, builders, and people tired of generic AI UI.

Smallest useful install.

Copy `examples/minimal-repo/.agents/skills/design-system` into a project. Then copy or customize `examples/minimal-repo/DESIGN.md` at the project root.

For a fuller starter kit, adapt `skills/design-system/references/`.

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
