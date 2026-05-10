from __future__ import annotations

import math
import shutil
import textwrap
from pathlib import Path

import imageio.v2 as imageio
import numpy as np
from PIL import Image, ImageDraw, ImageEnhance, ImageFilter, ImageFont


ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "assets"
OUT_DIR = ROOT / "output" / "launch-tonight"
OUT_DIR.mkdir(parents=True, exist_ok=True)

WIDTH = 1280
HEIGHT = 720
FPS = 24
DURATION = 20

VOID = "#0F1012"
SURFACE = "#17191D"
SURFACE_2 = "#1F2228"
LINE = "#2A2C30"
TEXT = "#FFFFFF"
MUTED = "#B8B8B8"
PAPER = "#F5F4ED"
INK = "#121417"
TERRACOTTA = "#C96442"


def font_path(name: str) -> str:
    candidates = [
        Path("C:/Windows/Fonts") / name,
        Path("C:/Windows/Fonts") / name.lower(),
    ]
    for candidate in candidates:
        if candidate.exists():
            return str(candidate)
    return "arial.ttf"


FONT_BOLD = font_path("segoeuib.ttf")
FONT_REGULAR = font_path("segoeui.ttf")
FONT_MONO = font_path("consola.ttf")


def font(size: int, bold: bool = False, mono: bool = False) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(FONT_MONO if mono else (FONT_BOLD if bold else FONT_REGULAR), size)


def ease(t: float) -> float:
    t = max(0.0, min(1.0, t))
    return 1 - pow(1 - t, 3)


def lerp(a: float, b: float, t: float) -> float:
    return a + (b - a) * t


def rounded(draw: ImageDraw.ImageDraw, box: tuple[int, int, int, int], radius: int, fill: str, outline: str | None = None, width: int = 1):
    draw.rounded_rectangle(box, radius=radius, fill=fill, outline=outline, width=width)


def cover_image(path: Path, size: tuple[int, int], crop_anchor: tuple[float, float] = (0.5, 0.5)) -> Image.Image:
    img = Image.open(path).convert("RGB")
    scale = max(size[0] / img.width, size[1] / img.height)
    new = img.resize((int(img.width * scale), int(img.height * scale)), Image.Resampling.LANCZOS)
    x = int((new.width - size[0]) * crop_anchor[0])
    y = int((new.height - size[1]) * crop_anchor[1])
    return new.crop((x, y, x + size[0], y + size[1]))


def contain_image(path: Path, size: tuple[int, int], bg: str = SURFACE) -> Image.Image:
    img = Image.open(path).convert("RGB")
    img.thumbnail(size, Image.Resampling.LANCZOS)
    out = Image.new("RGB", size, bg)
    out.paste(img, ((size[0] - img.width) // 2, (size[1] - img.height) // 2))
    return out


def paste_card(base: Image.Image, img: Image.Image, box: tuple[int, int, int, int], radius: int = 12, shadow: bool = True):
    x1, y1, x2, y2 = box
    w, h = x2 - x1, y2 - y1
    img = img.resize((w, h), Image.Resampling.LANCZOS)
    mask = Image.new("L", (w, h), 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, w, h), radius=radius, fill=255)
    if shadow:
        shadow_img = Image.new("RGBA", (w + 40, h + 40), (0, 0, 0, 0))
        shadow_mask = Image.new("L", (w, h), 0)
        ImageDraw.Draw(shadow_mask).rounded_rectangle((0, 0, w, h), radius=radius, fill=110)
        shadow_img.paste((0, 0, 0, 160), (20, 20), shadow_mask)
        shadow_img = shadow_img.filter(ImageFilter.GaussianBlur(18))
        base.paste(shadow_img.convert("RGB"), (x1 - 20, y1 - 16), shadow_img)
    base.paste(img, (x1, y1), mask)
    draw = ImageDraw.Draw(base)
    draw.rounded_rectangle(box, radius=radius, outline=LINE, width=2)


def draw_wrapped(draw: ImageDraw.ImageDraw, text: str, xy: tuple[int, int], max_chars: int, fill: str, fnt: ImageFont.FreeTypeFont, gap: int = 8):
    x, y = xy
    for line in textwrap.wrap(text, width=max_chars):
        draw.text((x, y), line, font=fnt, fill=fill)
        y += fnt.size + gap
    return y


def base_frame() -> Image.Image:
    img = Image.new("RGB", (WIDTH, HEIGHT), VOID)
    draw = ImageDraw.Draw(img)
    for i in range(0, WIDTH, 40):
        shade = int(14 + 10 * (i / WIDTH))
        draw.line((i, 0, i - 240, HEIGHT), fill=(shade, shade, shade), width=1)
    draw.rectangle((0, 0, WIDTH, HEIGHT), outline="#000000", width=1)
    draw.ellipse((-260, 420, 360, 1040), fill="#16110F")
    return img.filter(ImageFilter.GaussianBlur(0.2))


def label(draw: ImageDraw.ImageDraw, text: str, x: int, y: int):
    w = int(draw.textlength(text, font=font(14, bold=True))) + 26
    draw.rounded_rectangle((x, y, x + w, y + 28), radius=6, fill="#211713", outline="#5F2D20")
    draw.text((x + 12, y + 6), text, font=font(14, bold=True), fill=TERRACOTTA)


def frame_at(second: float) -> Image.Image:
    img = base_frame()
    draw = ImageDraw.Draw(img)
    scene = int(second // 4)
    local = (second % 4) / 4
    e = ease(local)

    if scene == 0:
        label(draw, "Codex skill + DESIGN.md", 84, 80)
        draw.text((84, 132), "Make Codex", font=font(78, bold=True), fill=TEXT)
        draw.text((84, 220), "remember", font=font(78, bold=True), fill=TEXT)
        draw.text((84, 308), "your taste.", font=font(78, bold=True), fill=TEXT)
        draw_wrapped(draw, "Install one tiny skill. Add DESIGN.md. Make every UI pass start from your rules.", (88, 430), 42, MUTED, font(28), 10)
        hero = contain_image(ASSETS / "hero-art.png", (560, 360), bg=PAPER)
        x = int(650 + 24 * math.sin(second * 0.8))
        paste_card(img, hero, (x, 150, x + 520, 485), radius=14)
        draw.rounded_rectangle((88, 572, 450, 622), radius=8, fill=TERRACOTTA)
        draw.text((112, 585), "Use $skill-installer", font=font(22, bold=True, mono=True), fill=TEXT)

    elif scene == 1:
        label(draw, "Before", 84, 70)
        draw.text((84, 126), "Generic soup.", font=font(76, bold=True), fill=TEXT)
        draw.text((84, 216), "New screen,", font=font(54, bold=True), fill=TEXT)
        draw.text((84, 282), "new guess.", font=font(54, bold=True), fill=TEXT)
        y = draw_wrapped(draw, "Invented colors. Mystery spacing. Big rounded cards. UI drift by default.", (88, 390), 38, MUTED, font(26), 9)
        for n, chip in enumerate(["Papyrus", "glow", "random radii", "blue-purple gradient"]):
            cy = y + 30 + n * 42
            draw.rounded_rectangle((88, cy, 360, cy + 30), radius=15, fill="#211713", outline="#5F2D20")
            draw.text((106, cy + 5), chip, font=font(15, bold=True), fill="#F0C6B5")
        before = contain_image(ASSETS / "proof" / "fixture-before.png", (560, 380), bg=PAPER)
        zoom = 1 + e * 0.035
        bw, bh = int(560 * zoom), int(380 * zoom)
        before = before.resize((bw, bh), Image.Resampling.LANCZOS).crop(((bw - 560) // 2, (bh - 380) // 2, (bw + 560) // 2, (bh + 380) // 2))
        paste_card(img, before, (620, 150, 1180, 530), radius=14)

    elif scene == 2:
        label(draw, "The habit", 84, 70)
        draw.text((84, 126), "DESIGN.md", font=font(74, bold=True), fill=TEXT)
        draw.text((84, 214), "is the memory.", font=font(58, bold=True), fill=TEXT)
        draw.text((84, 294), "The skill is", font=font(58, bold=True), fill=TEXT)
        draw.text((84, 362), "the habit.", font=font(58, bold=True), fill=TEXT)
        code_box = (620, 130, 1180, 500)
        rounded(draw, code_box, 12, "#0B0C0E", "#33363B", 2)
        draw.text((652, 164), "> Codex", font=font(21, bold=True, mono=True), fill=MUTED)
        draw.rounded_rectangle((652, 216, 1030, 268), radius=8, fill="#1B1412", outline="#7A3726")
        draw.text((672, 230), "1. Read DESIGN.md", font=font(21, bold=True, mono=True), fill=TERRACOTTA)
        lines = [
            "2. Apply tokens",
            "3. Refactor UI",
            "4. Check desktop/mobile",
            "ready to build",
        ]
        for i, line in enumerate(lines):
            color = TEXT if i < 3 else "#25A784"
            draw.text((672, 308 + i * 40), line, font=font(20, mono=True), fill=color)
        draw.rounded_rectangle((88, 552, 760, 634), radius=8, fill=PAPER)
        draw.text((112, 570), "Use $skill-installer to install", font=font(20, bold=True, mono=True), fill=INK)
        draw.text((112, 600), "github.com/danieloleary/design-md-for-codex", font=font(18, mono=True), fill=INK)

    elif scene == 3:
        label(draw, "After", 84, 70)
        draw.text((84, 126), "Governed", font=font(76, bold=True), fill=TEXT)
        draw.text((84, 214), "workbench.", font=font(76, bold=True), fill=TEXT)
        draw_wrapped(draw, "Codex reads DESIGN.md, applies the rules, and checks the page across desktop and mobile.", (88, 330), 38, MUTED, font(26), 9)
        after = contain_image(ASSETS / "proof" / "fixture-after.png", (590, 395), bg=SURFACE)
        paste_card(img, after, (590, 120, 1180, 515), radius=14)
        for i, (k, v) in enumerate([("Tokens", "applied"), ("Radii", "8px"), ("Accent", "terracotta")]):
            x = 88 + i * 155
            draw.rounded_rectangle((x, 560, x + 132, 622), radius=8, fill=SURFACE, outline=LINE)
            draw.text((x + 14, 572), k, font=font(15, bold=True), fill=MUTED)
            draw.text((x + 14, 594), v, font=font(18, bold=True), fill=TEXT)

    else:
        share = contain_image(ASSETS / "share-before-after.png", (560, 294), bg=VOID)
        paste_card(img, share, (630, 122, 1190, 416), radius=12)
        label(draw, "Ship it", 84, 80)
        draw.text((84, 140), "One prompt.", font=font(58, bold=True), fill=TEXT)
        draw.text((84, 210), "One DESIGN.md.", font=font(58, bold=True), fill=TEXT)
        draw.text((84, 280), "Less slop.", font=font(58, bold=True), fill=TEXT)
        draw_wrapped(draw, "design-md-for-codex by Dan O'Leary", (88, 408), 42, MUTED, font(24), 8)
        rounded(draw, (84, 548, 1035, 618), 10, PAPER, None)
        draw.text((112, 570), "github.com/danieloleary/design-md-for-codex", font=font(28, bold=True, mono=True), fill=INK)
        draw.rectangle((84, 648, 1198, 652), fill=TERRACOTTA)

    return img


def main():
    frames = []
    total = DURATION * FPS
    for i in range(total):
        frames.append(np.asarray(frame_at(i / FPS)))

    mp4 = OUT_DIR / "design-md-for-codex-demo.mp4"
    gif = OUT_DIR / "design-md-for-codex-demo.gif"
    asset_mp4 = ASSETS / "demo-video.mp4"
    asset_thumb = ASSETS / "demo-video-thumbnail.png"
    imageio.mimsave(mp4, frames, fps=FPS, quality=8, macro_block_size=16)
    imageio.mimsave(gif, frames[::3], fps=FPS // 3)
    thumb = frame_at(16.5)
    thumbnail = OUT_DIR / "design-md-for-codex-demo-thumbnail.png"
    thumb.save(thumbnail)
    shutil.copyfile(mp4, asset_mp4)
    shutil.copyfile(thumbnail, asset_thumb)
    print(mp4)
    print(gif)
    print(thumbnail)
    print(asset_mp4)
    print(asset_thumb)


if __name__ == "__main__":
    main()
