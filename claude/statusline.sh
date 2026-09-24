#!/usr/bin/env bash
# Claude Code statusline: model | dir | branch | [icon]ctx% | [icon]5h%(reset) | [icon]7d%(reset)
#
# アイコンは HackGen Nerd Font (Material Design Icons由来) のグリフを
# 直接埋め込んでいる。段階的にアイコンへ変換する:
#   - 5h/7d(レート制限)はバッテリー形。表示する%も「残り容量」
#     = 100 - used_percentage のカウントダウン。使うほど数字も電池も減っていく:
#     battery_10〜90 / battery(満) / battery_alert(枯渇)
#   - ctx(コンテキストウィンドウ)は円グラフ形。表示する%は used_percentage
#     そのもののカウントアップ。使うほど数字も塗りつぶし面積も増えていく:
#     circle_slice_1〜8 / 空円(0%)
#     ※ ctx と 5h/7d で意図的に向き(カウントアップ/ダウン)と形を変えている
# 色(緑/黄/赤)は常に used_percentage(危険度)基準で、表示される数字の
# 向きとは独立している。
#
# stdin で渡される JSON のスキーマ(抜粋、Claude Code 本体に埋め込まれた
# ドキュメントコメントより確認済み):
#   .context_window.used_percentage          コンテキスト使用率 (0-100)
#   .rate_limits.five_hour.used_percentage   5時間ローリング制限の使用率
#   .rate_limits.five_hour.resets_at         5時間制限のリセット時刻 (Unix epoch秒)
#   .rate_limits.seven_day.used_percentage   週次(7日)制限の使用率
#   .rate_limits.seven_day.resets_at         週次制限のリセット時刻 (Unix epoch秒)
# rate_limits はサブスク/ゲートウェイ利用時のみ、かつセッション最初の
# API 応答後にしか出現しないため、値が無ければ該当セグメントを省略する。
set -euo pipefail

input=$(cat)

model=$(jq -r '.model.display_name' <<<"$input")
cwd=$(jq -r '.workspace.current_dir' <<<"$input")
dir=$(basename "$cwd")
branch=$(git -C "$cwd" -c core.fileMode=false symbolic-ref --short HEAD 2>/dev/null || echo '')

ctx=$(jq -r '.context_window.used_percentage // empty' <<<"$input")
h5=$(jq -r '.rate_limits.five_hour.used_percentage // empty' <<<"$input")
h5_reset=$(jq -r '.rate_limits.five_hour.resets_at // empty' <<<"$input")
d7=$(jq -r '.rate_limits.seven_day.used_percentage // empty' <<<"$input")
d7_reset=$(jq -r '.rate_limits.seven_day.resets_at // empty' <<<"$input")

RESET=$'\033[0m'
color_for_pct() {
  # 50%未満: 緑 / 80%未満: 黄 / それ以上: 赤
  awk -v p="$1" 'BEGIN {
    if (p < 50) print "\033[32m";
    else if (p < 80) print "\033[33m";
    else print "\033[31m";
  }'
}

# 残り秒数を "Xd Yh" / "Xh Ym" / "Xm" 形式に整形する
fmt_remaining() {
  local resets_at="$1"
  [ -z "$resets_at" ] && return
  local now diff
  now=$(date +%s)
  diff=$(( ${resets_at%.*} - now ))
  [ "$diff" -lt 0 ] && diff=0
  local days=$(( diff / 86400 ))
  local hours=$(( (diff % 86400) / 3600 ))
  local mins=$(( (diff % 3600) / 60 ))
  if [ "$days" -gt 0 ]; then
    printf '%dd%dh' "$days" "$hours"
  elif [ "$hours" -gt 0 ]; then
    printf '%dh%dm' "$hours" "$mins"
  else
    printf '%dm' "$mins"
  fi
}

# 残り容量(100 - used_percentage)を10%刻みでバッテリーアイコンに変換する
battery_icon() {
  local value="$1"
  local tier
  tier=$(awk -v v="$value" 'BEGIN {
    r = 100 - v;
    if (r < 0) r = 0;
    if (r > 100) r = 100;
    print int(r / 10) * 10;
  }')
  case "$tier" in
    100) printf '󰁹' ;;
    90)  printf '󰂂' ;;
    80)  printf '󰂁' ;;
    70)  printf '󰂀' ;;
    60)  printf '󰁿' ;;
    50)  printf '󰁾' ;;
    40)  printf '󰁽' ;;
    30)  printf '󰁼' ;;
    20)  printf '󰁻' ;;
    10)  printf '󰁺' ;;
    *)   printf '󰂃' ;;
  esac
}

# 使用率(used_percentage)を8分割の円グラフアイコンに変換する
# (batteryとは逆に、使うほど塗りつぶし面積が増えていく)
circle_icon() {
  local value="$1"
  local slice
  slice=$(awk -v v="$value" 'BEGIN {
    if (v < 0) v = 0;
    if (v > 100) v = 100;
    s = int(v / 100 * 8 + 0.5);
    if (s > 8) s = 8;
    print s;
  }')
  case "$slice" in
    8) printf '󰪥' ;;
    7) printf '󰪤' ;;
    6) printf '󰪣' ;;
    5) printf '󰪢' ;;
    4) printf '󰪡' ;;
    3) printf '󰪠' ;;
    2) printf '󰪟' ;;
    1) printf '󰪞' ;;
    *) printf '󰄰' ;;
  esac
}

fmt_pct() {
  local label="$1" value="$2" resets_at="${3:-}" icon_kind="${4:-battery}" display_mode="${5:-used}"
  [ -z "$value" ] && return
  local color remaining icon shown
  color=$(color_for_pct "$value")
  if [ "$icon_kind" = "circle" ]; then
    icon=$(circle_icon "$value")
  else
    icon=$(battery_icon "$value")
  fi
  if [ "$display_mode" = "remaining" ]; then
    shown=$(awk -v v="$value" 'BEGIN { r = 100 - v; if (r < 0) r = 0; if (r > 100) r = 100; print r }')
  else
    shown="$value"
  fi
  remaining=$(fmt_remaining "$resets_at")
  if [ -n "$remaining" ]; then
    printf '%s%s %s %.0f%%(%s)%s' "$color" "$icon" "$label" "$shown" "$remaining" "$RESET"
  else
    printf '%s%s %s %.0f%%%s' "$color" "$icon" "$label" "$shown" "$RESET"
  fi
}

segments=("$model" "$dir")
[ -n "$branch" ] && segments+=("$branch")

for seg in "$(fmt_pct ctx "$ctx" "" circle used)" "$(fmt_pct 5h "$h5" "$h5_reset" battery remaining)" "$(fmt_pct 7d "$d7" "$d7_reset" battery remaining)"; do
  [ -n "$seg" ] && segments+=("$seg")
done

out=""
for s in "${segments[@]}"; do
  if [ -z "$out" ]; then out="$s"; else out="$out | $s"; fi
done
echo "$out"
