# FAQ

## What Is DESIGN.md?

`DESIGN.md` is a design system file that lives in your repo. It gives agents concrete UI rules: colors, typography, spacing, components, accessibility, voice, and no-go zones.

## Why Use A Skill?

Because rules only help when Codex reads them. This skill makes reading `DESIGN.md` the default habit before frontend work.

## Is This Only Dan's Taste?

No. The starter uses Dan's taste as a useful default: dark command surfaces, warm paper sections, terracotta accent, tight borders, and no generic AI UI soup. Replace `DESIGN.md` with your own taste.

## Does This Replace A Design System?

No. It helps Codex follow one. `DESIGN.md` can point at your tokens, components, Figma rules, Tailwind setup, or product voice.

## Can I Use This With Tailwind Or React?

Yes. Put the rules in `DESIGN.md`, then ask Codex to use your existing components and tokens. The skill is framework-agnostic.

## Can I Use It Without A Frontend App?

Yes, but it is most valuable when Codex is building, reviewing, or refactoring UI. It can also help review docs, screenshots, and examples for design consistency.

## How Do I Test It?

Run:

```powershell
.\qa\smoke-test.ps1
npm install
npm run visual-qa
```

Then install the skill in Codex and try:

```text
$design-system Make this page follow DESIGN.md.
```

## Where Should I Share Feedback?

Open a GitHub issue. Install bugs, skill behavior bugs, docs confusion, and example requests all help make the skill better.
