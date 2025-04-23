#!/bin/sh -xeu

# dotfiles シンボリックリンク
ln -s ~/.dotfiles/dotfiles/.zshrc ~/.zshrc 
ln -s ~/.dotfiles/dotfiles/fish ~/.config/fish
ln -s ~/.dotfiles/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/dotfiles/.tmux.conf ~/.tmux.conf

# homebrew 一括インストール
brew bundle install --file=./Brewfile