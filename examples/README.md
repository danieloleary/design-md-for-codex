# Examples

This folder shows the smallest repo-local install.

Copy `examples/minimal-repo/.agents/skills/design-system` into their project, then copy or customize `examples/minimal-repo/DESIGN.md` at the project root.

For a fuller starter kit, adapt the files in `skills/design-system/references/` from the root of this repo.

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
