---
name: design-system
description: Use when building, editing, reviewing, or refactoring frontend UI in a repo with DESIGN.md or design-system guidance. Read the design source first, then apply its colors, typography, spacing, components, accessibility rules, taste profile, and do/don'ts.
---

# Design System

Use this skill to make UI work obey the repo's design source of truth.

The bundled `references/DESIGN.md` is a fallback starter: dark command surfaces, warm editorial support surfaces, one accent, clean borders. Use it only when the repo has no local design file.

## Workflow

1. Find the design source.
   - Prefer `DESIGN.md` at the repository or workspace root.
   - If absent, search one level up and then under `docs/`, `.agents/`, and `design/`.
   - If no repo-local design file exists, use this skill's bundled `references/DESIGN.md`.
   - If multiple design files exist, prefer the closest repo-root `DESIGN.md` and mention conflicts briefly.

2. Read `DESIGN.md` before touching UI.
   - Treat YAML front matter tokens as normative values.
   - Treat Markdown sections as product rules and rationale.
   - Preserve existing app behavior while moving touched UI toward the design rules.

3. Apply the system.
   - Use the documented colors, typography, spacing, radii, elevation, components, layout, motion, and accessibility rules.
   - Do not invent new colors, font scales, radii, shadows, component variants, or decorative motifs when a documented rule fits.
   - Prefer existing project components and tokens over new abstractions.
   - When the design direction is open, bias toward restrained, product-grade UI: clear hierarchy, few accents, borders before shadows, and practical workflows.

4. Validate design files when they change.
   - If Node/npm are available, run:
     `npx @google/design.md lint DESIGN.md`
   - If validating the bundled example from this skill, run:
     `npx @google/design.md lint skills/design-system/references/DESIGN.md`
   - Treat linter errors as blockers. Treat warnings as review items to fix or explain.

5. Verify the rendered UI.
   - Start the app's existing dev server if needed.
   - Use browser-based checks or screenshots at desktop and mobile widths.
   - Check for overflow, overlapping text, broken focus states, unreadable contrast, and layout shift.
   - In the final response, name which design file you read and summarize the main rules you applied.

## Review Checklist

- UI uses `DESIGN.md` tokens or project variables derived from them.
- Primary actions are visually clear and not overused.
- Typography matches the documented hierarchy.
- Spacing follows the documented scale.
- Components follow documented shape, border, and elevation rules.
- Color communicates state accessibly and never as the only signal.
- Mobile and desktop layouts remain usable without text overlap.
- No decorative gradients, blobs, nested cards, or invented visual systems were added unless the repo design file explicitly asks for them.
- Final response confirms the `DESIGN.md` source and the design rules applied.

## Missing Or Incomplete Design Files

If `DESIGN.md` is missing, say so briefly and use the app's existing conventions or the bundled starter. If a needed rule is missing, make the smallest reasonable choice and offer to add the rule so the next pass is sharper.
