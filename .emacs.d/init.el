;;; package --- Summary
;;; -*- Coding: utf-8 -*-
;;; Commentary:

;;; init-loader設定

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp")
(init-loader-load "~/.emacs.d/inits/")
(require 'init-loader)
(setq init-loader-show-log-after-init 'error-only)

