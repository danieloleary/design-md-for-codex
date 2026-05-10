const steps = [
  "Install the skill",
  "Add DESIGN.md",
  "Ask Codex for a design pass"
];

export default function Page() {
  return (
    <main className="page">
      <section className="hero">
        <p className="eyebrow">Next.js example</p>
        <h1>Make the landing page obey the repo.</h1>
        <p>
          This starter is deliberately generic. The useful test is whether Codex
          reads DESIGN.md and turns the page into a sharper product surface.
        </p>
        <a href="#steps">Try the flow</a>
      </section>

      <section className="steps" id="steps">
        <h2>What Codex should preserve</h2>
        <ol>
          {steps.map((step) => (
            <li key={step}>{step}</li>
          ))}
        </ol>
      </section>
    </main>
  );
}
