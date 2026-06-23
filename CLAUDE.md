# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS向けのdotfiles管理リポジトリ。シェル設定（zsh, fish）、tmux、VS Codeの設定、Homebrew管理を含む。

## Commands

### Installation
```sh
./install.sh  # シンボリックリンク作成 + brew bundle
```

### Homebrew
```sh
# Brewfileを更新（現在のインストール状況を保存）
brew bundle dump --describe --force

# Brewfileからインストール
brew bundle install --file=./Brewfile
```

## Architecture

### Directory Structure
- `.zshrc` - zsh設定（emacs風キーバインド、peco連携、pyenv設定）
- `.tmux.conf` - tmux設定（prefix: Ctrl-s、viモード、マウス操作有効）
- `fish/` - fish shell設定（tide prompt、fzf、ghq連携）
- `vscode/settings.json` - VS Code設定
- `Brewfile` - Homebrew依存関係管理
- `iTerm2/` - iTerm2設定

### Key Configurations
- **Shell**: fish をメインシェル、zshをサブとして使用
- **Python**: pyenv で管理
- **tmux prefix**: `Ctrl-s`
- **Git tools**: ghq（リポジトリ管理）、tig、git-delta
- **Fuzzy finder**: fzf、peco
