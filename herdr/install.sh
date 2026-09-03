#!/bin/sh
# codex-limit-battery を launchd に登録する。
# plist は絶対パスを要求するが、リポジトリには自分のホームパスを残したくないので
# プレースホルダを展開したものを ~/Library/LaunchAgents に書き出す。
set -eu

here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/.." && pwd)
label=com.padawansato.codex-limit-battery
dest="$HOME/Library/LaunchAgents/$label.plist"

mkdir -p "$HOME/Library/LaunchAgents"
sed -e "s|__DOTFILES__|$root|g" -e "s|__HOME__|$HOME|g" \
  "$here/launchd/$label.plist" > "$dest"

launchctl unload "$dest" 2>/dev/null || true
launchctl load "$dest"

echo "登録した: $dest"
echo "動作確認: $here/bin/codex-limit-battery.py --print"
echo
echo "設定はそれぞれ手で追記する:"
echo "  cat $here/config/herdr-sidebar.toml     >> ~/.config/herdr/config.toml && herdr server reload-config"
echo "  cat $here/config/codex-status-line.toml >> ~/.codex/config.toml"
