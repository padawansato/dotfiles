;;; -*- Coding: utf-8 -*-
;;

;;; 言語環境の指定

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(set-language-environment "Japanese")

;; 漢字コードの設定
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

;; スペルチェック
;; http://www.clear-code.com/blog/2012/3/20.html
(setq-default flyspell-mode t)
(setq ispell-dictionary "american")

;;
;; Terminal から起動する場合は MenuBar 非表示
;;
(if window-system (menu-bar-mode 1) (menu-bar-mode -1))


(if (eq window-system 'mac)
    (progn
      ;; carbon-font の利用
      ;; (require 'carbon-font)
      ;; インライン変換
      (setq default-input-method "MacOSX")
					;     (mac-input-method-mode t)
					;     (set-input-method "MacOSX")
      ))

;; keybindingd
;; Ctrl-h を Backspace として使う．
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;; 補完 http://www.clear-code.com/blog/2012/3/20.html
(define-key global-map (kbd "C-c C-i") 'hippie-expand)

;; 補完時に大文字小文字を区別しないhttp://www.clear-code.com/blog/2012/3/20.html
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; 部分一致の補完機能を使う
;; p-bでprint-bufferとか
;;(partial-completion-mode 1)

;; 補完可能なものを随時表示
;; 少しうるさい
(icomplete-mode 1)

;; マウスで選択するとコピーする Emacs 24 ではデフォルトが nil
(setq mouse-drag-copy-region t)

;; それぞれの色を設定する
(set-cursor-color "ForestGreen")   ;; マウスカーソル
(set-background-color "black")     ;; 背景色
(set-foreground-color "snow")      ;; 文字色
(set-face-foreground 'fringe "snow")       ;; 両脇のバーの文字色
(set-face-background 'fringe "dark red")   ;; 両脇のバーの背景色
(set-face-foreground 'mode-line-inactive "white")  ;; アクティブでないバッファの文字色
(set-face-background 'mode-line-inactive "MediumPurple4")  ;; アクティブでないバッファの背景色

;; 選択範囲に色を付ける
(setq transient-mark-mode t)
(set-face-foreground 'region "black")
(set-face-background 'region "PaleGreen")

;; 全角スペースやタブ文字、行末のスペースを色を付けて表示する
(global-font-lock-mode t)
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("¥t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ ¥t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)


;; -*- ここからの設定は Carbon Emacs(Emacs.app)で使うやつ -*-
;; 日本語の表示が崩れないようにする
(when (eq window-system 'mac)
  ;; 日本語フォントにヒラギノを使う
  (set-fontset-font nil 'japanese-jisx0208 '("ヒラギノ角ゴ*" . "jisx0208.*"))
  (set-fontset-font nil 'katakana-jisx0201 '("ヒラギノ角ゴ*" . "jisx0201.*"))
  ;; 日本語フォントの幅をASCIIの倍に調整(たいがいはこれでOK)
  (setq face-font-rescale-alist '(("-jisx02[^-]*-[^-]*¥¥'" . 1.2)))
  ;; 日本語フォントのboldに重ね打ちを使う(幅が変わらない)
  (setq face-ignored-fonts '("¥¥`-[^-]*-[^-]*-bold-.*-jisx02[^-]*-[^-]*¥¥'"))
  )


(put 'upcase-region 'disabled nil)

;; http://qiita.com/tadsan/items/6c658cc471be61cbc8f6
;; これを参考に，emacsのパッケージ管理をcaskでやることにした．

;; http://qiita.com/kametaro/items/2a0197c74cfd38fddb6b
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; line number
;; http://lisphack.blog137.fc2.com/blog-entry-14.html
(require 'linum)
(global-linum-mode 1)
(global-set-key [f6] 'linum-mode)

;; 対応するカッコを強調表示
(show-paren-mode t)

;; 現在行を目立たせる
(setq hl-line-face 'underline)
(global-hl-line-mode)

;; テーマを設定する
(load-theme 'manoj-dark t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm auto-complete yasnippet web-mode use-package smex smartparens projectile prodigy popwin pallet nyan-mode multiple-cursors magit idle-highlight-mode htmlize flycheck-cask expand-region exec-path-from-shell drag-stuff))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; package.el
;; http://www-he.scphys.kyoto-u.ac.jp/member/shotakaha/dokuwiki/doku.php?id=toolbox:emacs:package:start
;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (fset 'package-desc-vers 'package--ac-desc-version)
;; (package-initialise)


;;; ツールバーを消す
(tool-bar-mode -1)

;; C-a C-a

;; helm
(require 'helm-config)
(helm-mode 1)
  (define-key global-map (kbd "M-x")     'helm-M-x)
  (define-key global-map (kbd "C-x C-f") 'helm-find-files)
  (define-key global-map (kbd "C-x C-r") 'helm-recentf)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-x b")   'helm-buffers-list)
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
