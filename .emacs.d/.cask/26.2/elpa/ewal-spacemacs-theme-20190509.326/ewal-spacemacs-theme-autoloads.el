;;; ewal-spacemacs-theme-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "ewal-spacemacs" "ewal-spacemacs.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from ewal-spacemacs.el

(autoload 'ewal-spacemacs-get-colors "ewal-spacemacs" "\
Get `spacemacs-theme' colors.
For usage see: <https://github.com/nashamri/spacemacs-theme>. If
APPLY is t, set relevant environment variable for the user.
Reload `ewal' environment variables before returning colors even
if they have already been computed if FORCE-RELOAD is t. TTY
defaults to return value of `ewal--use-tty-colors-p'. if TTY is
t, use TTY colors.

\(fn &key APPLY FORCE-RELOAD BORDERS HIGH-CONTRAST)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ewal-spacemacs" '("ewal-spacemacs-")))

;;;***

;;;### (autoloads nil nil ("ewal-spacemacs-classic-high-contrast-theme.el"
;;;;;;  "ewal-spacemacs-classic-theme.el" "ewal-spacemacs-modern-high-contrast-theme.el"
;;;;;;  "ewal-spacemacs-modern-theme.el" "ewal-spacemacs-theme-pkg.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ewal-spacemacs-theme-autoloads.el ends here
