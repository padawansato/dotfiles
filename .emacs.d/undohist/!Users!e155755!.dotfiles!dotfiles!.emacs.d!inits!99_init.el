
((digest . "4f1abfe4b31fae86d1fe107d29c672cc") (undo-list nil (";;latex
(require 'tex)
(TeX-global-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
" . -36500) ((marker . 36500) . -357) ((marker . 36726) . -357) ((marker . 36726) . -357) ((marker . 36760) . -335) ((marker . 36760) . -335) ((marker . 36789) . -302) ((marker . 36789) . -302) ((marker . 36790) . -258) ((marker . 36790) . -258) ((marker . 36843) . -213) ((marker . 36843) . -213) ((marker . 36870) . -170) ((marker . 36870) . -170) ((marker . 36897) . -124) ((marker . 36897) . -124) ((marker . 36927) . -94) ((marker . 36927) . -94) ((marker . 36928) . -70) ((marker . 36928) . -70) ((marker . 36945) . -47) ((marker . 36945) . -47) ((marker . 37006) . -23) ((marker . 37006) . -23) ((marker . 37040) . -8) ((marker . 37040) . -8) ((marker . 36500) . -198) ((marker . 36500) . -170) ((marker . 36500) . -201) ((marker) . -357) ((marker) . -1) 36857 (t 23834 2729 868010 259000) nil (43293 . 43294) 42788 nil (nil rear-nonsticky nil 43292 . 43293) (nil fontified nil 42788 . 43293) (42788 . 43293) nil (42787 . 42788) nil (42781 . 42787) nil ("y" . -42781) ((marker) . -1) 42782 nil (42779 . 42782) nil (";; yatex
;; https://qiita.com/Maizu/items/7d8f420817dfeccf4477
(require 'yatex)                ;; パッケージ読み込み
(add-to-list 'auto-mode-alist '(\"\\\\.tex\\\\'\" . yatex)) ;;auto-mode-alistへの追加
(setq tex-command \"latex\")       ;; 自分の環境に合わせて\"\"内を変えてください
(setq bibtex-command \"pbibtex\")    ;; 自分の環境に合わせて\"\"内を変えてください
;;reftex-mode
(add-hook 'yatex-mode-hook
          #'(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix \">\") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix \"<\") 'YaTeX-uncomment-region)))
" . -42779) ((marker) . -614) ((marker) . -302) ((marker) . -343) ((marker) . -343) ((marker) . -366) ((marker) . -366) ((marker) . -396) ((marker) . -396) ((marker) . -438) ((marker) . -438) ((marker) . -503) ((marker) . -503) ((marker) . -545) ((marker) . -545) ((marker) . -8) ((marker) . -302) ((marker) . -302) ((marker) . -316) ((marker) . -316) ((marker) . -614) ((marker) . -1) 43393 (t 23833 63450 8064 324000) nil (nil rear-nonsticky nil 42840 . 42841) (nil fontified nil 42791 . 42841) (42791 . 42841) nil (";;; yatex
(require 'yatex)                ;; パッケージ読み込み
(add-to-list 'auto-mode-alist '(\"\\\\.tex\\\\'\" . yatex)) ;;auto-mode-alistへの追加
(setq tex-command \"platex\")       ;; 自分の環境に合わせて\"\"内を変えてください
(setq bibtex-command \"pbibtex\")    ;; 自分の環境に合わせて\"\"内を変えてください
;;reftex-mode
(add-hook 'yatex-mode-hook
          #'(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix \">\") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix \"<\") 'YaTeX-uncomment-region)))
" . 42791) ((marker) . -10) ((marker) . -10) ((marker) . -55) ((marker) . -55) ((marker) . -131) ((marker) . -131) ((marker) . -190) ((marker) . -190) ((marker) . -250) ((marker) . -250) ((marker) . -264) ((marker) . -264) ((marker) . -291) ((marker) . -291) ((marker) . -314) ((marker) . -314) ((marker) . -344) ((marker) . -344) ((marker) . -386) ((marker) . -386) ((marker) . -562) ((marker) . -451) ((marker) . -451) ((marker) . -493) ((marker) . -493) ((marker) . -562) ((marker) . -562) ((marker) . -1) ((marker) . -1) ((marker) . -562) 43353 nil (nil rear-nonsticky nil 43352 . 43353) (nil fontified nil 42791 . 43353) (42791 . 43353) nil undo-tree-canary))
