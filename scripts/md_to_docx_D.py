#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
md_to_docx_D.py — Chuyển chương báo cáo viết bằng Markdown sang .docx để ghép vào
báo cáo Word chung của nhóm (bản gốc do Person A giữ: docs/chapter-A.docx).

Người viết: D (System & UI Designer)
Phiên bản: v1

Lý do tồn tại: Chương 3 (B), Chương 4 (C) và Chương 5-6 (D) đều viết bằng Markdown để
git theo dõi được thay đổi, trong khi bản nộp cuối cùng là một file Word duy nhất.
Script này làm bước chuyển đổi đó mà không cần cài pandoc/LibreOffice.

Cách dùng:
    python3 scripts/md_to_docx_D.py report/chapter_5_design.md report/chapter_6_conclusion.md \
        -o docs/chapter_5_6_D.docx

Phụ thuộc: python-docx (đã có sẵn trong môi trường).

Phạm vi hỗ trợ Markdown:
    - Tiêu đề  #  ->  ######
    - Đoạn văn, in đậm **...**, in nghiêng *...*, mã nội dòng `...`
    - Bảng dạng ống (| a | b |) kèm dòng phân cách ---
    - Danh sách gạch đầu dòng và danh sách đánh số (một cấp và hai cấp)
    - Khối mã ``` ... ```
    - Khối ```mermaid: nếu đã có ảnh render tương ứng trong diagrams/rendered/ thì
      ảnh được nhúng thẳng vào file Word (đặt tên theo đúng quy ước của
      scripts/render_mermaid_D.py: <slug-tên-file-nguồn>-NN.png). Nếu chưa render thì
      giữ hành vi cũ: một khung có chú thích kèm mã nguồn sơ đồ để chèn ảnh thủ công.
      Dùng --no-images để luôn chèn khung thay vì ảnh.
    - Đường kẻ ngang ---
    - Trích dẫn > ...
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

try:
    from docx import Document
    from docx.enum.table import WD_TABLE_ALIGNMENT
    from docx.enum.text import WD_ALIGN_PARAGRAPH
    from docx.oxml import OxmlElement
    from docx.oxml.ns import qn
    from docx.shared import Inches, Pt, RGBColor
except ImportError:  # pragma: no cover
    sys.exit("Thiếu thư viện python-docx. Cài bằng: pip install python-docx")

ROOT = Path(__file__).resolve().parent.parent
RENDERED_DIR = ROOT / "diagrams" / "rendered"
# Khổ giấy mặc định của python-docx là Letter với lề 1 inch -> vùng chữ rộng 6,5 inch.
# Để 6,2 inch cho sơ đồ để còn khoảng thở hai bên khi in.
MAX_IMG_WIDTH = Inches(6.2)


# --------------------------------------------------------------------------
# Tiện ích định dạng
# --------------------------------------------------------------------------

INLINE_RE = re.compile(
    r"(\*\*.+?\*\*"       # in đậm
    r"|\*[^*\n]+?\*"      # in nghiêng
    r"|`[^`\n]+?`"        # mã nội dòng
    r"|\[[^\]]+?\]\([^)]+?\))"  # liên kết
)
LINK_RE = re.compile(r"\[([^\]]+?)\]\(([^)]+?)\)")


def add_inline(paragraph, text: str, base_bold: bool = False) -> None:
    """Ghi text vào paragraph, xử lý **đậm**, *nghiêng*, `mã` và [nhãn](đường dẫn)."""
    for piece in INLINE_RE.split(text):
        if not piece:
            continue
        if piece.startswith("**") and piece.endswith("**") and len(piece) > 4:
            run = paragraph.add_run(piece[2:-2])
            run.bold = True
        elif piece.startswith("`") and piece.endswith("`") and len(piece) > 2:
            run = paragraph.add_run(piece[1:-1])
            run.font.name = "Consolas"
            run.font.size = Pt(10)
            run.font.color.rgb = RGBColor(0xB0, 0x30, 0x60)
        elif LINK_RE.fullmatch(piece):
            label, target = LINK_RE.fullmatch(piece).groups()
            run = paragraph.add_run(label)
            run.italic = True
            hint = paragraph.add_run(f" ({target})")
            hint.font.size = Pt(9)
            hint.font.color.rgb = RGBColor(0x66, 0x66, 0x66)
        elif piece.startswith("*") and piece.endswith("*") and len(piece) > 2:
            run = paragraph.add_run(piece[1:-1])
            run.italic = True
        else:
            run = paragraph.add_run(piece)
        if base_bold:
            run.bold = True


def shade(cell, hex_color: str) -> None:
    """Tô nền một ô bảng (python-docx không có API sẵn cho việc này)."""
    tc_pr = cell._tc.get_or_add_tcPr()
    shd = OxmlElement("w:shd")
    shd.set(qn("w:val"), "clear")
    shd.set(qn("w:color"), "auto")
    shd.set(qn("w:fill"), hex_color)
    tc_pr.append(shd)


def split_row(line: str) -> list[str]:
    """Tách một dòng bảng Markdown thành danh sách ô, bỏ qua | nằm trong `mã`."""
    line = line.strip()
    if line.startswith("|"):
        line = line[1:]
    if line.endswith("|"):
        line = line[:-1]
    cells, buf, in_code = [], "", False
    for ch in line:
        if ch == "`":
            in_code = not in_code
            buf += ch
        elif ch == "|" and not in_code:
            cells.append(buf.strip())
            buf = ""
        else:
            buf += ch
    cells.append(buf.strip())
    return cells


def is_separator(line: str) -> bool:
    """Nhận diện dòng phân cách của bảng Markdown: |---|:---:|---|"""
    stripped = line.strip()
    if "|" not in stripped or "-" not in stripped:
        return False
    return all(re.fullmatch(r":?-{2,}:?", c) for c in split_row(stripped) if c)


def slugify(text: str) -> str:
    """Bản sao đúng nguyên logic của scripts/render_mermaid_D.py.

    Hai script phải sinh ra cùng một chuỗi thì mới tra được ảnh render theo tên file,
    nên nếu sửa hàm này thì phải sửa cả hai nơi.
    """
    text = text.lower()
    vn = {
        "àáạảãâầấậẩẫăằắặẳẵ": "a", "èéẹẻẽêềếệểễ": "e", "ìíịỉĩ": "i",
        "òóọỏõôồốộổỗơờớợởỡ": "o", "ùúụủũưừứựửữ": "u", "ỳýỵỷỹ": "y", "đ": "d",
    }
    for chars, repl in vn.items():
        for ch in chars:
            text = text.replace(ch, repl)
    text = re.sub(r"[^a-z0-9]+", "-", text)
    return re.sub(r"-{2,}", "-", text).strip("-")[:60] or "diagram"


# --------------------------------------------------------------------------
# Bộ chuyển đổi
# --------------------------------------------------------------------------

class Converter:
    def __init__(self, doc: Document, images_dir: Path | None = RENDERED_DIR) -> None:
        self.doc = doc
        self.images_dir = images_dir
        self.slug = ""        # slug của file .md đang chuyển, để tra tên ảnh
        self.mermaid_n = 0    # thứ tự sơ đồ trong file đó, đếm lại từ 1 mỗi file
        self.stats = {"heading": 0, "table": 0, "code": 0, "mermaid": 0,
                      "image": 0, "para": 0, "list": 0}

    def begin_source(self, src: Path) -> None:
        """Bắt đầu một file nguồn mới: đặt lại bộ đếm sơ đồ và slug tra ảnh."""
        self.slug = slugify(src.stem)
        self.mermaid_n = 0

    # -- ảnh render ------------------------------------------------------
    def find_rendered(self) -> Path | None:
        """Ảnh do render_mermaid_D.py sinh ra: <slug>-NN.png, NN đếm từ 01."""
        if not self.images_dir or not self.slug:
            return None
        png = self.images_dir / f"{self.slug}-{self.mermaid_n:02d}.png"
        return png if png.is_file() else None

    def add_image(self, png: Path) -> None:
        self.stats["image"] += 1
        para = self.doc.add_paragraph()
        para.alignment = WD_ALIGN_PARAGRAPH.CENTER
        para.add_run().add_picture(str(png), width=MAX_IMG_WIDTH)

    # -- khối mã ---------------------------------------------------------
    def add_code_block(self, lines: list[str], lang: str) -> None:
        is_mermaid = lang.lower() == "mermaid"
        if is_mermaid:
            self.stats["mermaid"] += 1
            self.mermaid_n += 1
            png = self.find_rendered()
            if png is not None:
                # Đã có ảnh render thì nhúng thẳng; mã nguồn sơ đồ vẫn nằm ở file .md
                # nên không cần lặp lại trong bản Word.
                self.add_image(png)
                return
            note = self.doc.add_paragraph()
            note.paragraph_format.space_before = Pt(6)
            run = note.add_run(
                "[Sơ đồ Mermaid — chèn ảnh render vào vị trí này khi lên bản in. "
                "Mã nguồn sơ đồ giữ nguyên bên dưới để đối chiếu.]"
            )
            run.italic = True
            run.font.size = Pt(9)
            run.font.color.rgb = RGBColor(0x88, 0x44, 0x00)
        else:
            self.stats["code"] += 1

        table = self.doc.add_table(rows=1, cols=1)
        table.style = "Table Grid"
        cell = table.cell(0, 0)
        shade(cell, "F5F5F5" if not is_mermaid else "FFF8E7")
        cell.text = ""
        for i, raw in enumerate(lines):
            para = cell.paragraphs[0] if i == 0 else cell.add_paragraph()
            para.paragraph_format.space_after = Pt(0)
            para.paragraph_format.line_spacing = 1.0
            run = para.add_run(raw)
            run.font.name = "Consolas"
            run.font.size = Pt(8.5)
        self.doc.add_paragraph()

    # -- bảng ------------------------------------------------------------
    def add_table(self, rows: list[list[str]]) -> None:
        self.stats["table"] += 1
        ncols = max(len(r) for r in rows)
        table = self.doc.add_table(rows=len(rows), cols=ncols)
        table.style = "Table Grid"
        table.alignment = WD_TABLE_ALIGNMENT.CENTER
        for r, row in enumerate(rows):
            for c in range(ncols):
                cell = table.cell(r, c)
                cell.text = ""
                para = cell.paragraphs[0]
                para.paragraph_format.space_after = Pt(2)
                text = row[c] if c < len(row) else ""
                add_inline(para, text.replace("<br>", " "), base_bold=(r == 0))
                for run in para.runs:
                    run.font.size = Pt(9.5)
                if r == 0:
                    shade(cell, "E8EDF5")
        self.doc.add_paragraph()

    # -- vòng lặp chính --------------------------------------------------
    def convert(self, md: str) -> None:
        lines = md.splitlines()
        i = 0
        while i < len(lines):
            line = lines[i]
            stripped = line.strip()

            # khối mã
            if stripped.startswith("```"):
                lang = stripped[3:].strip()
                body, i = [], i + 1
                while i < len(lines) and not lines[i].strip().startswith("```"):
                    body.append(lines[i])
                    i += 1
                i += 1
                self.add_code_block(body, lang)
                continue

            # bảng
            if "|" in stripped and i + 1 < len(lines) and is_separator(lines[i + 1]):
                rows = [split_row(stripped)]
                i += 2
                while i < len(lines) and "|" in lines[i] and lines[i].strip():
                    rows.append(split_row(lines[i]))
                    i += 1
                self.add_table(rows)
                continue

            # dòng trống
            if not stripped:
                i += 1
                continue

            # đường kẻ ngang
            if re.fullmatch(r"[-*_]{3,}", stripped):
                para = self.doc.add_paragraph()
                para.paragraph_format.space_before = Pt(2)
                para.paragraph_format.space_after = Pt(2)
                pbdr = OxmlElement("w:pBdr")
                bottom = OxmlElement("w:bottom")
                bottom.set(qn("w:val"), "single")
                bottom.set(qn("w:sz"), "6")
                bottom.set(qn("w:color"), "BBBBBB")
                pbdr.append(bottom)
                para._p.get_or_add_pPr().append(pbdr)
                i += 1
                continue

            # tiêu đề
            m = re.match(r"^(#{1,6})\s+(.*)$", stripped)
            if m:
                level = len(m.group(1))
                text = m.group(2).strip().rstrip("#").strip()
                head = self.doc.add_heading(level=min(level, 4))
                add_inline(head, text)
                self.stats["heading"] += 1
                i += 1
                continue

            # trích dẫn
            if stripped.startswith(">"):
                para = self.doc.add_paragraph()
                para.paragraph_format.left_indent = Pt(24)
                add_inline(para, stripped.lstrip("> ").strip())
                for run in para.runs:
                    run.italic = True
                    run.font.color.rgb = RGBColor(0x55, 0x55, 0x55)
                i += 1
                continue

            # danh sách
            indent = len(line) - len(line.lstrip(" "))
            bullet = re.match(r"^[-*+]\s+(.*)$", stripped)
            number = re.match(r"^\d+[.)]\s+(.*)$", stripped)
            if bullet or number:
                style = "List Number" if number else "List Bullet"
                if indent >= 2:
                    style += " 2"
                para = self.doc.add_paragraph(style=style)
                add_inline(para, (number or bullet).group(1))
                self.stats["list"] += 1
                i += 1
                continue

            # đoạn văn: gộp các dòng liên tiếp
            buf = [stripped]
            i += 1
            while i < len(lines):
                nxt = lines[i].strip()
                if (not nxt or nxt.startswith(("#", "|", ">", "```"))
                        or re.match(r"^[-*+]\s+", nxt) or re.match(r"^\d+[.)]\s+", nxt)
                        or re.fullmatch(r"[-*_]{3,}", nxt)):
                    break
                buf.append(nxt)
                i += 1
            para = self.doc.add_paragraph()
            para.paragraph_format.space_after = Pt(6)
            para.alignment = WD_ALIGN_PARAGRAPH.JUSTIFY
            add_inline(para, " ".join(buf))
            self.stats["para"] += 1


def build(sources: list[Path], out: Path, images_dir: Path | None = RENDERED_DIR) -> dict:
    doc = Document()

    style = doc.styles["Normal"]
    style.font.name = "Times New Roman"
    style.font.size = Pt(12)
    style.element.rPr.rFonts.set(qn("w:eastAsia"), "Times New Roman")

    conv = Converter(doc, images_dir)
    for idx, src in enumerate(sources):
        if idx > 0:
            doc.add_page_break()
        conv.begin_source(src)
        conv.convert(src.read_text(encoding="utf-8"))

    out.parent.mkdir(parents=True, exist_ok=True)
    doc.save(out)
    return conv.stats


def main() -> int:
    ap = argparse.ArgumentParser(description="Chuyển chương Markdown sang .docx")
    ap.add_argument("inputs", nargs="+", help="Các file .md theo đúng thứ tự ghép")
    ap.add_argument("-o", "--output", required=True, help="Đường dẫn file .docx đầu ra")
    ap.add_argument("--no-images", action="store_true",
                    help="Không nhúng ảnh render; luôn chèn khung placeholder kèm mã sơ đồ")
    args = ap.parse_args()

    sources = [Path(p) for p in args.inputs]
    missing = [str(p) for p in sources if not p.is_file()]
    if missing:
        sys.exit("Không tìm thấy file: " + ", ".join(missing))

    out = Path(args.output)
    stats = build(sources, out, None if args.no_images else RENDERED_DIR)
    size_kb = out.stat().st_size / 1024
    print(f"Đã tạo {out} ({size_kb:.0f} KB)")
    print("  tiêu đề: {heading} | bảng: {table} | sơ đồ Mermaid: {mermaid} "
          "(nhúng ảnh: {image}) | khối mã khác: {code} | đoạn văn: {para} | "
          "mục danh sách: {list}".format(**stats))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
