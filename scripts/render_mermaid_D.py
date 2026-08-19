#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
render_mermaid_D.py — Render mọi sơ đồ Mermaid trong báo cáo thành ảnh PNG.

Người viết: D (System & UI Designer — phụ trách ghép báo cáo và slide)
Phiên bản: v1

Lý do tồn tại: cả nhóm viết diagram bằng Mermaid trong Markdown (quyết định ghi ở
docs/change_log.md, 2026-08-06). Bản nộp cuối là file Word và slide, cả hai đều cần
ảnh tĩnh. Script này render toàn bộ sơ đồ của A/B/C/D thành PNG với tên file ổn định,
kèm một trang mục lục để biết ảnh nào ứng với hình nào trong chương nào.

Cách dùng:
    python3 scripts/render_mermaid_D.py                 # render toàn bộ file mặc định
    python3 scripts/render_mermaid_D.py report/chapter_5_design.md   # chỉ một file

Yêu cầu: node + npx (tải @mermaid-js/mermaid-cli lần đầu, sau đó dùng cache npx) và
Google Chrome đã cài sẵn. Không cần cài pandoc hay LibreOffice.

Đường dẫn Chrome được dò tự động theo hệ điều hành (macOS, Windows, Linux); có thể
ghi đè bằng biến môi trường CHROME_PATH nếu cài ở chỗ khác.

Đầu ra: diagrams/rendered/<slug>-NN.png và diagrams/rendered/README.md
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT_DIR = ROOT / "diagrams" / "rendered"
MMDC_PKG = "@mermaid-js/mermaid-cli@10.9.1"

# Mỗi người trong nhóm dùng một hệ điều hành khác nhau nên đường dẫn Chrome không thể
# ghi cứng một giá trị. Thứ tự dò: biến môi trường -> vị trí mặc định theo OS -> PATH.
CHROME_CANDIDATES = [
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",   # macOS
    r"C:\Program Files\Google\Chrome\Application\chrome.exe",          # Windows
    r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    os.path.expandvars(r"%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"),
    "/usr/bin/google-chrome",                                          # Linux
    "/usr/bin/chromium",
]


def find_chrome() -> str:
    """Trả về đường dẫn Chrome đầu tiên tồn tại, hoặc thoát kèm hướng dẫn."""
    env = os.environ.get("CHROME_PATH")
    if env and Path(env).exists():
        return env
    for cand in CHROME_CANDIDATES:
        if cand and Path(cand).exists():
            return cand
    found = shutil.which("google-chrome") or shutil.which("chrome") or shutil.which("chromium")
    if found:
        return found
    sys.exit(
        "Không tìm thấy Google Chrome. Đặt biến môi trường CHROME_PATH trỏ tới file thực thi, "
        "ví dụ:\n"
        '  macOS   : export CHROME_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"\n'
        '  Windows : $env:CHROME_PATH="C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"'
    )

# Thứ tự này quyết định thứ tự trong trang mục lục — bám thứ tự chương của báo cáo.
DEFAULT_SOURCES = [
    "diagrams/B_act_recruitment_flow_v1.md",
    "diagrams/B_act_offer_approval_v1.md",
    "diagrams/B_state_application_v1.md",
    "diagrams/B_state_interview_v1.md",
    "diagrams/B_seq_schedule_interview_v1.md",
    "diagrams/B_seq_offer_approval_v1.md",
    "diagrams/B_seq_sla_feedback_v1.md",
    "report/chapter_3_behavior.md",
    "diagrams/C_domain_model_v1.md",
    "diagrams/C_class_diagram_v1.md",
    "diagrams/C_erd_v1.md",
    "report/chapter_4_data.md",
    "diagrams/D_comp_architecture_v1.md",
    "diagrams/D_deploy_topology_v1.md",
    "report/chapter_5_design.md",
    "report/chapter_6_conclusion.md",
    "wireframes/README.md",
]

FENCE_RE = re.compile(r"^```mermaid\s*$", re.I)
HEADING_RE = re.compile(r"^(#{1,6})\s+(.*)$")
CAPTION_RE = re.compile(r"(Hình|Sơ đồ|Mã Mermaid)\s+[\dA-Z]+[.\-]?\d*\s*[—\-–:]\s*(.+)")

OWNER = {"A": "Person A", "B": "Person B", "C": "Person C", "D": "Person D"}


def slugify(text: str) -> str:
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


def _caption_below(lines: list[str], idx: int, lookahead: int = 3) -> str:
    """Caption đặt NGAY DƯỚI khối mermaid (kiểu `*Hình 5.21 — …*` của wireframes/README.md).

    Chỉ nhìn tối đa `lookahead` dòng có nội dung ngay sau khối và dừng lại khi gặp
    một khối mermaid mới, để không nhặt nhầm caption của sơ đồ kế tiếp.
    """
    seen = 0
    for line in lines[idx + 1:]:
        stripped = line.strip()
        if not stripped:
            continue
        if FENCE_RE.match(stripped) or HEADING_RE.match(stripped):
            return ""
        m = CAPTION_RE.search(stripped)
        if m:
            return m.group(0).strip().strip("*_ ")
        seen += 1
        if seen >= lookahead:
            return ""
    return ""


def extract_blocks(md_path: Path) -> list[dict]:
    """Trả về danh sách sơ đồ kèm ngữ cảnh (tiêu đề mục, caption phía trên hoặc phía dưới)."""
    lines = md_path.read_text(encoding="utf-8").splitlines()
    blocks: list[dict] = []
    heading = ""
    caption = ""
    i = 0
    while i < len(lines):
        line = lines[i]
        h = HEADING_RE.match(line.strip())
        if h:
            heading = h.group(2).strip()
            cap = CAPTION_RE.search(heading)
            if cap:
                caption = heading
        elif CAPTION_RE.search(line):
            caption = CAPTION_RE.search(line).group(0).strip().strip("*_ ")

        if FENCE_RE.match(line.strip()):
            body, i = [], i + 1
            while i < len(lines) and not lines[i].strip().startswith("```"):
                body.append(lines[i])
                i += 1
            code = "\n".join(body).strip()
            if code:
                kind = code.split("\n", 1)[0].split()[0] if code.split() else "?"
                # Caption đặt dưới khối được ưu tiên: nếu tệp dùng quy ước đó thì
                # caption "gần nhất phía trên" chính là caption của sơ đồ TRƯỚC,
                # dùng nó sẽ làm cả danh mục lệch một bậc.
                below = _caption_below(lines, i)
                blocks.append({
                    "code": code,
                    "heading": heading,
                    "caption": below or caption or heading,
                    "kind": kind,
                })
                caption = ""  # caption chỉ dùng cho đúng một sơ đồ ngay dưới nó
        i += 1
    return blocks


def find_npx() -> str:
    """Trên Windows npx là npx.cmd; subprocess không tự tìm ra nên phải giải đường dẫn."""
    npx = shutil.which("npx")
    if not npx:
        sys.exit("Không tìm thấy npx. Cài Node.js rồi chạy lại.")
    return npx


def render(code: str, out_png: Path, tmp: Path, puppeteer_cfg: Path, npx: str) -> tuple[bool, str]:
    mmd = tmp / "d.mmd"
    mmd.write_text(code + "\n", encoding="utf-8")
    cmd = [
        npx, "--yes", MMDC_PKG,
        "-i", str(mmd), "-o", str(out_png),
        "-w", "1800", "-s", "2", "-b", "white",
        "-p", str(puppeteer_cfg),
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if out_png.is_file() and out_png.stat().st_size > 1500:
        return True, ""
    err = (proc.stderr or proc.stdout or "").strip().splitlines()
    if not err:
        return False, "không rõ nguyên nhân"
    # Giữ thông điệp lỗi thật (Parse error …) cùng vài dòng ngữ cảnh ngay sau nó,
    # thay vì ba dòng cuối của stack trace npx. Nối bằng " / " vì " | " làm vỡ bảng.
    keep: list[str] = []
    started = False
    for raw in err:
        line = raw.strip()
        if line.startswith("at ") or not line:
            continue
        if not started and "error" in line.lower():
            started = True
        if started:
            keep.append(line)
        if len(keep) >= 5:
            break
    if not keep:
        keep = [l.strip() for l in err[-3:]]
    return False, " / ".join(keep)


def main() -> int:
    ap = argparse.ArgumentParser(description="Render sơ đồ Mermaid ra PNG")
    ap.add_argument("sources", nargs="*", help="Các file .md cần render (mặc định: toàn bộ báo cáo)")
    ap.add_argument("--out", default=str(OUT_DIR), help="Thư mục ảnh đầu ra")
    args = ap.parse_args()

    chrome = find_chrome()
    npx = find_npx()
    print(f"Chrome: {chrome}\nnpx   : {npx}")

    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)

    wanted = args.sources or DEFAULT_SOURCES
    sources = []
    skipped = []
    for rel in wanted:
        p = ROOT / rel if not Path(rel).is_absolute() else Path(rel)
        (sources if p.is_file() else skipped).append(p if p.is_file() else rel)

    tmp = Path(tempfile.mkdtemp(prefix="mmd_"))
    cfg = tmp / "puppeteer.json"
    cfg.write_text(json.dumps({
        "executablePath": chrome,
        "args": ["--no-sandbox", "--disable-gpu", "--disable-dev-shm-usage"],
    }), encoding="utf-8")

    index: list[dict] = []
    ok_count = fail_count = 0
    try:
        for src in sources:
            rel = src.relative_to(ROOT)
            owner = OWNER.get(src.name[0], "Nhóm")
            blocks = extract_blocks(src)
            if not blocks:
                continue
            print(f"\n{rel} — {len(blocks)} sơ đồ")
            base = slugify(src.stem)
            for n, blk in enumerate(blocks, start=1):
                png = out_dir / f"{base}-{n:02d}.png"
                ok, err = render(blk["code"], png, tmp, cfg, npx)
                status = "OK " if ok else "LỖI"
                size = f"{png.stat().st_size // 1024} KB" if ok else "-"
                print(f"  [{status}] {png.name:<48} {blk['kind']:<16} {size} {err}")
                ok_count += ok
                fail_count += not ok
                index.append({
                    "png": png.name if ok else "",
                    "source": str(rel),
                    "owner": owner,
                    "caption": blk["caption"] or blk["heading"],
                    "kind": blk["kind"],
                    "ok": ok,
                    "error": err,
                })
    finally:
        shutil.rmtree(tmp, ignore_errors=True)

    # Trang mục lục
    lines = [
        "# Ảnh render của các sơ đồ Mermaid",
        "",
        "*Sinh tự động bằng `scripts/render_mermaid_D.py` (Person D). "
        "Không sửa tay các file trong thư mục này — sửa sơ đồ ở file Markdown nguồn rồi chạy lại script.*",
        "",
        "```bash",
        "python3 scripts/render_mermaid_D.py",
        "```",
        "",
        f"**Kết quả lần chạy gần nhất:** {ok_count} sơ đồ render thành công"
        + (f", {fail_count} lỗi." if fail_count else "."),
        "",
        "| # | Ảnh | Loại sơ đồ | Caption / mục nguồn | File nguồn | Người vẽ |",
        "|---|---|---|---|---|---|",
    ]
    for i, e in enumerate(index, start=1):
        # Ô lỗi phải escape `|` giống ô caption, nếu không hàng sẽ có nhiều ô hơn
        # hàng tiêu đề và hai ô cuối (File nguồn, Người vẽ) bị cắt khi hiển thị.
        cell = (f"`{e['png']}`" if e["ok"]
                else "*lỗi: " + e["error"].replace("|", "\\|")[:200] + "*")
        cap = e["caption"].replace("|", "\\|")[:90]
        lines.append(
            f"| {i} | {cell} | `{e['kind']}` | {cap} | `{e['source']}` | {e['owner']} |"
        )
    if skipped:
        lines += ["", "**File chưa tồn tại nên bỏ qua:** "
                  + ", ".join(f"`{s}`" for s in skipped)]
    lines += [
        "",
        "## Dùng ảnh này ở đâu",
        "",
        "| Nơi dùng | Cách dùng |",
        "|---|---|",
        "| Báo cáo Word | Chèn ảnh vào đúng vị trí khung `[Sơ đồ Mermaid — chèn ảnh render...]` "
        "do `scripts/md_to_docx_D.py` sinh ra. |",
        "| Slide bảo vệ | Chèn trực tiếp; ảnh đã render ở tỷ lệ 2x nên không vỡ khi phóng to trên máy chiếu. |",
        "| In A4 | Sơ đồ ngang quá khổ nên xoay ngang trang theo `06_conventions_shared.md` mục 7. |",
        "",
    ]
    (out_dir / "README.md").write_text("\n".join(lines), encoding="utf-8")

    print(f"\nTổng: {ok_count} thành công, {fail_count} lỗi. Mục lục: {out_dir / 'README.md'}")
    return 1 if fail_count and not ok_count else 0


if __name__ == "__main__":
    raise SystemExit(main())
