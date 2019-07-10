
((digest . "3e6cda626f3dc386734cc10b7dc3fb77") (undo-list nil (nil rear-nonsticky nil 46146 . 46147) (nil fontified nil 46059 . 46147) (46059 . 46147) nil (46057 . 46059) nil (46056 . 46057) (t 23845 41836 306365 555000) nil (46084 . 46085) nil (nil rear-nonsticky nil 46083 . 46084) (nil fontified nil 46057 . 46084) (46057 . 46084) nil (46056 . 46057) nil (46054 . 46056) ("から" . -46054) ((marker . 46147) . -2) (46054 . 46056) ("かｒ" . -46054) ((marker . 46147) . -2) (46054 . 46056) ("か" . -46054) ((marker . 46147) . -1) (46054 . 46055) ("ｋ" . -46054) ((marker . 46147) . -1) (46050 . 46055) nil (46043 . 46050) nil (46042 . 46043) nil (46040 . 46042) ("開く" . -46040) (46040 . 46042) ("ひらく" . -46040) ((marker . 46147) . -3) (46040 . 46043) ("ひらｋ" . -46040) ((marker . 46147) . -3) (46040 . 46043) ("ひら" . -46040) ((marker . 46147) . -2) (46040 . 46042) ("ひｒ" . -46040) ((marker . 46147) . -2) (46040 . 46042) ("ひ" . -46040) ((marker . 46147) . -1) (46040 . 46041) ("ｈ" . -46040) ((marker . 46147) . -1) (46039 . 46041) ("で" . -46039) ((marker . 46147) . -1) (46039 . 46040) ("ｄ" . -46039) ((marker . 46148) . -1) ((marker . 46147) . -1) (46034 . 46040) ("ウィンドウ" . -46034) ((marker . 46147) . -5) (46034 . 46039) ("うぃんどう" . -46034) ((marker . 46147) . -5) (46034 . 46039) ("うぃんど" . -46034) ((marker . 46147) . -4) (46034 . 46038) ("うぃんｄ" . -46034) ((marker . 46147) . -4) (46034 . 46038) ("うぃｎ" . -46034) ((marker . 46147) . -3) (46034 . 46037) ("うぃ" . -46034) ((marker . 46147) . -2) (46034 . 46036) ("ｗ" . -46034) (46032 . 46035) ("同じ" . -46032) ((marker . 46147) . -2) (46032 . 46034) ("おなじ" . -46032) ((marker . 46147) . -3) (46032 . 46035) ("おなｊ" . -46032) ((marker . 46147) . -3) (46032 . 46035) ("おな" . -46032) ((marker . 46147) . -2) (46032 . 46034) ("おｎ" . -46032) ((marker . 46147) . -2) (46032 . 46034) ("お" . -46032) ((marker . 46147) . -1) (46029 . 46033) nil (46028 . 46029) (t 23845 29075 566304 817000) nil (42300 . 42303) nil ("X" . -42300) ((marker . 46028) . -1) 42301 (t 23845 28191 75161 229000) nil (38203 . 38207) nil ("right" . -38203) ((marker* . 213) . -5) 38208 nil (";" . -38177) ((marker* . 213) . -1) (";" . -38178) ((marker* . 213) . -1) 38179 (t 23845 28177 988608 362000) nil (38177 . 38179) nil (nil rear-nonsticky nil 45325 . 45326) (nil fontified nil 42340 . 45326) (42340 . 45326) (t 23845 28042 391446 713000) nil (42340 . 42341) (42340 . 42341) (42340 . 42341) (42340 . 42341) nil (";; yatex
;; 拡張子が .tex なら yatex-mode に
(setq auto-mode-alist
  (cons (cons \"\\\\.tex$\" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode \"yatex\" \"Yet Another LaTeX mode\" t)

;; YaTeX が利用する内部コマンドを定義する
(setq tex-command \"platex2pdf\") ;; 自作したコマンドを
(cond
  ((eq system-type 'gnu/linux) ;; GNU/Linux なら
    (setq dvi2-command \"evince\")) ;; evince で PDF を閲覧
  ((eq system-type 'darwin) ;; Mac なら
    (setq dvi2-command \"open -a Preview\"))) ;; プレビューで
(add-hook 'yatex-mode-hook '(lambda () (setq auto-fill-function nil)))
" . 42340) ((marker . 46059) . -515) ((marker . 46148) . -9) ((marker) . -515) nil (";" . 42940) (";" . 42940) (" " . 42940) (";" . 42940) (";" . 42940) nil (" " . 42899) (";" . 42899) (";" . 42899) (t 23845 27765 438030 901000) nil (43559 . 43560) 43320 nil (nil rear-nonsticky nil 43319 . 43320) (nil fontified nil 43283 . 43320) (43283 . 43320) nil (";; " . -43379) (";; " . -43284) 43487 nil ("(setq shell-pop-shell-type '(\"eshell\" \"*eshell*\" (lambda () (eshell))))
;; (setq shell-pop-shell-type '(\"shell\" \"*shell*\" (lambda () (shell))))
" . -43284) ((marker* . 213) . -144) ((marker) . -144) 43428 nil (nil rear-nonsticky nil 43671 . 43672) (nil fontified nil 43284 . 43672) (43284 . 43672) (t 23845 27297 224015 65000) nil ("
" . 602) nil ("(init-loader-load \"~/.emacs.d/inits\")" . 602) ((marker*) . 37) ((marker) . -1) ((marker*) . 1) ((marker) . -37) nil ("
" . 602) ((marker . 602) . -1) nil ("(setq init-loader-show-log-after-init \"error-only\")" . 602) ((marker*) . 51) ((marker) . -1) ((marker*) . 1) ((marker) . -51) nil ("
" . 602) nil ("
" . 602) nil ("(require 'init-loader)" . 602) ((marker*) . 22) ((marker) . -1) ((marker*) . 1) ((marker) . -22) nil ("
" . 602) nil (";;http://kiririmode.hatenablog.jp/entry/20141228/1419762171" . 602) nil ("
" . 602) nil (";;; init-loader 設定" . 602) nil (601 . 602) nil undo-tree-canary))
