# Examples

This folder shows the simplest way to give a friend the skill.

Copy `examples/minimal-repo/.agents/skills/design-system` into their project, then copy or customize `examples/minimal-repo/DESIGN.md` at the project root.

The resulting project shape is:

```text
their-repo/
  DESIGN.md
  .agents/
    skills/
      design-system/
        SKILL.md
```

Then ask Codex:

```text
$design-system Make this page match DESIGN.md.
```

Restart Codex after adding a new skill so it can be discovered.
