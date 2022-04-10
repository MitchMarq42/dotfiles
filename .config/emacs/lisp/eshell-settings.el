;; Eshell settings. settings for eshell.

;; test: (setq file "webkit.el")

(defun eshell/emacs (&optional file)
  "When your shell is emacs,
your emacs is but an oyster..."
      (counsel-find-file file)
  )

(provide 'eshell-settings)
