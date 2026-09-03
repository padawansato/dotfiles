# Codex の残量を電池グリフで表示する

Codex CLI のレート制限（5時間枠 / 週次枠）の**残量**を Nerd Font の電池グリフにして、
Herdr のサイドバーと Codex 内蔵ステータスラインの両方に出す。

表示例（HackGen35 Console NF で表示）:

```
5h󰂁84% w󰁹96%
```

## 構成

| ファイル | 役割 |
| --- | --- |
| `bin/codex-limit-battery.py` | 残量を取得して電池グリフに変換し、Herdr へ報告する |
| `launchd/com.padawansato.codex-limit-battery.plist` | 60秒ごとに上記を実行 |
| `config/herdr-sidebar.toml` | Herdr サイドバーの表示設定（`~/.config/herdr/config.toml` に追記する断片） |
| `config/codex-status-line.toml` | Codex 内蔵ステータスラインの設定（`~/.codex/config.toml` に追記する断片） |

## 残量の取得元

Codex は残量を得る公式 CLI を提供していないため、3段のフォールバックで取る
（[dennykim123/claude-codex-battery](https://github.com/dennykim123/claude-codex-battery) の構成を踏襲）。

1. **ライブ API** — `GET https://chatgpt.com/backend-api/wham/usage`
   （`~/.codex/auth.json` の `tokens.access_token` と `tokens.account_id` を使う）。最も正確
2. **セッションログ** — `~/.codex/sessions/**/*.jsonl` の `token_count` イベントに含まれる `rate_limits`。
   ログは数十MBになるので末尾512KBだけ読む
3. **キャッシュ** — `~/.cache/codex-limit-battery/usage.json`（6時間まで有効）

### 5時間枠 / 週次枠の判定

API の `primary_window`/`secondary_window`、ログの `primary`/`secondary` は
**「その時点で有効な枠」でしかなく、位置は当てにならない**。
実際 2026-08-26 より前の Codex は `primary` に週次枠を入れていた。
そのため枠の長さ（`limit_window_seconds` / `window_minutes`）で判定している。

### リセット済みの扱い

`resets_at` を過ぎていれば、ログ上の使用率が古くても残量100%として扱う。

## インストール

```sh
D=~/ghq/github.com/padawansato/dotfiles

# 60秒ごとの更新を launchd に登録する
"$D/herdr/install.sh"

# 設定断片をそれぞれ追記する
cat "$D/herdr/config/herdr-sidebar.toml"     >> ~/.config/herdr/config.toml
cat "$D/herdr/config/codex-status-line.toml" >> ~/.codex/config.toml
herdr server reload-config
```

launchd の plist は絶対パスしか受け付けないため、リポジトリには `__DOTFILES__` /
`__HOME__` を置いたテンプレートを入れてある。`install.sh` がこれを展開して
`~/Library/LaunchAgents/` に書き出す（シンボリックリンクではなく実体を置く）。

## 動作確認

```sh
./bin/codex-limit-battery.py --print   # 表示文字列だけ出す
./bin/codex-limit-battery.py --json    # 取得した生の残量と取得元(live/sessions/cache)
./bin/codex-limit-battery.py --clear   # 報告済みトークンを消す

# Herdr に届いているか
herdr pane get <pane_id> | python3 -m json.tool | grep -A4 tokens
```

## 仕組み（Herdr 側）

Herdr には tmux の `status-right` のような自由なステータスバーは無いが、
`herdr pane report-metadata --token NAME=VALUE` で**任意の値をサイドバーに注入できる**。
注入した値は `$NAME` トークンとして `[ui.sidebar.agents.rows_by_agent]` から参照する。

送っているトークンは3つ:

- `$codex_limit` — 5時間枠と週次枠をまとめたもの
- `$codex_5h` — 5時間枠のみ
- `$codex_week` — 週次枠のみ

`--ttl-ms 900000` を付けているので、更新が15分止まれば古い残量は自動的に消える。

## 前提

- Nerd Font 対応フォント（このリポジトリでは HackGen35 Console NF を使用）
- `curl` と `python3`（macOS 標準のもので動く）
