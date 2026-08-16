#!/usr/bin/env bash
# =============================================================================
#  capture_screenshots.sh — Person D (ATS mini, HUST IT3120)
#  Chụp toàn bộ prototype click-through (prototype/index.html) thành ảnh PNG
#  dùng cho slide bảo vệ (slide 25–27) và cho Chương 5–6.
#
#  Cách chạy (từ thư mục gốc repo):
#      bash prototype/capture_screenshots.sh
#
#  Nguyên lý: với mỗi cảnh cần chụp, script tạo một bản sao tạm của index.html
#  trong thư mục tạm, chèn thêm một khối <script> ngay trước </body> để tự động
#  đưa giao diện về đúng cảnh khi tải trang (đổi vai trò, chuyển màn hình, bật
#  trạng thái đặc biệt, ẩn thanh công cụ demo). Chrome headless được gọi hai
#  lượt cho mỗi cảnh: lượt một đo chiều cao nội dung, lượt hai chụp ảnh với
#  cửa sổ vừa đúng chiều cao đó nên ảnh không bị cắt; những cảnh có nội dung
#  ngắn hơn sàn H_MIN vẫn còn một khoảng trắng ở đáy.
#  Không phụ thuộc thư viện ngoài, không cần mạng.
#
#  Biến môi trường: đặt CHROME_BIN nếu Chrome/Chromium không nằm ở đường dẫn
#  mặc định của macOS (ví dụ khi chạy trên Linux).
# =============================================================================
set -euo pipefail

CHROME_DEFAULT="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
CHROME="${CHROME_BIN:-$CHROME_DEFAULT}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/index.html"
OUT="$ROOT/screenshots"

WIDTH=1440          # bề rộng viewport, đúng khổ trình chiếu 16:9
SCALE=2             # chụp ở mật độ 2x cho slide không bị vỡ chữ
H_MIN=900
H_MAX=3600
MIN_BYTES=20480     # ngưỡng kích thước tối thiểu của mỗi ảnh
EXPECTED_SHOTS=20   # số cảnh khai báo bên dưới; phải khớp số lệnh scene

# Nếu đường dẫn mặc định (hoặc CHROME_BIN) không dùng được thì dò thêm vài vị
# trí phổ biến khác của Chrome/Chromium để script chạy được ngoài macOS.
if [ ! -x "$CHROME" ]; then
  for cand in \
      "$CHROME_DEFAULT" \
      "/Applications/Chromium.app/Contents/MacOS/Chromium" \
      "/usr/bin/google-chrome" \
      "/usr/bin/google-chrome-stable" \
      "/usr/bin/chromium" \
      "/usr/bin/chromium-browser" \
      "/opt/google/chrome/chrome" \
      "$(command -v google-chrome 2>/dev/null || true)" \
      "$(command -v chromium 2>/dev/null || true)"; do
    if [ -n "$cand" ] && [ -x "$cand" ]; then CHROME="$cand"; break; fi
  done
fi

[ -x "$CHROME" ] || {
  echo "Khong tim thay Google Chrome/Chromium tai: $CHROME" >&2
  echo "Dat bien moi truong CHROME_BIN tro toi trinh duyet roi chay lai." >&2
  exit 1
}
[ -f "$SRC" ]    || { echo "Khong tim thay prototype tai: $SRC" >&2; exit 1; }
command -v python3 >/dev/null 2>&1 || {
  echo "Khong tim thay python3 — script can python3 de chen kich ban canh vao index.html." >&2
  exit 1
}

# Lệnh tính mã băm dùng để dò ảnh trùng nội dung: md5 có trên macOS, md5sum
# trên phần lớn bản Linux, shasum là phương án cuối.
HASH_CMD=()
if   command -v md5    >/dev/null 2>&1; then HASH_CMD=(md5 -q)
elif command -v md5sum >/dev/null 2>&1; then HASH_CMD=(md5sum)
elif command -v shasum >/dev/null 2>&1; then HASH_CMD=(shasum -a 1)
fi

TMP="$(mktemp -d "${TMPDIR:-/tmp}/ats-shots.XXXXXX")"
trap 'rm -rf "$TMP"' EXIT

# Chụp vào thư mục tạm trước; bộ ảnh cũ trong $OUT chỉ bị thay thế ở cuối
# phiên, sau khi đã chụp đủ và mọi ảnh đều đạt ngưỡng kích thước tối thiểu.
STAGE="$TMP/out"
mkdir -p "$STAGE"
mkdir -p "$OUT"

# --- Bộ chèn kịch bản cảnh vào bản sao tạm của index.html --------------------
cat > "$TMP/inject.py" <<'PYEOF'
import sys

src, dst, scene_js = sys.argv[1], sys.argv[2], sys.argv[3]
html = open(src, encoding='utf-8').read()
scene = open(scene_js, encoding='utf-8').read()

wrapper = """
<style id="cap-style">
  #demobar{display:none !important}
  #annot{display:none !important}
  #toasts{display:none !important}
  .modal-body{max-height:none !important;overflow:visible !important}
  *{scroll-behavior:auto !important}
</style>
<script id="cap-scene">
window.addEventListener('load', function(){
  try {
    /* ==== kịch bản của cảnh ==== */
__SCENE__
    /* =========================== */
  } catch (e) {
    document.title = 'CAPERR-' + (e && e.message ? e.message : 'unknown');
    return;
  }
  /* Chiều cao cần chụp = đáy thực của màn hình đang hiển thị, có sàn 720px
     để thanh bên trái luôn đủ chỗ và ảnh không bị dẹt bất thường. */
  var h = 720;
  var act = document.querySelector('.screen.is-active');
  if (act) {
    var r = act.getBoundingClientRect();
    h = Math.max(h, r.bottom + (window.pageYOffset || 0) + 28);
  }
  var m = document.querySelector('.modal-screen.is-open');
  if (m) {
    var inner = m.querySelector('.modal');
    if (inner) h = Math.max(h, inner.offsetHeight + 96);
  }
  document.title = 'CAPH-' + Math.ceil(h);
});
</script>
"""

body = wrapper.replace('__SCENE__', scene)
idx = html.rfind('</body>')
if idx < 0:
    raise SystemExit('index.html khong co the dong </body>')
open(dst, 'w', encoding='utf-8').write(html[:idx] + body + html[idx:])
PYEOF

CHROME_FLAGS=(--headless=new --disable-gpu --no-sandbox --hide-scrollbars
              --disable-lcd-text --virtual-time-budget=4000
              --force-device-scale-factor="$SCALE")

COUNT=0

# scene <ten-file> [be-rong-viewport]  — nội dung JS của cảnh đọc từ stdin
scene() {
  local name="$1"
  local w="${2:-$WIDTH}"
  local js="$TMP/$name.js"
  local page="$TMP/$name.html"
  cat > "$js"

  python3 "$TMP/inject.py" "$SRC" "$page" "$js"

  # Lượt 1: đo chiều cao nội dung thực tế của cảnh
  local dom h
  local title
  dom="$("$CHROME" "${CHROME_FLAGS[@]}" --window-size="$w,1000" \
        --dump-dom "file://$page" 2>/dev/null || true)"
  # `|| true` để pipeline không khớp (Chrome đổi phiên bản, dump-dom rỗng)
  # không làm cả script thoát im lặng vì set -e + pipefail.
  title="$(printf '%s' "$dom" | grep -o '<title>CAP[^<]*' | head -1 | sed 's/<title>//' || true)"
  case "$title" in
    CAPERR-*)
      echo "  LOI kich ban canh $name: $title" >&2
      exit 1 ;;
  esac
  if [ -z "$title" ]; then
    echo "  CANH BAO: khong doc duoc chieu cao do duoc cua canh $name (dump-dom khong co the <title>CAP...)." >&2
    echo "            Dung chieu cao du phong 1400 px; kiem tra lai Chrome va prototype neu anh bi cat." >&2
  fi
  h="$(printf '%s' "$title" | grep -o '[0-9]\+' | head -1 || true)"
  if [ -z "$h" ]; then
    [ -n "$title" ] && echo "  CANH BAO: tieu de canh $name khong chua so do chieu cao: $title" >&2
    h=1400
  fi
  h=$((h + 20))
  if [ "$h" -lt "$H_MIN" ]; then h="$H_MIN"; fi
  if [ "$h" -gt "$H_MAX" ]; then h="$H_MAX"; fi

  # Lượt 2: chụp ảnh với cửa sổ cao vừa đủ
  # `|| true` để Chrome lỗi (bị kill, hết bộ nhớ...) không làm set -e cắt ngang
  # trước khi kiểm tra bên dưới kịp in thông báo dễ hiểu.
  "$CHROME" "${CHROME_FLAGS[@]}" --window-size="$w,$h" \
      --screenshot="$STAGE/$name.png" "file://$page" >/dev/null 2>&1 || true

  [ -s "$STAGE/$name.png" ] || {
    echo "  LOI: khong tao duoc anh $name.png — dung phien chup, giu nguyen bo anh cu trong $OUT." >&2
    exit 1
  }
  COUNT=$((COUNT + 1))
  printf '  [%02d] %-42s viewport %sx%s\n' "$COUNT" "$name.png" "$w" "$h"
  rm -f "$page" "$js"
}

echo "Dang chup prototype: $SRC"
echo "Thu muc ket qua:     $OUT"
echo

# ---------------------------------------------------------------------------
# SCR-01 — Đăng nhập / SSO
# ---------------------------------------------------------------------------
scene 01-scr01-dang-nhap <<'JS'
showScreen('scr-01');
JS

# ---------------------------------------------------------------------------
# SCR-02 — Dashboard Recruiter: đầy dữ liệu và trạng thái rỗng
# ---------------------------------------------------------------------------
scene 02-scr02-dashboard-day-du <<'JS'
setRole('RECRUITER', true);
showScreen('scr-02');
document.getElementById('dash-full').hidden = false;
document.getElementById('dash-empty').hidden = true;
JS

scene 03-scr02-dashboard-trong <<'JS'
setRole('RECRUITER', true);
showScreen('scr-02');
document.getElementById('dash-full').hidden = true;
document.getElementById('dash-empty').hidden = false;
JS

# ---------------------------------------------------------------------------
# SCR-03 — Kanban pipeline
# ---------------------------------------------------------------------------
# Viewport rộng hơn và nới max-width của vùng nội dung để cả 7 cột pipeline
# (NEW → Kết thúc) hiện đủ trong một ảnh; trên màn hình thường thì dải kanban
# cuộn ngang. Bề rộng cần thiết: 7 cột × 232 px + 6 khe × 12 px = 1696 px, cộng
# padding 48 px của .content và thanh bên 220 px.
scene 04-scr03-kanban 2040 <<'JS'
var wide = document.createElement('style');
wide.textContent = '.content{max-width:1800px}';
document.head.appendChild(wide);
setRole('RECRUITER', true);
showScreen('scr-03');
JS

# ---------------------------------------------------------------------------
# SCR-04 — Hồ sơ ứng viên và timeline
# ---------------------------------------------------------------------------
scene 05-scr04-ho-so-ung-vien <<'JS'
setRole('RECRUITER', true);
showScreen('scr-04');
JS

# ---------------------------------------------------------------------------
# SCR-05 — Xếp lịch phỏng vấn: hợp lệ / xung đột / override kèm lý do (BR-03)
# ---------------------------------------------------------------------------
scene 06-scr05-xep-lich-khong-xung-dot <<'JS'
setRole('RECRUITER', true);
showScreen('scr-03');
openSchedule();
document.querySelector('input[name="sch-slot"][value="s1"]').checked = true;
evaluateSchedule();
JS

scene 07-scr05-xep-lich-xung-dot <<'JS'
setRole('RECRUITER', true);
showScreen('scr-03');
openSchedule();
document.querySelector('input[name="sch-slot"][value="s3"]').checked = true;
evaluateSchedule();
JS

scene 08-scr05-xep-lich-override <<'JS'
setRole('RECRUITER', true);
showScreen('scr-03');
openSchedule();
document.querySelector('input[name="sch-slot"][value="s3"]').checked = true;
document.getElementById('sch-reason').value =
  'Ứng viên chỉ sắp xếp được khung 14:00; Vũ Ngọc Lan đã bàn giao buổi INT-2061 cho Đinh Quang Huy.';
document.getElementById('sch-commit').checked = true;
evaluateSchedule();
JS

# ---------------------------------------------------------------------------
# SCR-06 — Scorecard: đang nhập (thiếu nhận xét) và đã submit + khoá
# ---------------------------------------------------------------------------
scene 09-scr06-scorecard-dang-nhap <<'JS'
setRole('INTERVIEWER', true);
showScreen('scr-06');
resetScorecard();
var partial = [
  ['technical', 4, 'Nắm chắc Spring Boot, giải thích rõ cơ chế transaction và tối ưu truy vấn N+1.'],
  ['problemSolving', 4, 'Chia nhỏ bài toán rate limit hợp lý, nêu được đánh đổi giữa token bucket và sliding window.'],
  ['communication', 5, 'Trình bày mạch lạc, chủ động làm rõ ràng buộc trước khi đưa lời giải.']
];
partial.forEach(function(row){
  var r = document.querySelector('input[name="sc-' + row[0] + '"][value="' + row[1] + '"]');
  if (r) { r.checked = true; r.dispatchEvent(new Event('change', { bubbles: true })); }
  var t = document.querySelector('[data-comment="' + row[0] + '"]');
  if (t) { t.value = row[2]; }
});
var r4 = document.querySelector('input[name="sc-cultureFit"][value="4"]');
if (r4) { r4.checked = true; r4.dispatchEvent(new Event('change', { bubbles: true })); }
updateScorecard();
JS

scene 10-scr06-scorecard-da-khoa <<'JS'
setRole('INTERVIEWER', true);
showScreen('scr-06');
resetScorecard();
var full = [
  ['technical', 4, 'Nắm chắc Spring Boot, giải thích rõ cơ chế transaction và tối ưu truy vấn N+1.'],
  ['problemSolving', 4, 'Chia nhỏ bài toán rate limit hợp lý, nêu được đánh đổi giữa token bucket và sliding window.'],
  ['communication', 5, 'Trình bày mạch lạc, chủ động làm rõ ràng buộc trước khi đưa lời giải.'],
  ['cultureFit', 4, 'Kể được tình huống nhận trách nhiệm khi sự cố xảy ra, hợp tác tốt với nhóm vận hành.'],
  ['growth', 4, 'Chủ động viết post-mortem sau sự cố và chia sẻ lại cho nhóm.']
];
full.forEach(function(row){
  var r = document.querySelector('input[name="sc-' + row[0] + '"][value="' + row[1] + '"]');
  if (r) { r.checked = true; r.dispatchEvent(new Event('change', { bubbles: true })); }
  var t = document.querySelector('[data-comment="' + row[0] + '"]');
  if (t) { t.value = row[2]; }
});
document.getElementById('sc-verdict').value = 'HIRE';
updateScorecard();
submitScorecard();
JS

# ---------------------------------------------------------------------------
# SCR-07 — Offer Wizard: trong band (1 cấp), vượt band 8% (2 cấp),
#          vượt band trên 10% (3 cấp) theo BR-08
# ---------------------------------------------------------------------------
scene 11-scr07-offer-trong-band <<'JS'
setRole('RECRUITER', true);
showScreen('scr-07');
document.getElementById('ow-salary').value = '45000000';
renderChain(45000000);
setWizardStep(2);
JS

scene 12-scr07-offer-vuot-band <<'JS'
setRole('RECRUITER', true);
showScreen('scr-07');
document.getElementById('ow-salary').value = '51840000';
renderChain(51840000);
setWizardStep(2);
JS

scene 13-scr07-offer-vuot-band-3-cap <<'JS'
setRole('RECRUITER', true);
showScreen('scr-07');
document.getElementById('ow-salary').value = '56000000';
renderChain(56000000);
setWizardStep(4);
JS

# ---------------------------------------------------------------------------
# SCR-08 — Hộp duyệt offer: chờ quyết định và sau khi yêu cầu chỉnh sửa
# ---------------------------------------------------------------------------
scene 14-scr08-hop-thu-duyet <<'JS'
setRole('HEAD_OF_HR', true);
showScreen('scr-08');
selectOffer('OFF-318');
JS

scene 15-scr08-yeu-cau-chinh-sua <<'JS'
setRole('HEAD_OF_HR', true);
showScreen('scr-08');
selectOffer('OFF-318');
decide('REQUEST_CHANGE');
JS

# ---------------------------------------------------------------------------
# SCR-09 — Cổng ứng viên
# ---------------------------------------------------------------------------
scene 16-scr09-cong-ung-vien <<'JS'
showScreen('scr-09');
JS

scene 17-scr09-cong-ung-vien-da-xac-nhan <<'JS'
showScreen('scr-09');
// Đi đúng luồng của prototype: bấm hai nút thật thay vì chèn chuỗi vào DOM,
// để ảnh chụp luôn khớp với hành vi hội đồng thấy khi demo trực tiếp.
document.getElementById('pt-confirm').click();
document.getElementById('pt-counter').click();
JS

# ---------------------------------------------------------------------------
# SCR-10 — Báo cáo: đầy đủ 4 biểu đồ và trạng thái chưa đủ dữ liệu
# ---------------------------------------------------------------------------
scene 18-scr10-bao-cao-day-du <<'JS'
setRole('HR_ADMIN', true);
showScreen('scr-10');
document.getElementById('rp-full').hidden = false;
document.getElementById('rp-empty').hidden = true;
JS

scene 19-scr10-bao-cao-trong <<'JS'
setRole('HR_ADMIN', true);
showScreen('scr-10');
document.getElementById('rp-full').hidden = true;
document.getElementById('rp-empty').hidden = false;
JS

# ---------------------------------------------------------------------------
# SCR-11 — Quản trị người dùng và phân quyền
# ---------------------------------------------------------------------------
scene 20-scr11-quan-tri <<'JS'
setRole('HR_ADMIN', true);
showScreen('scr-11');
JS

# ---------------------------------------------------------------------------
# Kiểm tra sau khi chụp (vẫn còn trong thư mục tạm)
# ---------------------------------------------------------------------------
echo
echo "Danh sach anh vua chup (thu muc tam):"
ls -l "$STAGE"/*.png | awk '{printf "  %-10s %s\n", $5, $9}'

echo
echo "Kiem tra du so canh:"
if [ "$COUNT" -ne "$EXPECTED_SHOTS" ]; then
  echo "  LOI: chi chup duoc $COUNT/$EXPECTED_SHOTS anh — giu nguyen bo anh cu trong $OUT." >&2
  exit 1
fi
echo "  Da chup du $COUNT/$EXPECTED_SHOTS anh."

echo
echo "Kiem tra kich thuoc toi thieu 20 KB:"
small=0
for f in "$STAGE"/*.png; do
  bytes=$(wc -c < "$f")
  if [ "$bytes" -lt "$MIN_BYTES" ]; then
    echo "  CANH BAO: $(basename "$f") chi co $bytes byte" >&2
    small=$((small + 1))
  fi
done
if [ "$small" -eq 0 ]; then
  echo "  Tat ca anh deu lon hon 20 KB."
else
  echo "  LOI: $small anh duoi nguong $MIN_BYTES byte — giu nguyen bo anh cu trong $OUT." >&2
  exit 1
fi

echo
echo "Kiem tra trung lap noi dung (ma bam):"
if [ "${#HASH_CMD[@]}" -eq 0 ]; then
  echo "  Bo qua: khong co lenh bam nao (md5, md5sum hoac shasum) tren may nay." >&2
else
  dup=$("${HASH_CMD[@]}" "$STAGE"/*.png | awk '{print $1}' | sort | uniq -d | wc -l | tr -d ' ')
  if [ "$dup" != "0" ]; then
    echo "  CANH BAO: co $dup nhom anh trung ma bam — kich ban canh chua doi duoc man hinh." >&2
    "${HASH_CMD[@]}" "$STAGE"/*.png
  else
    echo "  Khong co anh nao trung ma bam."
  fi
fi

# ---------------------------------------------------------------------------
# Thay thế bộ ảnh cũ bằng bộ ảnh vừa chụp (chỉ tới đây mới đụng vào $OUT)
# ---------------------------------------------------------------------------
echo
echo "Thay the bo anh cu trong $OUT:"
BACKUP="$TMP/backup"
mkdir -p "$BACKUP"
for f in "$OUT"/*.png; do
  [ -e "$f" ] || continue
  cp -p "$f" "$BACKUP/"
done
rm -f "$OUT"/*.png
if ! cp -p "$STAGE"/*.png "$OUT/"; then
  echo "  LOI: khong chep duoc anh moi vao $OUT — dang khoi phuc bo anh cu." >&2
  for f in "$BACKUP"/*.png; do
    [ -e "$f" ] || continue
    cp -p "$f" "$OUT/"
  done
  exit 1
fi
echo "  Da thay the xong (bo anh cu duoc giu trong thu muc tam den khi script ket thuc)."

echo
echo "Hoan tat: $COUNT anh trong $OUT"
