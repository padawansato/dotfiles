;;; package --- Summary
;;; -*- Coding: utf-8 -*-
;;; Commentary:

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

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;; flycheck-pos-tip
;; (eval-after-load 'flycheck
;;   '(custom-set-variables
;;    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))


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
;; http://th.nao.ac.jp/MEMBER/zenitani/elisp-j.html#color
(set-face-background 'mode-line "white");;これで白紫に
(set-face-foreground 'mode-line "MediumPurple4");;
;; モードごとに色を変える
;; http://stackoverflow.com/questions/15906332/change-emacs-mode-line-color-based-on-major-mode
;; しかし，実装は出来なかった．

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
    (helm-migemo ace-isearch helm-swoop sr-speedbar redo+ undohist crux key-chord init-loader esup migemo init-open-recentf ace-jump-mode sequential-command flycheck-pos-tip undo-tree helm auto-complete yasnippet web-mode use-package smex smartparens projectile prodigy popwin pallet nyan-mode multiple-cursors magit idle-highlight-mode htmlize flycheck-cask expand-region exec-path-from-shell drag-stuff))))
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

;; helm
(require 'helm-config)
(helm-mode 1)
  (define-key global-map (kbd "M-x")     'helm-M-x)
  (define-key global-map (kbd "C-x C-f") 'helm-find-files)
  (define-key global-map (kbd "C-x C-r") 'helm-recentf)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-x C-b") 'helm-buffers-list)
  (define-key global-map (kbd "C-x b") 'helm-mini);;
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;;(setq search-default-regexp-mode nil);;http://qiita.com/duloxetine/items/a8cfcd9a55cb5791c2f4
;;(helm-migemo-mode 1);;http://qiita.com/ballforest/items/4db3d66df16d84a027d0;;error

;; projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; sequtntial-command
;; (define-sequential-command seq-home
;;   beginning-of-line beginning-of-buffer seq-return)
(require 'sequential-command-config)
(global-set-key "\C-a" 'seq-home)
(global-set-key "\C-e" 'seq-end)
(when (require 'org nil t)
  (define-key org-mode-map "\C-a" 'org-seq-home)
  (define-key org-mode-map "\C-e" 'org-seq-end))

;; auto-complete
    (require 'auto-complete)
    (require 'auto-complete-config)    ; 必須ではないですが一応
    (global-auto-complete-mode t)
    (define-key ac-completing-map (kbd "C-n") 'ac-next)      ; M-nで次候補選択
    (define-key ac-completing-map (kbd "C-p") 'ac-previous)  ; M-pで前候補選択
    (setq ac-dwim t)  ; 空気読んでほしい

;; fnをHyperに
(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

;; ace-jump-modehttp://d.hatena.ne.jp/rkworks/20120520/1337528737
(require 'ace-jump-mode)
;;(global-set-key (kbd "C-:") 'ace-jump-mode)
;; (ace-jump-mode t)
;; (defun add-keys-to-ace-jump-mode (prefix c &optional mode) 
;;   (define-key global-map
;;     (read-kbd-macro (concat prefix (string c)))
;;     `(lambda ()
;;        (interactive)
;;        (funcall (if (eq ',mode 'word)
;;                     #'ace-jump-word-mode
;;                   #'ace-jump-char-mode) ,c))))

;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-" c))
;; (loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-" c))
;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-M-" c 'word))
;; (loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-M-" c 'word))
;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-" c 'word))
;; (loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-" c 'word))

;; helm-swoop
;; http://fukuyama.co/helm-swoop
;; 選択範囲を検索ワードに使うこともできます。変数や関数がどこで使われているのかなど、tag系の検索ツールでは手の届かない所までカバーできるかと思います。
;; isearch実行中に[M-i]を押すとhelm-swoopに移行。またhelm-swoop実行中に[M-i]を押すと開いている全バッファを対象にしたhelm-multi-swoop-allに移行します。
;; 編集機能: helm-swoopまたはhelm-multi-swoop(-all)を実行中に[C-c C-e]と押すことでリストを編集して、バッファに反映[C-x C-s]させることができます。[C-SPC]で編集したい行をいくつかマークしておくと、[C-c C-e]で編集モードに移行した際にその行だけが編集対象となります。
;; Multiline機能: M-5 M-x helm-swoop や C-u 3 M-x helm-swoop とすることで複数の行単位で使用できます。
(require 'helm-swoop)
(global-set-key (kbd "C-r") 'helm-swoop)
;;; isearchからの連携を考えるとC-r/C-sにも割り当て推奨
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
;; キーバインドはお好みで
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
;; isearch実行中にhelm-swoopに移行
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; helm-swoop実行中にhelm-multi-swoop-allに移行
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)
;; 値がtの場合はウィンドウ内に分割、nilなら別のウィンドウを使用
(setq helm-swoop-split-with-multiple-windows nil)
;; ウィンドウ分割方向 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)
;; nilなら一覧のテキストカラーを失う代わりに、起動スピードをほんの少し上げる
(setq helm-swoop-speed-or-color t)

;; ace-isearch
;; http://emacs.rubikitch.com/helm-swoop/


;; Visual-mark
;;; C-u C-SPC C-SPC ...で過去のマークを遡れるようにする
(setq set-mark-command-repeat-pop t)
;;; 過去10個のマークを可視化する
(setq visible-mark-max 10)
;;; transient-mark-modeでC-SPC C-SPC、あるいはC-SPC C-gすると消えるバグ修正
(defun visible-mark-move-overlays--avoid-disappear (&rest them)
  (let ((mark-active t)) (apply them)))
(advice-add 'visible-mark-move-overlays :around 'visible-mark-move-overlays--avoid-disappear)

(global-visible-mark-mode 1)

;; recentf
(setq recentf-max-saved-items 2000) ;; 2000ファイルまで履歴保存する
(setq recentf-auto-cleanup 'never)  ;; 存在しないファイルは消さない
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))

(recentf-mode 1)
(bind-key "C-t" 'helm-recentf)

;; ido/anything/helmのうちどれかを指定する
(setq init-open-recentf-interface 'helm)
(init-open-recentf)

;;; diredを便利にする
(require 'dired-x)
;;; diredから"r"でファイル名をインライン編集する
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; info
;; (add-to-list 'Info-directory-list "~/.emacs.d/info")
;; (defun Info-find-node--info-ja (orig-fn filename &rest args)
;;   (apply orig-fn
;;          (pcase filename
;;            ("emacs" "emacs-ja")
;;            (t filename))
;;          args))
;; (advice-add 'Info-find-node :around 'Info-find-node--info-ja)

;;migemo
(when (locate-library "migemo")
  (setq migemo-command "/usr/local/bin/cmigemo") ; HERE cmigemoバイナリ
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict") ; HERE Migemo辞書
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init))

;; hey-chord
(require 'key-chord)
;;; タイムラグを設定
(setq key-chord-two-keys-delay 0.05)
(setq key-chord-one-key-delay 0.15)
(key-chord-mode 1)
;;; 設定例
;; (key-chord-define emacs-lisp-mode-map "df" 'describe-function)
;; (key-chord-define-global "vv" 'find-file)
(key-chord-define-global "kl" 'view-mode)
(key-chord-define-global "KL" 'view-mode)
(key-chord-define-global "vm" 'view-mode);;C-{をvimlikeにviewmode切り替えにしたほうがいいかも，押し間違えによる文字挿入がないし
(key-chord-define-global "ｋｌ" 'view-mode);;
(define-key global-map (kbd "C-{") 'view-mode);;
;; pdfをdiredで開く
(key-chord-define-global "op" 'crux-open-with)
(key-chord-define helm-map "op" 'crux-open-with);;試し,helmでpdfを開きたい

;;Vimではdがカットするオペレーションを、
;;yがコピーするオペレーションを、
;;vがマークするオペレーションを表わしています。
(key-chord-define-global "dw" 'kill-word*)    ;; | dw         | kill-word*   | カーソルが指している単語をカット               |
(key-chord-define-global "yw" 'copy-word)     ;; | yw         | copy-word    | カーソルが指している単語をコピー               |
(key-chord-define-global "vw" 'mark-word*)    ;; | vw         | mark-word*   | カーソルが指している単語をリージョン選択       |
(key-chord-define-global "ds" 'kill-sexp*)    ;; | ds         | kill-sexp*   | カーソルが指しているS式をカット                |
(key-chord-define-global "ys" 'copy-sexp)     ;; | ys         | copy-sexp    | カーソルが指しているS式をコピー                |
(key-chord-define-global "vs" 'mark-sexp*)    ;; | vs         | mark-sexp*   | カーソルが指しているS式をリージョン選択        |
(key-chord-define-global "dq" 'kill-string)   ;; | dq         | kill-string  | カーソルが指している文字列表記をカット         |
(key-chord-define-global "yq" 'copy-string)   ;; | yq         | copy-string  | カーソルが指している文字列表記をコピー         |
(key-chord-define-global "vq" 'mark-string)   ;; | vq         | mark-string  | カーソルが指している文字列表記をリージョン選択 |
(key-chord-define-global "dl" 'kill-up-list)  ;; | dl         | kill-up-list | カーソルが指しているリスト表記をカット         |
(key-chord-define-global "yl" 'copy-up-list)  ;; | yl         | copy-up-list | カーソルが指しているリスト表記をコピー         |
(key-chord-define-global "vl" 'mark-up-list)  ;; | vl         | mark-up-list | カーソルが指しているリスト表記をリージョン選択 |


;; repeat
;;直前のコマンドの繰り返し
;;M-x repeatをC-,に割り当てる設定はこうなります。
(global-set-key (kbd "C-,") 'repeat)
;;または
;; (require 'bind-key)
;; (bind-key* "C-," 'repeat)

;; pdfを開きたい．
;; dired にて crux-open-with
(require 'crux)

;; undo tree
;; (require 'undo-tree)
(setq undo-tree-mode-lighter "")
(global-undo-tree-mode 1)
;; undo hist
(require 'undohist)
(undohist-initialize)
;;; 永続化を無視するファイル名の正規表現
;; (setq undohist-ignored-files
;;       '("/tmp/" "COMMIT_EDITMSG"))

;; redo+
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)

;; 起動時間計測
;; M-x esup

;; neo-tree
;; M-x speedbarとほぼ等しい？
;; http://stackoverflow.com/questions/843645/a-good-project-tree-browser-for-emacs
(global-set-key [f8] 'neotree-toggle)
;; 隠しファイルをデフォルトで表示
(setq neo-show-hidden-files t)
;; neotree でファイルを新規作成した後、自動的にファイルを開く
(setq neo-create-file-auto-open t)
;; delete-other-window で neotree ウィンドウを消さない
(setq neo-persist-show t)
;; キーバインドをシンプルにする
(setq neo-keymap-style 'concise)
;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
(setq neo-smart-open t)

;; speedbar
(setq sr-speedbar-right-side nil)
(global-set-key [f9] 'sr-speedbar-toggle)

;; カーソル高速点滅
;; http://blog.sushi.money/entry/20110621/1308625467
(setq blink-cursor-interval 0.5)
(setq blink-cursor-delay 0.5)
(blink-cursor-mode 1)

;; thing-opt
;; http://dev.ariel-networks.com/articles/emacs/part5/
;;
(setq load-path (cons "~/.emacs.d/elisp" load-path))
(require 'thing-opt)
(define-thing-commands)

;;
;; whitespace
;; http://keisanbutsuriya.hateblo.jp/entry/2015/02/03/153149
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
;;                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))
(setq whitespace-display-mappings
      '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
(global-whitespace-mode 1)


;; vim likeに　view-modeで常に開く
;; http://nvnote.com/emacs-open-file-always-read-only/
(add-hook 'find-file-hooks 'view-mode)

;; view-modeの設定
;; http://d.hatena.ne.jp/rubikitch/20081104/1225745862
;; http://ochiailab.blogspot.jp/2015/04/emacsview-mode.html
(setq view-read-only t)
(defvar pager-keybind
      `( ;; vi-like
        ("b" . backward-word)
        ("f" . forward-word)
        ;; ("j" . next-window-line)
        ;; ("k" . previous-window-line)
;; ("k" . enlarge-vertically);;これでは動かなかった．なぜ？2017/03/24
;; ("h" . shrink-horizontally)
;; ("j" . shrink-vertically)
;; ("l" . enlarge-horizontally)
;; (win-switch-set-keys '("J") 'shrink-vertically)
;; (win-switch-set-keys '("H") 'shrink-horizontally)
;; (win-switch-set-keys '("L") 'enlarge-horizontally)
        (";" . gene-word)
;;        ("b" . scroll-down)
;;        (" " . scroll-up)
        ;; ;; w3m-like
        ;; ("m" . gene-word)
        ;; ("i" . win-delete-current-window-and-squeeze)
        ;; ("w" . forward-word)
        ;; ("e" . backward-word)
        ;; ("(" . point-undo)
        ;; (")" . point-redo)
        ;; ("J" . ,(lambda () (interactive) (scroll-up 1)))
        ;; ("K" . ,(lambda () (interactive) (scroll-down 1)))
        ;; ;; bm-easy
        ;; ("." . bm-toggle)
        ;; ("[" . bm-previous)
        ;; ("]" . bm-next)
        ;; ;; langhelp-like
        ;; ("c" . scroll-other-window-down)
        ;; ("v" . scroll-other-window)
        ;; ))
        ;; ("h" . backward-char)
        ;; ("l" . forward-char)
        ;; ("j" . next-line)
        ;; ("k" . previous-line)
        ;; ("S-SPC" . scroll-down)
        ;; (" " . scroll-up)
        ("@" . set-mark-command)
        ;; ("a" . beginning-of-buffer)
        ;; ("e" . end-of-buffer)
        ;; ("f" . forward-word)
        ;; ("b" . backward-word)
        ;; ("]" . forward-word)
        ;; ("[" . backward-word)
        ("]" . forward-paragraph)
        ("[" . backward-paragraph)
        ;; ("}" . forward-paragraph)
        ;; ("{" . backward-paragraph)
        ("n" . ,(lambda () (interactive) (scroll-up 1)))
        ("p" . ,(lambda () (interactive) (scroll-down 1)))
        ("N" . ,(lambda () (interactive) (scroll-up 10)))
        ("P" . ,(lambda () (interactive) (scroll-down 10)))
        ("c" . scroll-other-window-down)
        ("v" . scroll-other-window)
        ("(" . point-undo)
        (")" . point-redo)
        ("J" . jaunte)
;;        ))
        ;; ("h" . backward-char)
        ;; ("l" . forward-char)
        ("j" . next-line)
        ("k" . previous-line)
        ;; ("S-SPC" . scroll-down)
        (" " . ,(lambda () (interactive) (scroll-up 1)));;scroll-up)
        ;; ("@" . set-mark-command)
        ;; ("a" . beginning-of-buffer)
        ;; ("e" . end-of-buffer)
        ;; ("f" . forward-word)
        ;; ("b" . backward-word)
        ;; ("]" . forward-word)
        ;; ("[" . backward-word)
        ;; ("}" . forward-paragraph)
        ;; ("{" . backward-paragraph)
        ;; ("n" . ,(lambda () (interactive) (scroll-up 1)))
        ;; ("p" . ,(lambda () (interactive) (scroll-down 1)))
        ;; ("N" . ,(lambda () (interactive) (scroll-up 10)))
        ;; ("P" . ,(lambda () (interactive) (scroll-down 10)))
        ;; ("c" . scroll-other-window-down)
        ;; ("v" . scroll-other-window)
        ;; ("(" . point-undo)
        ;; (")" . point-redo)
        ;; ("J" . jaunte)
        ))
;; ;; less like
;; (define-key view-mode-map (kbd "C-h") 'backward-char)
;; (define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
;; (define-key view-mode-map (kbd "?") 'View-search-regexp-backward )
;; (define-key view-mode-map (kbd "G") 'View-goto-line-last)
;; (define-key view-mode-map (kbd "b") 'View-scroll-page-backward)
;; (define-key view-mode-map (kbd "f") 'View-scroll-page-forward)
(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
        (define-key keymap key cmd))))
  keymap)

(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (define-key view-mode-map " " 'scroll-up))
(add-hook 'view-mode-hook 'view-mode-hook0)

;; 書き込み不能なファイルはview-modeで開くように
(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))
;; 書き込み不能な場合はview-modeを抜けないように
(defvar view-mode-force-exit nil)
(defmacro do-not-exit-view-mode-unless-writable-advice (f)
  `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
     (if (and (buffer-file-name)
              (not view-mode-force-exit)
              (not (file-writable-p (buffer-file-name))))
         (message "File is unwritable, so stay in view-mode.")
       ad-do-it)))

(do-not-exit-view-mode-unless-writable-advice view-mode-exit)
(do-not-exit-view-mode-unless-writable-advice view-mode-disable)
;;view-modeの色
;;https://github.com/fujimisakari/.emacs.d/blob/master/inits/17-viewer.el
;; (require 'viewer)
;; ;; C-x C-r は view-modeでファイルを開く
;; (setq view-read-only t)

;; view-modeであることが一目で分かるようにする．
;; https://books.google.co.jp/books?id=TaNQMRcneSQC&pg=PA220&lpg=PA220&dq=emacs+view-mode+color&source=bl&ots=JpHeQwcU9w&sig=vPbf_1gp4R069oXV9cvjnqqthD8&hl=ja&sa=X&ved=0ahUKEwiOypv-yvnSAhWIxLwKHQqADZsQ6AEITzAH#v=onepage&q=emacs%20view-mode%20color&f=false
;;(require 'viewer)
;; 色名を指定する
;;(viewer-change-modelinge-color-setup)

;; 特定のファイルを view-mode で開くようにする
(setq view-mode-by-default-regexp "\\.log$")
;;; view-mode のときに mode-line に色をつける
;; 書き込み不可ファイルを開く場合は濃い赤色
(setq viewer-modeline-color-unwritable "red")
;; 書き込み可能ファイルを開く場合はオレンジ色
(setq viewer-modeline-color-view "orange")
;; view-modeの切り替え時のデフォルト色
(setq viewer-modeline-color-default "SlateBlue3")

;; ミニバッファ入力時に自動的に英語入力モードに
;; カーソルの色を変える時に参考にしたサイトに設定があったのでそのままお借りする。
(when (functionp 'mac-auto-ascii-mode)  ;; ミニバッファに入力時、自動的に英語モード
  (mac-auto-ascii-mode 1))

;; window間　移動
;; (defun other-window-or-split (val)
;;   (interactive)
;;   (when (one-window-p)
;; ;    (split-window-horizontally) ;split horizontally
;;     (split-window-vertically) ;split vertically
;;   )
;;   (other-window val))

;; (global-set-key (kbd "<C-tab>") (lambda () (interactive) (other-window-or-split 1)))
;; (global-set-key (kbd "<C-S-tab>") (lambda () (interactive) (other-window-or-split -1)))

;; window size
;; http://d.hatena.ne.jp/khiker/20100119/window_resize
;; http://d.hatena.ne.jp/mooz/20100119/p1
(global-set-key "\C-c\C-r" 'my-window-resizer)
(defun my-window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))

;; win-switch
(require 'win-switch)
;;; 0.75秒間受け付けるタイマー
(setq win-switch-idle-time 0.75)
;;; 好きなキーを複数割り当てられる
;; ウィンドウ切り替え
(win-switch-set-keys '("k") 'up)
(win-switch-set-keys '("j") 'down)
(win-switch-set-keys '("h") 'left)
(win-switch-set-keys '("l") 'right)
(win-switch-set-keys '("o") 'next-window)
(win-switch-set-keys '("p") 'previous-window)
;; リサイズ
(win-switch-set-keys '("K") 'enlarge-vertically)
(win-switch-set-keys '("J") 'shrink-vertically)
(win-switch-set-keys '("H") 'shrink-horizontally)
(win-switch-set-keys '("L") 'enlarge-horizontally)
;; 分割
(win-switch-set-keys '("3") 'split-horizontally)
(win-switch-set-keys '("2") 'split-vertically)
(win-switch-set-keys '("0") 'delete-window)
;; その他
(win-switch-set-keys '(" ") 'other-frame)
(win-switch-set-keys '("u" [return]) 'exit)
(win-switch-set-keys '("\M-\C-g") 'emergency-exit)
;; C-x oを置き換える
(global-set-key (kbd "C-x o") 'win-switch-dispatch)


;; 終了時にオートセーブファイルを消す
;; http://emacs.clickyourstyle.com/articles/265
(setq delete-auto-save-files t)
;; http://ja.stackoverflow.com/questions/9875/emacsで編集したデータを1日毎にディレクトリを分けてバックアップしたい
;; .emacs.d/backup　に入る．しかし，上記のオートセーブファイルを消す機能と競合してはいまいか．確かめれば良いこと．
(defun my:make-backup-file-name (file)
  (let ((dirname (file-name-as-directory
                  (format-time-string
                   (expand-file-name "backup/%Y-%m-%d/" user-emacs-directory)))))
    (or (file-directory-p dirname)
        (make-directory dirname t))
    (expand-file-name (file-name-nondirectory file) dirname)))

(setq make-backup-file-name-function #'my:make-backup-file-name)

;; 垂直　インデント　揃える
;; M-x align-regexp
;; 揃える文字

;; カッコ　対応　自動
(electric-pair-mode 1)

;; 警告音の代わりに画面フラッシュ
;; (setq visible-bell t)
;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

;; サーバーとしてのEmacsの使用
(server-start)
