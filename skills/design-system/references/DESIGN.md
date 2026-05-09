---
version: alpha
name: Codex Workshop
description: A dark-first, warm-edged design system for focused developer tools, research workspaces, and agent-assisted building, combining monochrome command-center restraint, editorial warmth, and precise workbench layout.
colors:
  ink: "#121417"
  near-black: "#141413"
  void: "#0F1012"
  graphite: "#2D333B"
  charcoal-warm: "#3D3D3A"
  slate: "#5D6978"
  stone: "#87867F"
  mist: "#E7EBEF"
  parchment: "#F5F4ED"
  ivory: "#FAF9F5"
  paper: "#F8F7F3"
  porcelain: "#FFFFFF"
  primary: "#9F442B"
  terracotta: "#C96442"
  terracotta-dark: "#9F442B"
  focus-blue: "#3898EC"
  mint: "#25A784"
  amber: "#B7791F"
  coral: "#D84E3F"
  violet: "#6E56CF"
  dark-surface: "#1F2228"
  dark-surface-subtle: "#17191D"
  dark-border: "#2A2C30"
  dark-border-strong: "#3E4044"
  dark-text-primary: "#FFFFFF"
  dark-text-secondary: "#B8B8B8"
  dark-text-muted: "#808080"
typography:
  display:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 40px
    fontWeight: 720
    lineHeight: 1.05
    letterSpacing: 0
  h1:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 32px
    fontWeight: 700
    lineHeight: 1.15
    letterSpacing: 0
  h2:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 24px
    fontWeight: 680
    lineHeight: 1.2
    letterSpacing: 0
  h3:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 18px
    fontWeight: 650
    lineHeight: 1.25
    letterSpacing: 0
  body:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 15px
    fontWeight: 400
    lineHeight: 1.55
    letterSpacing: 0
  label:
    fontFamily: Inter, ui-sans-serif, system-ui, sans-serif
    fontSize: 13px
    fontWeight: 650
    lineHeight: 1.3
    letterSpacing: 0
  mono:
    fontFamily: JetBrains Mono, SFMono-Regular, Consolas, monospace
    fontSize: 13px
    fontWeight: 500
    lineHeight: 1.5
    letterSpacing: 0
rounded:
  xs: 4px
  sm: 6px
  md: 8px
  lg: 12px
  full: 9999px
spacing:
  xs: 4px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 24px
  xxl: 32px
modes:
  light:
    background: "{colors.parchment}"
    surface: "{colors.ivory}"
    surface-raised: "{colors.porcelain}"
    text-primary: "{colors.near-black}"
    text-secondary: "{colors.charcoal-warm}"
    text-muted: "{colors.stone}"
    border: "{colors.mist}"
    accent: "{colors.terracotta}"
  dark:
    background: "{colors.void}"
    surface: "{colors.dark-surface}"
    surface-raised: "{colors.dark-surface-subtle}"
    text-primary: "{colors.dark-text-primary}"
    text-secondary: "{colors.dark-text-secondary}"
    text-muted: "{colors.dark-text-muted}"
    border: "{colors.dark-border}"
    border-strong: "{colors.dark-border-strong}"
    accent: "{colors.terracotta}"
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.porcelain}"
    rounded: "{rounded.sm}"
    typography: "{typography.label}"
  button-secondary:
    backgroundColor: "{colors.ivory}"
    textColor: "{colors.ink}"
    rounded: "{rounded.sm}"
    typography: "{typography.label}"
  card:
    backgroundColor: "{colors.ivory}"
    textColor: "{colors.ink}"
    rounded: "{rounded.md}"
  input:
    backgroundColor: "{colors.porcelain}"
    textColor: "{colors.ink}"
    rounded: "{rounded.sm}"
  app-shell:
    backgroundColor: "{colors.parchment}"
    textColor: "{colors.near-black}"
  sidebar:
    backgroundColor: "{colors.ivory}"
    textColor: "{colors.charcoal-warm}"
  toolbar:
    height: 48px
    backgroundColor: "{colors.ivory}"
  command-palette:
    backgroundColor: "{colors.porcelain}"
    textColor: "{colors.near-black}"
    rounded: "{rounded.lg}"
  chat-panel:
    backgroundColor: "{colors.ivory}"
    textColor: "{colors.ink}"
    rounded: "{rounded.md}"
  data-table:
    backgroundColor: "{colors.ivory}"
    textColor: "{colors.ink}"
  code-block:
    backgroundColor: "{colors.void}"
    textColor: "{colors.dark-text-primary}"
    rounded: "{rounded.md}"
---

# Codex Workshop Design System

## Overview

Codex Workshop is a design system for serious work that still feels alive. It should feel dark, sharp, warm, and awake: a workspace where code, research, and decisions can sit together without visual noise. The tone is practical and exacting, with small moments of warmth through color, spacing, and confident typography.

Use this system for developer tools, dashboards, documentation surfaces, research workspaces, local utilities, and agent-assisted workflows. Interfaces should feel built for repeated use, fast scanning, and clear action.

Default aesthetic: monochrome command-center restraint plus warm editorial memory plus precise workbench layout. Dark mode should feel sparse, exact, and high-signal; light surfaces should feel humane and readable when the work needs warmth. The result should be original, not a clone of any referenced brand.

## Design Principles

1. Useful first, beautiful through restraint.
2. Dark-first command surfaces, warm editorial support surfaces.
3. One accent per decision area.
4. Borders before shadows.
5. Typography and alignment carry the personality.
6. Data density is welcome when the hierarchy stays clear.
7. Generated UI should feel intentional, not generic.

## Mode Recipes

Light mode is best for writing, research, planning, docs, and collaboration. Use `parchment` or `paper` as the page background, `ivory` for panels, `porcelain` for active or raised controls, and `terracotta` for the primary action.

Dark mode is the default for first impressions, terminal-adjacent workflows, monitoring, coding, agent traces, logs, observability, and command-center views. Use `void` for the page background, `dark-surface` for panels, translucent white borders, and opacity-based text hierarchy.

Do not make dark mode blue-gray. It should feel like precise monochrome with a warm accent, not a generic dashboard skin.

## Colors

Use `void` or `near-black` for high-focus command surfaces. Use `parchment` or `paper` for slower reading and planning surfaces, with `ivory` or `porcelain` for active panels. Use `ink` or `near-black` for primary text on light surfaces, `charcoal-warm` and `graphite` for secondary headings, and `slate` or `stone` for metadata, labels, captions, helper text, and inactive controls.

Use `terracotta` as the primary action color. A screen should usually have one dominant terracotta action. Use `terracotta-dark` for pressed states, selected navigation, or high-emphasis links on pale backgrounds. Use `focus-blue` only for keyboard focus rings, selection outlines, and accessibility affordances where blue carries a familiar platform meaning.

Use semantic colors intentionally:

- `mint` means success, completion, connected, or healthy.
- `amber` means warning, pending, waiting, or needs attention.
- `coral` means destructive, failed, invalid, or high risk.
- `violet` means intelligence, automation, synthesis, or generated insight.

For dark mode, prefer `void` or `dark-surface` backgrounds, white text opacity scales, and borders made from translucent white. Dark mode depth should come from opacity, border contrast, and spacing, not shadows.

Do not build one-hue interfaces. Neutral structure should dominate, with color used to guide attention. Avoid generic SaaS blue as the main brand color.

## Typography

Use the Inter family for UI text. Use `display` only for true first-viewport heroes or empty states with strong editorial intent. Use `h1`, `h2`, and `h3` for hierarchy inside app views.

Use `body` for paragraphs, table cells, form descriptions, and normal interface copy. Use `label` for buttons, tabs, nav items, field labels, badges, and compact metadata. Use `mono` for code, paths, command output, config keys, versions, IDs, and terminal-like content.

Letter spacing must remain `0`. Do not use all-caps labels unless they are tiny metadata tags and the surrounding UI is sparse.

## Layout

Prefer dense but breathable application layouts. Use full-width bands, split panes, resizable panels, sidebars, tables, inspectors, and toolbars when they match the task. Do not default to marketing-style hero sections for apps or tools.

App layouts should usually use one of these patterns:

- Workbench: sidebar, top toolbar, main canvas, optional right inspector.
- Conversation workspace: chat or activity stream on one side, artifact/result pane on the other.
- Command center: dense table or timeline, filters above, details in a side panel.
- Editorial tool: reading pane, outline/navigation rail, compact metadata sidebar.

Use the spacing scale consistently:

- `xs` for icon/text gaps and tight inline affordances.
- `sm` for compact control padding and grouped metadata.
- `md` for form fields, table cell padding, and toolbar gaps.
- `lg` for section spacing and panel interiors.
- `xl` and `xxl` for major view separation.

For fixed-format UI elements such as boards, tiles, icon buttons, counters, toolbars, and navigation rows, define stable dimensions so hover states and dynamic labels do not resize the layout.

## Elevation & Depth

Use borders, tonal contrast, and spacing before shadows. The default surface is flat with a `mist` border. Use subtle shadows only for popovers, menus, active drag states, and modals.

Preferred shadow:

```css
box-shadow: 0 10px 30px rgba(18, 20, 23, 0.10);
```

Avoid heavy glow effects, blurred blobs, decorative orbs, and atmospheric gradients.

In dark mode, avoid box shadows entirely unless a component cannot be understood without separation. Prefer `dark-border`, `dark-border-strong`, and subtle surface opacity.

## Shapes

Use a restrained shape language. Most cards and panels use `md` radius. Buttons, inputs, tabs, and compact controls use `sm`. Use `lg` only for larger modals, command palettes, or visual previews. Use `full` for avatars, tiny status dots, and pill-shaped progress indicators.

Do not nest cards inside cards. If grouped content needs structure, use separators, headings, inset rows, or an unframed grid.

## Components

Buttons should be compact, direct, and icon-aware. Use familiar icons for common actions such as save, download, search, filter, settings, close, back, undo, redo, copy, and external link. Text buttons are for commands where the label carries meaning.

Primary buttons use `button-primary` and should appear once per major decision area. Secondary buttons use `button-secondary`. Destructive actions use `coral` and should not share the same visual weight as the primary happy path unless the entire flow is destructive.

Inputs should have clear labels, visible focus states, and concise helper text only when needed. Tables should prioritize scanability: sticky headers when useful, aligned numeric columns, quiet row dividers, and row actions that appear on hover or selection.

Cards are for repeated items, modals, and framed tools. Page sections are not cards. Avoid decorative card grids when a table, list, or split pane would be more efficient.

Sidebars should be quiet and stable. Use 240px to 280px widths on desktop. Active navigation uses a raised surface, stronger text, and a left indicator or subtle fill. Avoid colorful nav rails.

Toolbars should be compact and functional. Use icon buttons for common actions, segmented controls for modes, and search/filter controls where they save clicks. A toolbar should not become a second hero.

Command palettes use `command-palette`: large enough to breathe, visually centered, with crisp search focus and dense results. Keyboard interaction is mandatory.

Chat panels should distinguish human, assistant, tool, and system messages through spacing, labels, and subtle accent treatment rather than oversized bubbles. For agent traces, prefer compact timeline rows with icons and status color.

Data tables should be calm and precise: sticky header when useful, quiet row dividers, aligned numbers, compact filters, and hover actions. Zebra striping is usually unnecessary.

Code blocks and terminal output should use `code-block`, with dark surfaces even in light mode when that improves readability. Paths, commands, IDs, and config keys should use the `mono` type token.

Badges should be small, text-first, and semantic. Use mint, amber, coral, violet, or neutral tones. Avoid rainbow status systems.

## Content Voice

Write UI copy like a capable teammate: concise, specific, and calm. Prefer verbs over slogans. Empty states should explain the next useful action, not sell the product. Error messages should state what happened and how to recover.

Avoid filler phrases like "unlock your potential", "seamless experience", and "next-generation platform". The product should sound competent, not breathless.

## Motion

Motion should clarify state changes, not decorate them. Use short transitions between 120ms and 180ms for hover, focus, disclosure, tab changes, and menu entry. Use 220ms maximum for larger panel movement.

Use transforms and opacity for animation. Respect reduced-motion preferences. Do not animate layout in ways that make text hard to read or controls hard to click.

## Accessibility

Every interactive element needs a visible focus state. Text and icon-only controls need accessible names. Color cannot be the only way to communicate state.

Maintain WCAG AA contrast for text and controls. Use `npx @google/design.md lint DESIGN.md` when editing this file to catch contrast and reference issues.

Buttons, tabs, and form controls should be reachable and usable from the keyboard. Hit targets should be at least 36px in compact desktop UI and 44px on touch-first surfaces.

## Do's and Don'ts

Do:

- Build the actual usable app or tool as the first screen.
- Start from the workflow surface: table, editor, command palette, canvas, trace, inbox, or chat.
- Use restrained neutrals with one clear accent path.
- Make common workflows efficient, scannable, and reversible.
- Use icons for familiar commands and tooltips for less obvious actions.
- Keep text inside buttons, cards, tabs, and controls from wrapping awkwardly or overflowing.
- Verify rendered UI at desktop and mobile widths when frontend code changes.

Don't:

- Use purple-blue gradients as the main look.
- Use beige, brown, espresso, or dark slate as the dominant palette; warmth should come from parchment and terracotta restraint, not sepia theming.
- Add decorative orbs, glow blobs, bokeh, or fake glass effects.
- Add stock-photo atmosphere when the user needs to inspect the product or workflow.
- Nest cards inside cards.
- Make a landing page when the user asked for an app, game, dashboard, or tool.
- Invent new tokens when this file already provides an appropriate one.

## Agent Prompt Guide

When asking an AI coding agent to build UI with this file, use language like:

```text
Use DESIGN.md as the source of truth. Build the actual working interface first. Aim for dark-first command-center restraint, warm editorial support surfaces, and precise workbench layout. Use terracotta as the main accent, avoid generic SaaS blue, use borders before shadows, and verify the result at desktop and mobile widths.
```
