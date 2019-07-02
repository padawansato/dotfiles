;;; package --- Summary
;;; -*- Coding: utf-8 -*-
;;; Commentary:

;; メニューバーを非表示
(menu-bar-mode 0)
;; ツールバーを非表示
(tool-bar-mode 0)

(add-to-list 'load-path "~/.emacs.d/elisp")

;;; 言語環境の指定

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; http://qiita.com/tadsan/items/6c658cc471be61cbc8f6
;; これを参考に，emacsのパッケージ管理をcaskでやることにした．

;; http://qiita.com/kametaro/items/2a0197c74cfd38fddb6b
(require 'cask "~/.cask/cask.el")
(cask-initialize)
;;; init-loader 設定
;;http://kiririmode.hatenablog.jp/entry/20141228/1419762171
(require 'init-loader)

(setq init-loader-show-log-after-init "error-only")
(init-loader-load "~/.emacs.d/inits")


(require 'pallet)
(pallet-mode t)




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
;;(set-face-background 'mode-line "white");;これで白紫に
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


(if window-system (progn  ;; ←GUI用設定を、ここに記述
;; line number
;; http://lisphack.blog137.fc2.com/blog-entry-14.html
(require 'linum)
(global-linum-mode 1)
(global-set-key [f6] 'linum-mode)
))


;; 対応するカッコを強調表示
(show-paren-mode t)

;; 現在行を目立たせる
;; (setq hl-line-face 'underline)
;; (global-hl-line-mode)
;; http://keisanbutsuriya.hateblo.jp/entry/2015/02/01/162035
;; (custom-set-faces
;; '(hl-line ((t (:background "color-236"))))
;; )




;; テーマを設定する
(load-theme 'spacemacs-dark t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (python-mode markdown-mode cl-generic ein jedi win-switch py-autopep8 helm-dash tabbar go-playground smooth-scrolling markdown-toc google-translate yatex haskell-mode c-eldoc quickrun helm-migemo ace-isearch helm-swoop sr-speedbar redo+ undohist crux key-chord init-loader esup migemo init-open-recentf ace-jump-mode sequential-command flycheck-pos-tip undo-tree helm auto-complete yasnippet web-mode use-package smex smartparens projectile prodigy popwin pallet Nyan-mode multiple-cursors Magit idle-highlight-mode htmlize flycheck-cask expand-region exec-path-from-shell Drag-stuff)))
 '(showkey-log-mode t)
 '(showkey-tooltip-mode t))
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
;;  (define-key global-map (kbd "C-x C-r") 'helm-recentf);;C-t
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-x C-b") 'helm-buffers-list)
  (define-key global-map (kbd "C-x b") 'helm-mini);;
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;;(setq search-default-regexp-mode nil);;http://qiita.com/duloxetine/items/a8cfcd9a55cb5791c2f4
;;(helm-migemo-mode 1);;http://qiita.com/ballforest/items/4db3d66df16d84a027d0;;error

;; projectile
(require 'helm-projectile)
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

;; ace-isearch
;; http://emacs.rubikitch.com/ace-isearch/
;; ace-jump-modehttp://d.hatena.ne.jp/rkworks/20120520/1337528737
(require 'ace-jump-mode)
(global-ace-isearch-mode 1)
(add-hook 'ace-jump-mode-before-jump-hook (lambda ()(message "I am jumping")))


;; (global-set-key (kbd "C-:") 'ace-jump-mode)
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
;; Multiline機能: M-5 M-x helm-swoop や C-u 3 M-x helm-swoop とすることで複数のl行単位で使用できます。
(require 'helm-swoop)
(global-set-key (kbd "C-r") 'helm-swoop)
;;; isearchからの連携を考えるとC-r/C-sにも割り当て推奨
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
;; キーバインドはお好みで
(global-set-key (kbd "M-i") 'helm-swoop);;下で2回でmultiに変更．
(global-set-key (kbd "M-l") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
;; isearch実行中にhelm-swoopに移行
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; helm-swoop実行中にhelm-multi-swoop-allに移行
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; 文字列を入力してから検索するまでのタイムラグを設定する（デフォルトは 0.01）
;; https://ubutun.blogspot.com/2016/01/helm-swoopemacs.html
;;(setq helm-input-idle-delay 0.2)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)
;; 値がtの場合はウィンドウ内に分割、nilなら別のウィンドウを使用
(setq helm-swoop-split-with-multiple-windows nil)
;; ウィンドウ分割方向 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)
;; nilなら一覧のテキストカラーを失う代わりに、起動スピードをほんの少し上げる
(setq helm-swoop-speed-or-color t)



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
(key-chord-define-global "vm" 'view-mode);;C-{をvimlikeにviewmode切り替えにしたほうがいいかも，押し間違えによる文字挿入がないし
(key-chord-define-global "ｋｌ" 'view-mode);;
(key-chord-define-global "jk" 'er/expand-region);;expand-region
(key-chord-define-global "jl" 'er/contract-region);;expand-region　縮める
;;(key-chord-define-global "hj" 'er/contract-region);;expand-region　縮める
;;(key-chord-define-global ";j" 'mc/mark-all-like-this);; すべての選択部分を編集する
(key-chord-define-global "ow" 'win-switch-dispatch) ;;window切り替え

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
(setq load-path (cons "~/.emacs.d/elipsp" load-path))
(require 'thing-opt)
(define-thing-commands)
;; cc-defs.el
;; http://d.hatena.ne.jp/mooz/20100421/p1
;; (require 'cc-defs.el)



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
;;(add-hook 'find-file-hooks 'view-mode)
;;問題点これのせいでpackege　が上手く入らない?<=正解？しかし，直前にEmacs.appから入れようとして失敗した影響かもしれない．

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
        ("h" . backward-char)
        ("l" . forward-char)
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
(require 'viewer)
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
(global-set-key "\C-c\C-c" 'my-window-resizer)
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
;; .emacs.d/backup　に入る．しかし，上記のオートセーブファイルを消す機能と競合してはいまいか．確かめれば良いこと．2017-05-11時点で，競合してはいないようである．

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

;; インデント　スペース
(setq-default indent-tabs-mode nil)

;; C-jで補完
(global-set-key "\C-j" 'dabbrev-expand)



;; カッコ　対応　自動
(electric-pair-mode 1)

;; 警告音の代わりに画面フラッシュ
;; (setq visible-bell t)
;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

;; サーバーとしてのEmacsの使用
(server-start)

;; 簡単な実行
;; http://emacs.rubikitch.com/quickrun/
;; M-x quickrun
;; (require 'quickrun)

;; ;;; 初めにファイルを開いたときに実行方法を決めさせる
;; ;;; outputterとeshellを統合させる
;; (defvar-local my-quickrun-execute-method nil)
;; (defvar-local my-quickrun-command 'quickrun)
;; (defvar my-quickrun-execute-method-alist
;;   '((default . (lambda () (setq quickrun-option-outputter nil)))
;;     (message . (lambda () (setq quickrun-option-outputter 'message)))
;;     (null . (lambda () (setq quickrun-option-outputter 'null)))
;;     ;; (eshell . (lambda () (setq my-quickrun-command 'quickrun-shell)))
;;     (screen . (lambda () (setq my-quickrun-command 'quickrun-screen)))))

;; (defun my-quickrun (arg)
;;   "俺のquickrun。初めてファイルを開いたとき、入力ファイル、実行方法、引数を尋ねる。
;; C-uをつけたらそれらをもう一度尋ねる。

;; 入力ファイルを尋ねるのは*.qrinput*が2つ以上存在するときのみ。
;; helmを使っているのでC-zで入力ファイルの内容を確認できる。"
;;   (interactive "P")
;;   (when arg
;;     (setq my-quickrun-execute-method nil
;;           my-quickrun-command 'quickrun
;;           quickrun-option-args nil))
;;   (my-quickrun/may-ask-stdin-file)
;;   (my-quickrun/may-ask-execute-method)
;;   (my-quickrun/may-ask-args)
;;   (setq current-prefix-arg nil)
;;   (funcall my-quickrun-command))

;; (defun my-quickrun/may-ask-stdin-file ()
;;   (let ((stdin-files (directory-files default-directory nil
;;                                       (concat (quickrun/stdin-file-name) "*")))
;;         new-stdin-file)
;;     (when (and (null my-quickrun-execute-method) (<= 2 (length stdin-files)))
;;       (setq new-stdin-file
;;             (save-window-excursion
;;               (helm :sources 'helm-source-files-in-current-dir
;;                     :input (concat quickrun/executed-file
;;                                    (default-value 'quickrun-input-file-extension)))))
;;       (when new-stdin-file
;;         (setq-local quickrun-input-file-extension
;;                     (concat "." (file-name-extension (car new-stdin-file))))))))

;; (defun my-quickrun/may-ask-execute-method ()
;;   (setq my-quickrun-execute-method
;;         (or my-quickrun-execute-method
;;             (completing-read "Execute method: "
;;                              (mapcar 'car my-quickrun-execute-method-alist)
;;                              nil t)))
;;   (funcall (assoc-default my-quickrun-execute-method my-quickrun-execute-method-alist)))

;; (defun my-quickrun/may-ask-args ()
;;   (setq quickrun-option-args
;;         (or quickrun-option-args
;;             (read-string "QuickRun Arg: "
;;                          (car quickrun--with-arg--history)
;;                          'quickrun--with-arg--history))))

;; ;;; execute in screen
;; (require 'mylisp-screen)

;; (defun quickrun-screen ()
;;   (interactive)
;;   (let ((quickrun-timeout-seconds nil))
;;     (advice-add 'quickrun/exec :override 'quickrun/exec--screen)
;;     (unwind-protect
;;         (quickrun)
;;       (advice-remove 'quickrun/exec 'quickrun/exec--screen))))

;; (defun quickrun/exec--screen (cmd-list &rest them)
;;   (kill-buffer quickrun/buffer-name)
;;   (screen (quickrun/concat-commands cmd-list) "->quickrun" t))


;; (provide 'mylisp-quickrun)

;; c-eldoc
;; http://d.hatena.ne.jp/mooz/20100421/p1
;; (load "c-eldoc")
;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'eldoc-idle-delay) 0.20)
;;             (c-turn-on-eldoc-mode)
;;             ))
;;http://futurismo.biz/archives/3071
;; (require 'c-eldoc)
;; (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
;; (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
;; (setq c-eldoc-buffer-regenerate-time 60)

;; multiple-cursor
;; https://gist.github.com/ongaeshi/5891530
;; http://ongaeshi.hatenablog.com/entry/20121205/1354672102
;; http://qiita.com/ongaeshi/items/3521b814aa4bf162181d
;;(global-set-key (kbd "C-9") 'mc/mark-next-like-this)
;;(global-set-key (kbd "C-8") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; http://tam5917.hatenablog.com/entry/20121208/1354931551
(require 'multiple-cursors)
(require 'smartrep)
(declare-function smartrep-define-key "smartrep")
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C-;")   'mc/mark-all-like-this)
(global-unset-key "\C-i")
(smartrep-define-key global-map "C-i"
  '(("C-p"      . 'mc/mark-previous-like-this)
    ("C-n"      . 'mc/mark-next-like-this)
    ("u"        . 'mc/unmark-next-like-this)
    ("U"        . 'mc/unmark-previous-like-this)
    ("s"        . 'mc/skip-to-next-like-this)
    ("S"        . 'mc/skip-to-previous-like-this)
    (";"        . 'mc/mark-all-like-this)))



;; outline
;; http://emacs.rubikitch.com/origami/
;; http://emacs.rubikitch.com/outline-magic/

;; expand-region
(require 'expand-region)
;;(global-set-key (kbd "C-.") 'er/expand-region)
;;(global-set-key (kbd "C-,") 'er/contract-region) ;; リージョンを狭める


;;別のバッファをスクロール
;;http://www.bookshelf.jp/soft/meadow_29.html#SEC395
;; Meadow には別のバッファをスクロールさせる機能が標準で付属しています．
;; C-M-v( M-x scroll-other-window ) と C-M-S-v (M-x scroll-other-window-down ) です．
;; それぞれを実行すると，別のバッファで C-v，M-v したのと同じようにスクロー ルします
(global-set-key (kbd "M-n") 'scroll-other-window)
(global-set-key (kbd "M-p") 'scroll-other-window-down)
(global-set-key (kbd "M-o") 'other-frame);;frame　切替

;; cycle frame　動かない．
;;(require 'cycle-windows-frames)
;;(global-set-key (kbd "C-8") 'cycle-windows)

;; orgmode にて　改行　折り返し
;; http://d.hatena.ne.jp/stakizawa/20091025/t1
(setq org-startup-truncated nil)
(defun change-truncation()
  (interactive)
  (cond ((eq truncate-lines nil)
         (setq truncate-lines t))
        (t
         (setq truncate-lines nil))))


;; 自動で　#hoge# のようなバックアップを作らない
;; しかし，.emacs.d 以下に自動で作るようにしたバックアップとの依存関係は分からない．
(setq auto-save-default nil)

(require 'google-translate)

(defvar google-translate-english-chars "[:ascii:]’“”–"
  "これらの文字が含まれているときは英語とみなす")
(defun google-translate-enja-or-jaen (&optional string)
  "regionか、現在のセンテンスを言語自動判別でGoogle翻訳する。"
  (interactive)
  (setq string
        (cond ((stringp string) string)
              (current-prefix-arg
               (read-string "Google Translate: "))
              ((use-region-p)
               (buffer-substring (region-beginning) (region-end)))
              (t
               (save-excursion
                 (let (s)
                   (forward-char 1)
                   (backward-sentence)
                   (setq s (point))
                   (forward-sentence)
                   (buffer-substring s (point)))))))
  (let* ((asciip (string-match
                  (format "\\`[%s]+\\'" google-translate-english-chars)
                  string)))
    (run-at-time 0.1 nil 'deactivate-mark)
    (google-translate-translate
     (if asciip "en" "ja")
     (if asciip "ja" "en")
     string)))
(global-set-key (kbd "C-c t") 'google-translate-enja-or-jaen)

;; ssh scp
(require 'tramp)
(setq tramp-default-method "ssh")

;; markdown
;; http://qiita.com/gooichi/items/2b185dbdf24166a15ca4
;; C-c C-c p (or m)
(setq markdown-command "multimarkdown")

;;ipython notebook with emacs
;;https://github.com/millejoh/emacs-ipython-notebook

;; smooth-scrolling
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)


;; markdown-toc-generate-toc
(global-set-key (kbd "M-m") 'markdown-toc-generate-toc)

;; mouse 
(setq
 ;; ホイールでスクロールする行数を設定
 mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control)))
 ;; 速度を無視する
 mouse-wheel-progressive-speed nil)

(setq scroll-preserve-screen-position 'always)


;; ;; haskell-mode
;; ;; フックを設定
;; (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
;; (add-hook 'haskell-mode-hook 'haskell-doc-mode)
;; ;; (add-hook 'haskell-mode-hook 'view-mode)

;; (setq haskell-process-type 'stack-ghci)
;; (setq haskell-process-path-ghci "stack")
;; (setq haskell-process-args-ghci "ghci")

;; ;; 環境変数PATHを設定しない場合は必要な設定
;; (add-to-list 'exec-path "~/stack-1.1.2-osx-x86_64")

;; eww
;; http://www-he.scphys.kyoto-u.ac.jp/member/shotakaha/dokuwiki/doku.php?id=toolbox:emacs:eww:start
;; q EWWを閉じる
;; g ページの再読み込み
;; w ページのURLをコピー
;; d リンク先ファイルをダウンロード（“~/Downloads/“）
;; l ページを戻る
;; r ページを進む
;; H 履歴を表示（eww history バッファが開く）
;; b ブックマークに追加
;; B ブックマーク一覧を表示（eww bookmarksバッファが開く)
;; & ウェブサイトを外部ブラウザで開く
;; v ページのソースを表示する
;; C クッキー一覧を表示する
(setq eww-search-prefix "http://www.google.co.jp/search?q=")
;; (setq eww-search-prefix "https://www.google.co.jp/search?btnI&q=")

;; helm-dash
;; https://github.com/areina/helm-dash

;; github like markdown preview "C-c g"
;; http://qiita.com/shibataka000/items/96f6b35f2e97a9c1cd0b
;; 怖いから捨て垢
(setq github-user "satotakuie")
(setq github-pass "8oV-sNL-t44-czs")

(defun my-markdown-preview ()
  (interactive)
  (when (get-process "grip") (kill-process "grip"))
  (when (get-process "grip<1>") (kill-process "grip<1>"))  ;; プロセスが二重に起動していた場合、そちらもkillする
  (start-process "grip" "*grip*" "grip" (format "--user=%s" github-user) (format "--pass=%s" github-pass) "--browser" buffer-file-name)
  (when (get-process "grip") (set-process-query-on-exit-flag (get-process "grip") nil))
  (when (get-process "grip<1>") (set-process-query-on-exit-flag (get-process "grip<1>") nil))    ;; プロセスが二重に起動していた場合、そちらもフラグを設定する
  )
(define-key global-map (kbd "C-c g") 'my-markdown-preview)

;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)


;; https://stackoverflow.com/questions/8010552/how-can-i-stop-emacs-cocoa-osx-making-noise-when-scrolling-and-hitting-the-top
(setq ring-bell-function (lambda () (message "*beep*")))






;; ---------------------------------------------------------
;; YaTeX の設定
;; ---------------------------------------------------------
   
;; Add library path
(add-to-list 'load-path "~/.emacs.d/elisp/yatex/yatex1.80")
;; YaTeX mode
(setq auto-mode-alist
    (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "platex")
(setq dviprint-command-format "dvipdfmx %s")
;; use Preview.app
(setq dvi2-command "open -a Preview")
(defvar YaTeX-dvi2-command-ext-alist    
  '(("xdvi" . ".dvi")                   
      ("ghostview\\|gv" . ".ps")
      ("acroread\\|pdf\\|Preview\\|open" . ".pdf")))


;; jedi
;; http://tkf.github.io/emacs-jedi/latest/
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 


;; ipython ein
;; https://tkf.github.io/emacs-ipython-notebook/
;; (require 'ein)
;; (setq ein:use-auto-complete t)
;; (setq ein:use-smartrep t)

;; http://millejoh.github.io/emacs-ipython-notebook/
;; (require 'ein-loaddefs)
;; (require 'ein-notebook)
;; (require 'ein-subpackages)

;; shellのパスの引き継ぎ
;; http://keisanbutsuriya.hateblo.jp/entry/2017/06/21/010257
(exec-path-from-shell-initialize)

;; showkey
;; コマンドの履歴
;; http://emacs.rubikitch.com/showkey/
;; (require 'showkey)
;; M-x showkey-log-mode は別フレームで操作履歴を表示
;; M-x showkey-tooltip-mode は操作中のキーをカーソルの近くで表示
;; これでも行ける　C-h l / <f1> l (view-lossage) は最近実行したキーを表示

;; skewer
;;(add-hook 'js2-mode-hook 'skewer-mode)
;;(add-hook 'css-mode-hook 'skewer-css-mode)
;;(add-hook 'html-mode-hook 'skewer-html-mode)


;; websocket
(require 'websocket)

;; rubyマジックコメントなし
;; https://qiita.com/tetsuo_jp/items/c05095931ae080f89d21
(setq ruby-insert-encoding-magic-comment nil)


;; ruby end自動生成
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)

;; ruby-mode utf-8 マジックコメント
;; https://qiita.com/tetsuo_jp/items/c05095931ae080f89d21
(setq ruby-insert-encoding-magic-comment nil)

;; ,dired Copy 
;; http://emacs.rubikitch.com/helm-dired-history/
(with-eval-after-load 'dired
  (require 'helm-dired-history)
  (define-key dired-mode-map "," 'helm-dired-history-view))

;; git-gutter-fringe
;; https://github.com/syohex/emacs-git-gutter-fringe
(require 'git-gutter-fringe)
(set-face-foreground 'git-gutter-fr:modified "red")
(set-face-foreground 'git-gutter-fr:added    "green")
(set-face-foreground 'git-gutter-fr:deleted  "white")
(setq git-gutter-fr:side 'right-fringe);;右側



;;git-gutterこれをするとguiバグる
;;(global-git-gutter-mode t)

;; magit
(require 'magit)
;; http://yamakichi.hatenablog.com/entry/2016/06/29/133246
(setq-default magit-auto-revert-mode nil)
(setq vc-handled-backends '())
(bind-key "C-x g" 'magit-status)


(custom-set-faces
 '(magit-diff-added ((t (:background "black" :foreground "green"))))
 '(magit-diff-added-highlight ((t (:background "white" :foreground "green"))))
 '(magit-diff-removed ((t (:background "black" :foreground "blue"))))
 '(magit-diff-removed-hightlight ((t (:background "white" :foreground "blue"))))
 '(magit-hash ((t (:foreground "red"))))
)



;; full screan
;; (global-set-key (kbd "C-^") 'toggle-frame-fullscrean)

;; full screan
;; http://akaneko85r.hatenablog.com/category/Emacs?page=1428848584
; fullscrean-mode ----------------------------------------
;; (require 'fullscreen-mode)
;; (setq fullfullscreen-flg nil)
;; (defun fullscreen-mode-fullfullscreen-toggle ()
;;   (interactive)
;;   (if fullfullscreen-flg
;;       (progn (tool-bar-mode 1)
;;          (menu-bar-mode 1)
;;          (fullscreen-mode-windowed)
;;          (setq fullfullscreen-flg nil))
;;     (progn (tool-bar-mode 0)
;;        (menu-bar-mode 0)
;;        (fullscreen-mode-fullscreen)
;;        (setq fullfullscreen-flg t))))
;; (define-key global-map (kbd "<f11>") 'fullscreen-mode-fullfullscreen-toggle)
; ---------------------------------------- fullscrean-mode

;; projectile-rails
;; https://qiita.com/elbowroomer/items/8e3c4b075a181f224591
(require 'projectile)
(projectile-global-mode)
(require 'projectile-rails)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; web-mode
;; https://qiita.com/elbowroomer/items/30bdf1c062a6ed3fa488
(require 'web-mode)
;; 拡張子の設定
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
;; インデント関係
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-indent-offset 2);;元々htmlだった．
  (setq web-mode-css-indent-offset    2)
  (setq web-mode-script-indent-offset 2)
  (setq web-mode-php-indent-offset    4)
  (setq web-mode-java-indent-offset   4)
  (setq web-mode-asp-indent-offset    4)
;;  (setq indent-tabs-mode t);;ハードタブ
;;  (setq tab-width 2))
(add-hook 'web-mode-hook 'web-mode-hook)

;; https://qiita.com/hayamiz/items/130727c09230fab0c097
(setq web-mode-auto-close-style 3)
(setq web-mode-tag-auto-close-style t)
(setq web-mode-enable-auto-pairing t)

;; 
;; server start for emacs-client
(when window-system                       ; GUI時
  (require 'server)
  (unless (eq (server-running-p) 't)
    (server-start)

    (defun iconify-emacs-when-server-is-done ()
      (unless server-clients (iconify-frame)))

    ;; ;; C-x C-cに割り当てる(好みに応じて)
    ;; (global-set-key (kbd "C-x C-c") 'server-edit)

    ;; M-x exitでEmacsを終了できるようにする
    (defalias 'exit 'save-buffers-kill-emacs)

    ;; 起動時に最小化する
    (add-hook 'after-init-hook 'iconify-emacs-when-server-is-done)

    ;; 終了時にyes/noの問い合わせ
    ;; (setq confirm-kill-emacs 'yes-or-no-p)
      )

;; dired D削除 ゴミ箱へ
;; http://yak-shaver.blogspot.com/2013/07/dired.html
(setq delete-by-moving-to-trash t)

;; this is the end line

;;; init-loader設定
(require 'init-loader)
(setq init-loader-show-log-after-init 'error-only)(i
						   nit-loader-load "~/.dotfiles/dotfiles/.emacs.d/inits")


(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-user-dictionary nil)
(setq migemo-coding-system 'utf-8)
(setq migemo-regex-dictionary nil)
(load-library "migemo")
(migemo-init)


;;  helm-smex
(require 'helm-smex)
(global-set-key [remap execute-extended-command] #'helm-smex)
(global-set-key (kbd "M-X") #'helm-smex-major-mode-commands)


;; yatex
(require 'yatex)                ;; パッケージ読み込み
(add-to-list 'auto-mode-alist '("\\.tex\\'" . yatex)) ;;auto-mode-alistへの追加
(setq tex-command "latex")       ;; 自分の環境に合わせて""内を変えてください
(setq bibtex-command "pbibtex")    ;; 自分の環境に合わせて""内を変えてください
;;reftex-mode
(add-hook 'yatex-mode-hook
          #'(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix ">") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))
