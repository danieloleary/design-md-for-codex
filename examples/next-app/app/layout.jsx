import "./globals.css";

export const metadata = {
  title: "Next DESIGN.md Example",
  description: "A tiny Next app for testing the design-system Codex skill."
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
