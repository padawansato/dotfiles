#!/usr/bin/env bash
# Claude Code statusline: model | dir | branch | ctx% | 5h% | 7d%
#
# stdin で渡される JSON のスキーマ(抜粋、Claude Code 本体に埋め込まれた
# ドキュメントコメントより確認済み):
#   .context_window.used_percentage      コンテキスト使用率 (0-100)
#   .rate_limits.five_hour.used_percentage   5時間ローリング制限の使用率
#   .rate_limits.seven_day.used_percentage   週次(7日)制限の使用率
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
d7=$(jq -r '.rate_limits.seven_day.used_percentage // empty' <<<"$input")

RESET=$'\033[0m'
color_for_pct() {
  # 50%未満: 緑 / 80%未満: 黄 / それ以上: 赤
  awk -v p="$1" 'BEGIN {
    if (p < 50) print "\033[32m";
    else if (p < 80) print "\033[33m";
    else print "\033[31m";
  }'
}

fmt_pct() {
  local label="$1" value="$2"
  [ -z "$value" ] && return
  local color
  color=$(color_for_pct "$value")
  printf '%s%s %.0f%%%s' "$color" "$label" "$value" "$RESET"
}

segments=("$model" "$dir")
[ -n "$branch" ] && segments+=("$branch")

for seg in "$(fmt_pct ctx "$ctx")" "$(fmt_pct 5h "$h5")" "$(fmt_pct 7d "$d7")"; do
  [ -n "$seg" ] && segments+=("$seg")
done

out=""
for s in "${segments[@]}"; do
  if [ -z "$out" ]; then out="$s"; else out="$out | $s"; fi
done
echo "$out"
