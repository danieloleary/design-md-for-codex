from __future__ import annotations

from pathlib import Path
from textwrap import wrap

from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "assets"
PROOF = ASSETS / "proof"

INK = "#111111"
NIGHT = "#101114"
NIGHT_2 = "#17181c"
PAPER = "#f4efe6"
IVORY = "#fffaf0"
MUTED = "#b8aa98"
TERRACOTTA = "#c46245"
BORDER = "#2b2a28"
GREEN = "#89a66b"


def font(name: str, size: int) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    candidates = [
        Path("C:/Windows/Fonts") / name,
        Path("C:/Windows/Fonts/segoeui.ttf"),
        Path("C:/Windows/Fonts/arial.ttf"),
    ]
    for path in candidates:
        if path.exists():
            return ImageFont.truetype(str(path), size)
    return ImageFont.load_default()


FONT = {
    "regular": "segoeui.ttf",
    "bold": "segoeuib.ttf",
    "mono": "consola.ttf",
}


def text_size(draw: ImageDraw.ImageDraw, text: str, fnt: ImageFont.ImageFont) -> tuple[int, int]:
    box = draw.textbbox((0, 0), text, font=fnt)
    return box[2] - box[0], box[3] - box[1]


def multiline(
    draw: ImageDraw.ImageDraw,
    xy: tuple[int, int],
    text: str,
    fnt: ImageFont.ImageFont,
    fill: str,
    max_width: int,
    line_gap: int = 8,
    max_lines: int | None = None,
) -> int:
    words = text.split()
    lines: list[str] = []
    current = ""
    for word in words:
        trial = f"{current} {word}".strip()
        if text_size(draw, trial, fnt)[0] <= max_width or not current:
            current = trial
        else:
            lines.append(current)
            current = word
    if current:
        lines.append(current)
    if max_lines:
        lines = lines[:max_lines]

    x, y = xy
    line_height = text_size(draw, "Ag", fnt)[1] + line_gap
    for line in lines:
        draw.text((x, y), line, font=fnt, fill=fill)
        y += line_height
    return y


def rounded(draw: ImageDraw.ImageDraw, box: tuple[int, int, int, int], radius: int, fill: str, outline: str | None = None, width: int = 1) -> None:
    draw.rounded_rectangle(box, radius=radius, fill=fill, outline=outline, width=width)


def pill(draw: ImageDraw.ImageDraw, x: int, y: int, text: str, fill: str, outline: str, fg: str) -> None:
    fnt = font(FONT["mono"], 18)
    tw, th = text_size(draw, text, fnt)
    rounded(draw, (x, y, x + tw + 30, y + th + 18), 4, fill, outline)
    draw.text((x + 15, y + 8), text, font=fnt, fill=fg)


def code_panel(draw: ImageDraw.ImageDraw, box: tuple[int, int, int, int], title: str, lines: list[str]) -> None:
    x1, y1, x2, y2 = box
    rounded(draw, box, 8, NIGHT_2, "#36322e", 2)
    draw.text((x1 + 24, y1 + 20), title, font=font(FONT["bold"], 22), fill=PAPER)
    y = y1 + 62
    mono = font(FONT["mono"], 19)
    for line in lines:
        fill = TERRACOTTA if line.startswith(">") else "#ded7ca"
        draw.text((x1 + 24, y), line, font=mono, fill=fill)
        y += 31


def ui_panel(draw: ImageDraw.ImageDraw, box: tuple[int, int, int, int], title: str, mode: str) -> None:
    x1, y1, x2, y2 = box
    rounded(draw, box, 8, IVORY, "#d8cbbb", 2)
    draw.text((x1 + 22, y1 + 20), title, font=font(FONT["bold"], 24), fill=INK)
    draw.text((x1 + 22, y1 + 58), mode, font=font(FONT["regular"], 17), fill="#665d52")
    y = y1 + 105
    for i, width in enumerate([180, 245, 135]):
        color = TERRACOTTA if i == 0 else "#d9d0c5"
        rounded(draw, (x1 + 22, y, x1 + 22 + width, y + 16), 3, color)
        y += 34
    rounded(draw, (x1 + 22, y + 4, x2 - 22, y + 92), 6, "#efe6da", "#d8cbbb")
    draw.rectangle((x1 + 44, y + 28, x1 + 190, y + 44), fill="#1c1c1d")
    draw.rectangle((x1 + 44, y + 58, x1 + 265, y + 70), fill="#b8aa98")
    rounded(draw, (x2 - 142, y + 28, x2 - 42, y + 64), 4, TERRACOTTA)


def save_social_card() -> None:
    img = Image.new("RGB", (1200, 630), NIGHT)
    draw = ImageDraw.Draw(img)
    draw.rectangle((0, 0, 1200, 630), fill=NIGHT)
    draw.rectangle((0, 0, 1200, 9), fill=TERRACOTTA)
    draw.ellipse((-170, 420, 350, 900), fill="#19100d")

    draw.text((70, 76), "DESIGN.md FOR CODEX", font=font(FONT["mono"], 24), fill=TERRACOTTA)
    y = multiline(draw, (68, 124), "Make Codex remember your taste.", font(FONT["bold"], 72), IVORY, 610, 4)
    y += 16
    y = multiline(draw, (72, y), "DESIGN.md is the memory. This skill is the habit.", font(FONT["regular"], 31), "#ded3c3", 600, 8)
    draw.text((72, 530), "Made by Dan O'Leary", font=font(FONT["bold"], 24), fill=PAPER)
    draw.text((72, 566), "for friends, builders, and people tired of generic AI UI.", font=font(FONT["regular"], 21), fill=MUTED)

    code_panel(
        draw,
        (720, 70, 1128, 245),
        "Codex command",
        [
            "> $design-system",
            "read DESIGN.md first",
            "apply tokens",
            "check mobile + desktop",
        ],
    )
    code_panel(
        draw,
        (670, 282, 960, 552),
        "DESIGN.md",
        [
            "colors: ink, ivory",
            "accent: terracotta",
            "radius: 8px max",
            "avoid: generic soup",
            "verify: no overflow",
        ],
    )
    ui_panel(draw, (982, 282, 1148, 552), "UI", "governed")
    img.save(ASSETS / "social-card.png", optimize=True)


def save_repo_banner() -> None:
    img = Image.new("RGB", (1600, 480), NIGHT)
    draw = ImageDraw.Draw(img)
    draw.rectangle((0, 0, 1600, 480), fill=NIGHT)
    draw.rectangle((0, 0, 1600, 8), fill=TERRACOTTA)
    draw.rectangle((1040, 0, 1600, 480), fill="#17120f")
    draw.text((76, 70), "DESIGN.md is the memory.", font=font(FONT["bold"], 66), fill=IVORY)
    draw.text((76, 150), "This skill is the habit.", font=font(FONT["bold"], 66), fill=IVORY)
    draw.text((80, 252), "Make Codex load your design rules before it builds, reviews, or refactors UI.", font=font(FONT["regular"], 31), fill="#ded3c3")
    pill(draw, 80, 334, "Use $skill-installer to install github.com/danieloleary/design-md-for-codex", "#16171a", "#39342f", PAPER)
    draw.text((80, 417), "Made by Dan O'Leary", font=font(FONT["bold"], 22), fill=TERRACOTTA)

    code_panel(draw, (1110, 58, 1518, 222), "DESIGN.md", ["type: clear", "spacing: compact", "accent: restrained"])
    ui_panel(draw, (1110, 250, 1518, 430), "Workbench", "consistent by default")
    img.save(ASSETS / "repo-banner.png", optimize=True)


def cover_crop(image: Image.Image, size: tuple[int, int]) -> Image.Image:
    target_w, target_h = size
    scale = max(target_w / image.width, target_h / image.height)
    resized = image.resize((int(image.width * scale), int(image.height * scale)), Image.Resampling.LANCZOS)
    left = (resized.width - target_w) // 2
    top = (resized.height - target_h) // 2
    return resized.crop((left, top, left + target_w, top + target_h))


def save_before_after() -> None:
    img = Image.new("RGB", (1600, 900), NIGHT)
    draw = ImageDraw.Draw(img)
    draw.rectangle((0, 0, 1600, 900), fill=NIGHT)
    draw.rectangle((0, 0, 1600, 10), fill=TERRACOTTA)
    draw.text((72, 56), "One prompt. One DESIGN.md. Less slop.", font=font(FONT["bold"], 58), fill=IVORY)
    draw.text((76, 130), "Before: generic soup. After: governed workbench.", font=font(FONT["regular"], 27), fill="#ded3c3")

    before = Image.open(PROOF / "fixture-before.png").convert("RGB")
    after = Image.open(PROOF / "fixture-after.png").convert("RGB")
    before = cover_crop(before, (680, 510))
    after = cover_crop(after, (680, 510))

    left = (72, 205, 752, 715)
    right = (848, 205, 1528, 715)
    rounded(draw, (left[0] - 10, left[1] - 10, left[2] + 10, left[3] + 10), 8, "#1b1c20", "#36322e", 2)
    rounded(draw, (right[0] - 10, right[1] - 10, right[2] + 10, right[3] + 10), 8, "#1b1c20", TERRACOTTA, 2)
    img.paste(before, (left[0], left[1]))
    img.paste(after, (right[0], right[1]))

    draw.text((72, 750), "WITHOUT THE SKILL", font=font(FONT["mono"], 24), fill="#aab6ff")
    draw.text((72, 786), "Invented colors, spacing, cards, and glow.", font=font(FONT["regular"], 27), fill=MUTED)
    draw.text((848, 750), "WITH DESIGN.md + THE SKILL", font=font(FONT["mono"], 24), fill=TERRACOTTA)
    multiline(
        draw,
        (848, 786),
        "Tokens, constraints, mobile checks, and a calmer product surface.",
        font(FONT["regular"], 25),
        PAPER,
        640,
        6,
    )
    draw.text((72, 850), "design-md-for-codex by Dan O'Leary", font=font(FONT["bold"], 22), fill=TERRACOTTA)
    img.save(ASSETS / "share-before-after.png", optimize=True)


def main() -> None:
    ASSETS.mkdir(exist_ok=True)
    save_social_card()
    save_repo_banner()
    save_before_after()
    for path in ["social-card.png", "repo-banner.png", "share-before-after.png"]:
        image = Image.open(ASSETS / path)
        print(f"{path}: {image.width}x{image.height}")


if __name__ == "__main__":
    main()
