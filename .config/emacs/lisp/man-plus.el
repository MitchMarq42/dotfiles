;; man-plus.el
;; Loosely based on neovim's `man.vim' functionality.
;;
;; Feature goals:
;; - MANWIDTH based on size of new window
;; - Lots of different colors for headings, options,
;;   sh snippets, etc

(setq man-plus-highlights
      '(
	("^[A-Z]\([1-9]\)\s*.*$" . 'transient-heading)
	("^[a-z]\([1-9]\)\s*.*$" . 'transient-heading)
	("^\s*[A-Z]*$" . 'font-lock-keyword-face)
	(".*\([1-9]\)" . 'font-lock-string-face)
	("^\s*-[a-z]*" . 'font-lock-string-face)
	)
      )

(defun man-plus-setall ()
  "Do all of the things that Man wants. To be
run as `Man-mode-hook'."
  (setq font-lock-defaults '(man-plus-highlights)))

(setq Man-mode-hook
      'man-plus-setall)

(provide 'man-plus)
