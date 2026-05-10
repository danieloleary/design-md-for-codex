import React from "react";
import { createRoot } from "react-dom/client";
import "./styles.css";

const checks = [
  "Read DESIGN.md first",
  "Keep controls compact",
  "Use one accent",
  "Verify mobile"
];

function App() {
  return (
    <main className="shell">
      <section className="command">
        <p className="eyebrow">React example</p>
        <h1>Design pass queue</h1>
        <p>
          This is intentionally plain starter UI. Ask Codex to apply DESIGN.md
          and it should tighten the hierarchy without changing the app shape.
        </p>
        <div className="actions">
          <button type="button">Run review</button>
          <button type="button" className="secondary">Open notes</button>
        </div>
      </section>

      <section className="review" aria-label="Design checklist">
        <h2>Expected habit</h2>
        <ul>
          {checks.map((check) => (
            <li key={check}>{check}</li>
          ))}
        </ul>
      </section>
    </main>
  );
}

createRoot(document.getElementById("root")).render(<App />);
