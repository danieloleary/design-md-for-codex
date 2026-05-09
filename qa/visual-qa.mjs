import { spawn } from "node:child_process";
import fs from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import { chromium } from "playwright";

const repoRoot = process.cwd();
const outDir = path.join(repoRoot, "output", "browser-qa");
const port = Number(process.env.PORT || 8797);
const url = `http://127.0.0.1:${port}/`;
const widths = [320, 390, 768, 1024, 1440];

await fs.mkdir(outDir, { recursive: true });

function startServer() {
  const server = spawn(
    "python",
    ["-m", "http.server", String(port), "--bind", "127.0.0.1"],
    {
      cwd: repoRoot,
      stdio: ["ignore", "ignore", "ignore"],
      windowsHide: true,
    },
  );
  return server;
}

async function waitForServer() {
  for (let i = 0; i < 40; i += 1) {
    try {
      const response = await fetch(url);
      if (response.ok) return;
    } catch {
      // Keep polling while the static server starts.
    }
    await new Promise((resolve) => setTimeout(resolve, 250));
  }
  throw new Error(`Static server did not respond at ${url}`);
}

const server = startServer();

try {
  await waitForServer();

  const browser = await chromium.launch();
  const results = [];

  for (const width of widths) {
    const height = width < 768 ? 1100 : 1000;
    const context = await browser.newContext({
      viewport: { width, height },
      deviceScaleFactor: 1,
    });
    await context.grantPermissions(["clipboard-read", "clipboard-write"], {
      origin: url,
    });
    const page = await context.newPage();
    await page.goto(url, { waitUntil: "load" });

    const metrics = await page.evaluate(() => {
      const html = document.documentElement;
      const body = document.body;
      const offenders = [...document.querySelectorAll("body *")]
        .map((node) => {
          const rect = node.getBoundingClientRect();
          return {
            tag: node.tagName.toLowerCase(),
            className: typeof node.className === "string" ? node.className : "",
            text: (node.textContent || "").trim().slice(0, 80),
            left: rect.left,
            right: rect.right,
            width: rect.width,
          };
        })
        .filter(
          (item) =>
            item.width > 0 &&
            (item.left < -1 || item.right > window.innerWidth + 1),
        )
        .slice(0, 8);

      const brokenImages = [...document.images]
        .filter((img) => !img.complete || img.naturalWidth === 0)
        .map((img) => img.getAttribute("src"));

      return {
        viewport: window.innerWidth,
        scrollWidth: html.scrollWidth,
        bodyScrollWidth: body.scrollWidth,
        hasHorizontalOverflow:
          html.scrollWidth > window.innerWidth + 1 ||
          body.scrollWidth > window.innerWidth + 1,
        offenders,
        brokenImages,
      };
    });

    await page.locator("[data-copy-install]").click();
    await page
      .waitForFunction(() => {
        const status =
          document.querySelector("[data-copy-status]")?.textContent || "";
        return /Copied|Copy failed/.test(status);
      })
      .catch(() => {});

    const copyStatus = await page.locator("[data-copy-status]").innerText();
    await page.screenshot({
      path: path.join(outDir, `showcase-${width}.png`),
      fullPage: true,
    });

    results.push({ width, copyStatus, ...metrics });
    await context.close();
  }

  await browser.close();
  await fs.writeFile(
    path.join(outDir, "visual-qa.json"),
    JSON.stringify(results, null, 2),
  );

  for (const result of results) {
    console.log(JSON.stringify(result));
  }

  const failed = results.filter(
    (result) =>
      result.hasHorizontalOverflow ||
      result.brokenImages.length ||
      !/copied/i.test(result.copyStatus),
  );
  if (failed.length) {
    process.exitCode = 1;
  }
} finally {
  if (!server.killed) {
    server.kill();
  }
}
