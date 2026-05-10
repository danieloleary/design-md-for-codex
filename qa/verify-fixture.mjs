import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, "..");

function read(relativePath) {
  return fs.readFileSync(path.join(repoRoot, relativePath), "utf8");
}

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

function contains(name, content, needle) {
  assert(content.includes(needle), `${name} is missing: ${needle}`);
}

function rejects(name, content, pattern, label) {
  assert(!pattern.test(content), `${name} still contains banned ${label}: ${pattern}`);
}

const after = read("qa/fixture/after.html");
const expected = read("qa/fixture/expected.md");
const result = read("qa/fixture/codex-result.md");

const requiredAfterSnippets = [
  "--void: #0F1012",
  "--surface: #17191D",
  "--accent: #9F442B",
  "--control-radius: 6px",
  "--panel-radius: 8px",
  "font-family: Inter",
  "Dark-first workbench, not a generic dashboard.",
  "Run review",
  "View evidence",
  "Launch checklist",
  "0</strong>",
  "6px</strong>",
  "1</strong>",
  "../../assets/proof/ai-workbench-wide.png",
  "../../assets/proof/ai-workbench-detail.png"
];

for (const snippet of requiredAfterSnippets) {
  contains("qa/fixture/after.html", after, snippet);
}

const requiredExpectedSnippets = [
  "$design-system Make this page follow DESIGN.md.",
  "Show that it read or applied `DESIGN.md`",
  "Remove the Papyrus/fantasy type stack",
  "Use a dark page background",
  "terracotta accent",
  "8px or less",
  "Add governed generated imagery"
];

for (const snippet of requiredExpectedSnippets) {
  contains("qa/fixture/expected.md", expected, snippet);
}

const requiredResultSnippets = [
  "DESIGN.md",
  "Chrome renders",
  "mobile",
  "no horizontal overflow"
];

for (const snippet of requiredResultSnippets) {
  contains("qa/fixture/codex-result.md", result, snippet);
}

const bannedAfterPatterns = [
  [/Papyrus/i, "Papyrus typography"],
  [/\bfantasy\b/i, "fantasy font fallback"],
  [/border-radius:\s*(999|9999)px/i, "pill radius"],
  [/box-shadow:/i, "heavy shadow styling"],
  [/linear-gradient/i, "gradient surface"],
  [/#(7c3aed|8b5cf6|2563eb|3b82f6)/i, "generic purple or blue accent"],
  [/\bglow\b/i, "glow copy or styling"]
];

for (const [pattern, label] of bannedAfterPatterns) {
  rejects("qa/fixture/after.html", after, pattern, label);
}

for (const asset of [
  "assets/proof/fixture-before.png",
  "assets/proof/fixture-after.png",
  "assets/proof/ai-workbench-wide.png",
  "assets/proof/ai-workbench-detail.png"
]) {
  assert(fs.existsSync(path.join(repoRoot, asset)), `Fixture asset is missing: ${asset}`);
}

console.log("OK fixture proof applies DESIGN.md invariants");
