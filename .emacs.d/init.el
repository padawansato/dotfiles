;;; package --- Summary
;;; -*- Coding: utf-8 -*-
;;; Commentary:

;;; init-loader設定

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(require 'init-loader)
(add-to-list 'load-path "~/.dotfiles/dotfiles/.emacs.d/elisp")
(init-loader-load "~/.dotfiles/dotfiles/.emacs.d/inits/")
(setq init-loader-show-log-after-init 'error-only)

