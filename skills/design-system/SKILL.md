---
name: design-system
description: Use when building, editing, reviewing, or refactoring frontend UI; creating visual components; translating screenshots, mockups, DESIGN.md files, or product taste references into code; or checking whether UI follows the repository design system. Read DESIGN.md first and apply its colors, typography, spacing, components, accessibility rules, taste profile, and do/don'ts.
metadata:
  short-description: Apply DESIGN.md to frontend UI work
---

# Design System

Use this skill to keep UI work aligned with a repository's visual system.

The bundled `references/DESIGN.md` is an example starter system. It uses a warm, restrained direction inspired by Claude-like editorial warmth, X/xAI-like restraint, and Linear-like precision. Treat that as an example default, not a requirement.

## Workflow

1. Locate the design source of truth.
   - Prefer `DESIGN.md` at the repository or workspace root.
   - If absent, search one level up and then under `docs/`, `.agents/`, and `design/`.
   - If no repo-local design file exists, use this skill's bundled `references/DESIGN.md`.
   - If multiple design files exist, prefer the closest repo-root `DESIGN.md` and mention conflicts briefly.

2. Read `DESIGN.md` before changing UI.
   - Treat YAML front matter tokens as normative values.
   - Treat Markdown sections as product rules and rationale.
   - Preserve existing app behavior while moving touched UI toward the design rules.

3. Apply the system concretely.
   - Use the documented colors, typography, spacing, radii, elevation, components, layout, motion, and accessibility rules.
   - Do not invent new colors, font scales, radii, shadows, component variants, or decorative motifs when a documented option fits.
   - Prefer existing project components and tokens over new abstractions.
   - When the design direction is open, bias toward restrained, product-grade UI: clear hierarchy, few accents, borders before shadows, and practical workflows.

4. Validate when `DESIGN.md` changes.
   - If Node/npm are available, run:
     `npx @google/design.md lint DESIGN.md`
   - If validating the bundled example from this skill, run:
     `npx @google/design.md lint skills/design-system/references/DESIGN.md`
   - Treat linter errors as blockers. Treat warnings as review items to fix or explain.

5. Verify rendered UI when frontend code changes.
   - Start the app's existing dev server if needed.
   - Use browser-based checks or screenshots at desktop and mobile widths.
   - Check for overflow, overlapping text, broken focus states, unreadable contrast, and layout shift.

## Review Checklist

- UI uses `DESIGN.md` tokens or project variables derived from them.
- Primary actions are visually clear and not overused.
- Typography matches the documented hierarchy.
- Spacing follows the documented scale.
- Components follow documented shape, border, and elevation rules.
- Color communicates state accessibly and never as the only signal.
- Mobile and desktop layouts remain usable without text overlap.
- No decorative gradients, blobs, nested cards, or invented visual systems were added unless the repo design file explicitly asks for them.

## If The Design File Is Missing Or Incomplete

If `DESIGN.md` is missing, say so briefly and use the app's existing design conventions or the bundled example. If a needed rule is missing, make the smallest reasonable choice, explain it, and offer to update `DESIGN.md` so future work is consistent.
