
((digest . "463eeabe7fde5d56c6fd271b0a4c92f4") (undo-list nil ("
" . 29677) ((marker . 29678) . -1) ((marker . 29776) . -1) ((marker . 29776) . -1) ((marker) . -1) nil (29595 . 29677) nil (29592 . 29595) nil (29591 . 29593) nil (29584 . 29591) nil ("習" . -29584) ((marker . 29677) . -1) ("慣" . -29585) ((marker . 29677) . -1) 29586 nil (29584 . 29586) nil (29581 . 29584) nil (29580 . 29582) nil (29675 . 29678) nil (29634 . 29675) nil (29631 . 29634) nil (29630 . 29631) nil (29595 . 29630) nil (29592 . 29595) nil (29591 . 29592) nil (29581 . 29591) nil (29579 . 29581) nil (29527 . 29579) nil (29524 . 29527) nil (29523 . 29524) nil (29467 . 29523) nil (29464 . 29467) nil (29463 . 29464) nil (29408 . 29463) nil (29405 . 29408) nil (29405 . 29406) nil (29404 . 29405) nil (29361 . 29364) nil (29361 . 29401) nil ("(require 'multiple-cursors)
(require 'smartrep)

(declare-function smartrep-define-key \"smartrep\")

(global-set-key (kbd \"C-M-c\") 'mc/edit-lines)
(global-set-key (kbd \"C-M-r\") 'mc/mark-all-in-region)

(global-unset-key \"\\C-t\")

(smartrep-define-key global-map \"C-m\"
  '((\"C-m\"      . 'mc/mark-next-like-this)
    (\"n\"        . 'mc/mark-next-like-this)
    (\"p\"        . 'mc/mark-previous-like-this)
    (\"m\"        . 'mc/mark-more-like-this-extended)
    (\"u\"        . 'mc/unmark-next-like-this)
    (\"U\"        . 'mc/unmark-previous-like-this)
    (\"s\"        . 'mc/skip-to-next-like-this)
    (\"S\"        . 'mc/skip-to-previous-like-this)
    (\"*\"        . 'mc/mark-all-like-this)
    (\"d\"        . 'mc/mark-all-like-this-dwim)
    (\"i\"        . 'mc/insert-numbers)
    (\"o\"        . 'mc/sort-regions)
    (\"O\"        . 'mc/reverse-regions)))




" . 29361) ((marker . 29592) . -849) ((marker . 29678) . -849) ((marker . 29361) . -848) ((marker . 28905) . -28) ((marker . 29677) . -849) ((marker) . -849) ((marker . 29596) . -1) 30210 nil (29624 . 29625) nil ("t" . -29624) ((marker . 29677) . -1) 29625 nil (29635 . 29636) nil ("t" . -29635) ((marker . 29677) . -1) 29636 nil (30209 . 30210) nil (30205 . 30208) nil (29361 . 30205) nil (29360 . 29361) nil (29355 . 29360) nil ("o" . -29355) ((marker . 29677) . -1) ("r" . -29356) ((marker . 29677) . -1) 29357 nil (29342 . 29357) (t 22751 34145 0 0) nil undo-tree-canary))
