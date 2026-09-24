#!/usr/bin/env python3
"""Codex のレート制限残量を電池グリフにして Herdr サイドバーへ報告する。

取得元は3段構え(dennykim123/claude-codex-battery の構成を踏襲):
  1. ライブ API  https://chatgpt.com/backend-api/wham/usage  (~/.codex/auth.json のトークン)
  2. セッションログ ~/.codex/sessions/**/*.jsonl の token_count イベント
  3. 直近取得値のキャッシュ

得られた残量を Nerd Font の電池グリフに変換し、`herdr pane report-metadata` の
カスタムトークン($codex_limit 等)として Codex ペインに送る。

  --print   標準出力に出すだけ(動作確認や他の表示先で使う用)
  --clear   報告済みトークンを消す
  --json    取得した生の残量情報を JSON で出す
"""

import json
import os
import subprocess
import sys
import time

CODEX_DIR = os.path.expanduser("~/.codex")
AUTH_PATH = os.path.join(CODEX_DIR, "auth.json")
SESSIONS_DIR = os.path.join(CODEX_DIR, "sessions")
CACHE_PATH = os.path.expanduser("~/.cache/codex-limit-battery/usage.json")

SOURCE = "codex-limit-battery"
USAGE_URL = "https://chatgpt.com/backend-api/wham/usage"

# セッションログ探索の上限(ログは数十MBになるので末尾だけ読む)
MAX_FILES = 8
MAX_AGE_SEC = 14 * 24 * 3600
TAIL_BYTES = 512 * 1024

# キャッシュをフォールバックとして信用する上限
CACHE_MAX_AGE_SEC = 6 * 3600

# 5時間枠と週次枠の切り分け。API は枠の長さでしか区別できない。
SHORT_WINDOW_MAX_SEC = 6 * 3600

# Nerd Font (Material Design Icons) の電池グリフ。残量が多い順。
BATTERY_STEPS = [
    (95, "\U000f0079"),  # battery
    (85, "\U000f0082"),  # battery-90
    (75, "\U000f0081"),  # battery-80
    (65, "\U000f0080"),  # battery-70
    (55, "\U000f007f"),  # battery-60
    (45, "\U000f007e"),  # battery-50
    (35, "\U000f007d"),  # battery-40
    (25, "\U000f007c"),  # battery-30
    (15, "\U000f007b"),  # battery-20
    (5, "\U000f007a"),  # battery-10
    (1, "\U000f008e"),  # battery-outline
]
BATTERY_EMPTY = "\U000f0083"  # battery-alert


def battery_glyph(remaining):
    if remaining < 1:
        return BATTERY_EMPTY
    for threshold, glyph in BATTERY_STEPS:
        if remaining >= threshold:
            return glyph
    return BATTERY_EMPTY


def assign_slots(windows, source):
    """枠の長さから 5時間枠 / 週次枠 を決める。

    primary/secondary は「その時点で有効な枠」でしかなく、位置は当てにならない。
    実際 2026-08-26 より前の Codex は primary に週次枠を入れていた。
    枠長が取れないときだけ、与えられた順を保険として使う。
    """
    short = long = None
    unlabeled = []
    for seconds, window in windows:
        if not isinstance(seconds, (int, float)) or isinstance(seconds, bool) or seconds <= 0:
            unlabeled.append(window)
        elif seconds <= SHORT_WINDOW_MAX_SEC:
            short = window
        else:
            long = window
    for window in unlabeled:
        if short is None:
            short = window
        elif long is None:
            long = window
    if short is None and long is None:
        return None
    return {"primary": short, "secondary": long, "source": source}


# --- 取得元1: ライブ API ---------------------------------------------------


def auth_tokens():
    try:
        with open(AUTH_PATH, encoding="utf-8") as handle:
            data = json.load(handle)
    except (OSError, ValueError):
        return None
    tokens = data.get("tokens") or {}
    access = tokens.get("access_token")
    if not access:
        return None
    return access, tokens.get("account_id") or ""


def fetch_live():
    creds = auth_tokens()
    if not creds:
        return None
    access, account = creds
    # ヘッダを argv に置くと ps から見えるので curl の設定を stdin で渡す
    config = "\n".join([
        'url = "{}"'.format(USAGE_URL),
        'header = "Authorization: Bearer {}"'.format(access),
        'header = "ChatGPT-Account-Id: {}"'.format(account),
        'header = "User-Agent: codex-cli"',
        "silent",
        "show-error",
        "max-time = 8",
        "fail",
    ]) + "\n"
    try:
        result = subprocess.run(
            ["curl", "-K", "-"],
            input=config,
            capture_output=True,
            text=True,
            timeout=15,
        )
    except (OSError, subprocess.SubprocessError):
        return None
    if result.returncode != 0:
        return None
    try:
        payload = json.loads(result.stdout)
    except ValueError:
        return None

    rate_limit = payload.get("rate_limit") or {}
    windows = []
    for key in ("primary_window", "secondary_window"):
        window = rate_limit.get(key)
        if not isinstance(window, dict):
            continue
        seconds = window.get("limit_window_seconds")
        windows.append((
            seconds,
            {
                "used_percent": window.get("used_percent"),
                "resets_at": window.get("reset_at"),
            },
        ))
    return assign_slots(windows, "live")


# --- 取得元2: セッションログ ------------------------------------------------


def candidate_files():
    now = time.time()
    found = []
    for root, _dirs, files in os.walk(SESSIONS_DIR):
        for name in files:
            if not name.endswith(".jsonl"):
                continue
            path = os.path.join(root, name)
            try:
                mtime = os.path.getmtime(path)
            except OSError:
                continue
            if now - mtime > MAX_AGE_SEC:
                continue
            found.append((mtime, path))
    found.sort(reverse=True)
    return [path for _mtime, path in found[:MAX_FILES]]


def tail_lines(path):
    try:
        size = os.path.getsize(path)
        with open(path, "rb") as handle:
            if size > TAIL_BYTES:
                handle.seek(size - TAIL_BYTES)
                handle.readline()  # 途中で切れた行を捨てる
            data = handle.read()
    except OSError:
        return []
    return data.decode("utf-8", "replace").splitlines()


def extract_latest(path):
    for line in reversed(tail_lines(path)):
        if '"rate_limits"' not in line:
            continue
        try:
            event = json.loads(line)
        except ValueError:
            continue
        limits = (event.get("payload") or {}).get("rate_limits")
        if not isinstance(limits, dict):
            limits = event.get("rate_limits")
        if not isinstance(limits, dict):
            continue
        # limit_id には "codex"(使用量) と "premium"(クレジット) がある。
        # 5時間/週次の残量を持つのは前者だけ。
        if not isinstance(limits.get("primary"), dict):
            continue
        return event.get("timestamp") or "", limits
    return None


def fetch_sessions():
    best = None
    for path in candidate_files():
        found = extract_latest(path)
        if found and (best is None or found[0] > best[0]):
            best = found
    if not best:
        return None
    limits = best[1]
    windows = []
    for key in ("primary", "secondary"):
        window = limits.get(key)
        if not isinstance(window, dict):
            continue
        minutes = window.get("window_minutes")
        seconds = minutes * 60 if isinstance(minutes, (int, float)) and not isinstance(minutes, bool) else None
        windows.append((
            seconds,
            {
                "used_percent": window.get("used_percent"),
                "resets_at": window.get("resets_at"),
            },
        ))
    return assign_slots(windows, "sessions")


# --- 取得元3: キャッシュ ----------------------------------------------------


def save_cache(usage):
    try:
        os.makedirs(os.path.dirname(CACHE_PATH), exist_ok=True)
        payload = dict(usage)
        payload["measured_at"] = time.time()
        with open(CACHE_PATH, "w", encoding="utf-8") as handle:
            json.dump(payload, handle)
    except OSError:
        pass


def fetch_cache():
    try:
        with open(CACHE_PATH, encoding="utf-8") as handle:
            payload = json.load(handle)
    except (OSError, ValueError):
        return None
    measured = payload.get("measured_at")
    if not isinstance(measured, (int, float)):
        return None
    if time.time() - measured > CACHE_MAX_AGE_SEC:
        return None
    payload["source"] = "cache"
    return payload


def load_usage():
    usage = fetch_live()
    if usage:
        save_cache(usage)
        return usage
    return fetch_sessions() or fetch_cache()


# --- 表示 -------------------------------------------------------------------


def window_remaining(window):
    """使用率と reset 時刻から残量%を出す。リセット済みなら満タン扱い。"""
    if not isinstance(window, dict):
        return None
    resets_at = window.get("resets_at")
    if isinstance(resets_at, (int, float)) and resets_at < time.time():
        return 100.0
    used = window.get("used_percent")
    if not isinstance(used, (int, float)) or isinstance(used, bool):
        return None
    return max(0.0, min(100.0, 100.0 - used))


def format_window(label, remaining):
    if remaining is None:
        return None
    return "{}{}{:.0f}%".format(label, battery_glyph(remaining), remaining)


def build_tokens(usage):
    if not usage:
        return None
    text_5h = format_window("5h", window_remaining(usage.get("primary")))
    text_week = format_window("w", window_remaining(usage.get("secondary")))
    tokens = {}
    if text_5h:
        tokens["codex_5h"] = text_5h
    if text_week:
        tokens["codex_week"] = text_week
    combined = " ".join(t for t in (text_5h, text_week) if t)
    if combined:
        tokens["codex_limit"] = combined
    return tokens or None


# --- Herdr への報告 ---------------------------------------------------------


def herdr(*args):
    try:
        result = subprocess.run(
            ["herdr", *args],
            capture_output=True,
            text=True,
            timeout=10,
        )
    except (OSError, subprocess.SubprocessError):
        return None
    if result.returncode != 0:
        return None
    try:
        return json.loads(result.stdout)
    except ValueError:
        return None


def codex_panes():
    payload = herdr("agent", "list")
    if not payload:
        return []
    agents = (payload.get("result") or {}).get("agents") or []
    return [a["pane_id"] for a in agents if a.get("agent") == "codex" and a.get("pane_id")]


def report(tokens):
    panes = codex_panes()
    for pane in panes:
        args = ["pane", "report-metadata", pane, "--source", SOURCE]
        if tokens:
            for name, value in tokens.items():
                args += ["--token", "{}={}".format(name, value)]
            # 更新が途絶えたら古い残量を残さず消す
            args += ["--ttl-ms", "900000"]
        else:
            for name in ("codex_limit", "codex_5h", "codex_week"):
                args += ["--clear-token", name]
        herdr(*args)
    return len(panes)


def main():
    argv = sys.argv[1:]

    if "--clear" in argv:
        report({})
        return 0

    usage = load_usage()

    if "--json" in argv:
        print(json.dumps(usage, ensure_ascii=False, indent=2) if usage else "null")
        return 0

    tokens = build_tokens(usage)

    if "--print" in argv:
        print(tokens["codex_limit"] if tokens else "")
        return 0

    if tokens:
        report(tokens)
    return 0


if __name__ == "__main__":
    sys.exit(main())
