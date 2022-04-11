;; Eshell settings. settings for eshell.

(defun eshell/emacs (&optional file)
  "When your shell is emacs,
your emacs is but an oyster..."
      (counsel-find-file file))
(defun eshell/clear ()
  "Clear the scrollback buffer, like `clear' in
a real shell"
  (eshell/clear-scrollback))


(provide 'eshell-settings)
