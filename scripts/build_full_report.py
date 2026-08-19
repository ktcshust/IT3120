#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_full_report.py — Ghép bản nộp: một file Word duy nhất gồm cả sáu chương.

Lý do tồn tại: Chương 1-2 và phụ lục do A viết thẳng bằng Word (docs/chapter-A.docx),
còn Chương 3-6 do B, C, D viết bằng Markdown trong report/. Bản nộp cuối phải là một
file. Script này ghép hai nguồn đó lại mà không cần thao tác tay trong Word, nên khi
một chương được sửa thì chỉ cần chạy lại là có bản nộp mới.

Thứ tự ghép:
    1. docs/chapter-A.docx  — trang bìa, mục lục, tóm tắt, Chương 1, Chương 2
    2. report/chapter_3_behavior.md    (B)
    3. report/chapter_4_data.md        (C)
    4. report/chapter_5_design.md      (D)
    5. report/chapter_6_conclusion.md  (D)
    6. docs/chapter-A.docx  — phần phụ lục (từ "CHƯƠNG A" đến hết)

Phần phác Chương 3-6 còn sót trong chapter-A.docx bị bỏ qua khi ghép: nó chỉ còn là
đoạn con trỏ tới file Markdown, mà ở bản ghép thì nội dung thật đã nằm ngay tại chỗ.
Bảng 5.2 của A cũng bị bỏ qua vì Bảng 5.8 của D chứa đủ NFR-01…NFR-12 cộng thêm
NFR-13, NFR-14.

Cách dùng:
    python scripts/build_full_report.py
    python scripts/build_full_report.py -o docs/bao_cao_day_du_v2.docx

Phụ thuộc: python-docx. Ảnh sơ đồ lấy từ diagrams/rendered/ — chạy
scripts/render_mermaid_D.py trước nếu vừa sửa sơ đồ Mermaid.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

from docx import Document
from docx.oxml.ns import qn
from docx.shared import Pt, RGBColor
from docx.text.paragraph import Paragraph

sys.path.insert(0, str(Path(__file__).resolve().parent))
from md_to_docx_D import RENDERED_DIR, Converter  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
BASE = ROOT / "docs" / "chapter-A.docx"
CHAPTERS = [
    ROOT / "report" / "chapter_3_behavior.md",
    ROOT / "report" / "chapter_4_data.md",
    ROOT / "report" / "chapter_5_design.md",
    ROOT / "report" / "chapter_6_conclusion.md",
]
DEFAULT_OUT = ROOT / "docs" / "bao_cao_day_du_v1.docx"

# Hai mốc trong chapter-A.docx: nơi phần phác Chương 3 bắt đầu và nơi phụ lục bắt đầu.
STUB_START = "CHƯƠNG 3"
APPENDIX = "CHƯƠNG A"


TOC_HEADING = "MỤC LỤC"
# Mục lục trong chapter-A.docx là chữ tĩnh, không phải trường TOC của Word: số trang
# được gõ thẳng vào cuối dòng, và bốn dòng Chương 3-6 đang trỏ sang file Markdown.
# Cả hai đều sai với bản ghép nên phải chuẩn hoá lại.
TOC_ENTRY_RE = re.compile(r"^(Tóm tắt báo cáo|Chương \d+\..*?|Phụ lục)(?:\s*—\s*report/\S+)?\d*$")


def normalise_toc(doc: Document) -> int:
    """Bỏ số trang và đường dẫn file khỏi các dòng mục lục, chèn ghi chú cập nhật."""
    fixed = 0
    seen_heading = False
    for ch in doc.element.body.iterchildren():
        if ch.tag.split("}")[-1] != "p":
            continue
        p = Paragraph(ch, doc)
        ts = list(p._p.iter(qn("w:t")))
        if not ts:
            continue
        full = "".join(t.text or "" for t in ts).strip()
        if full == TOC_HEADING:
            seen_heading = True
            continue
        if not seen_heading:
            continue
        m = TOC_ENTRY_RE.match(full)
        if not m:
            # Đã đi hết khối mục lục
            if fixed:
                break
            continue
        ts[0].text = m.group(1).rstrip()
        ts[0].set(qn("xml:space"), "preserve")
        for t in ts[1:]:
            t.text = ""
        fixed += 1
        last = p
    if fixed:
        note = last.insert_paragraph_before()
        run = note.add_run(
            "Số trang của mục lục cần được sinh lại trong Word sau khi ghép "
            "(References → Table of Contents), vì bản ghép dài hơn từng phần rời."
        )
        run.italic = True
        run.font.size = Pt(9)
        run.font.color.rgb = RGBColor(0x88, 0x44, 0x00)
        # Ghi chú phải nằm dưới khối mục lục, không phải chen vào giữa
        last._p.addnext(note._p)
    return fixed


def find_marker(doc: Document, text: str) -> int:
    """Vị trí (chỉ số body) của đoạn văn có đúng nội dung `text`."""
    for i, ch in enumerate(doc.element.body.iterchildren()):
        if ch.tag.split("}")[-1] != "p":
            continue
        if Paragraph(ch, doc).text.strip() == text:
            return i
    sys.exit(f"Không tìm thấy mốc {text!r} trong {BASE.name}. "
             "Kiểm tra lại xem chapter-A.docx có bị đổi cấu trúc không.")


def main() -> int:
    ap = argparse.ArgumentParser(description="Ghép sáu chương thành một file .docx")
    ap.add_argument("-o", "--output", default=str(DEFAULT_OUT))
    ap.add_argument("--no-images", action="store_true",
                    help="Không nhúng ảnh sơ đồ, chỉ chèn khung placeholder")
    args = ap.parse_args()

    missing = [str(p) for p in [BASE, *CHAPTERS] if not p.is_file()]
    if missing:
        sys.exit("Không tìm thấy file: " + ", ".join(missing))

    doc = Document(BASE)
    body = doc.element.body

    # 0) Chuẩn hoá mục lục cho bản ghép.
    n_toc = normalise_toc(doc)

    # 1) Bỏ phần phác Chương 3-6 (chỉ còn đoạn con trỏ) khỏi bản ghép.
    start, appendix = find_marker(doc, STUB_START), find_marker(doc, APPENDIX)
    if start >= appendix:
        sys.exit("Thứ tự bất thường: mốc Chương 3 nằm sau mốc phụ lục.")
    children = list(body.iterchildren())
    for el in children[start:appendix]:
        el.getparent().remove(el)

    # 2) Chuyển bốn chương Markdown; nội dung mới rơi xuống cuối tài liệu.
    anchor = find_marker(doc, APPENDIX)
    before = len(list(body.iterchildren()))
    conv = Converter(doc, None if args.no_images else RENDERED_DIR)
    for src in CHAPTERS:
        doc.add_page_break()
        conv.begin_source(src)
        conv.convert(src.read_text(encoding="utf-8"))

    # 3) Chuyển khối vừa sinh lên trước phụ lục, giữ nguyên thứ tự.
    children = list(body.iterchildren())
    anchor_el = children[anchor]
    for el in children[before:]:
        anchor_el.addprevious(el)

    out = Path(args.output)
    out.parent.mkdir(parents=True, exist_ok=True)
    doc.save(out)

    print(f"Đã tạo {out} ({out.stat().st_size / 1024:.0f} KB)")
    print("  nguồn: {} + {} chương Markdown | dòng mục lục đã chuẩn hoá: {}".format(
        BASE.name, len(CHAPTERS), n_toc))
    print("  tiêu đề: {heading} | bảng: {table} | sơ đồ Mermaid: {mermaid} "
          "(nhúng ảnh: {image}) | đoạn văn: {para} | mục danh sách: {list}".format(**conv.stats))
    if conv.stats["mermaid"] > conv.stats["image"]:
        thieu = conv.stats["mermaid"] - conv.stats["image"]
        print(f"  CẢNH BÁO: {thieu} sơ đồ chưa có ảnh render nên chỉ có khung placeholder. "
              "Chạy scripts/render_mermaid_D.py rồi ghép lại.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
