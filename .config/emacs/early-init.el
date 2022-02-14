;; Tell the emacs startup time instead of the banal
;; "For information about GNU Emacs and the GNU system, type C-h C-a."
(defun display-startup-echo-area-message ()
  (message (emacs-init-time)))

(setq gc-cons-threshold most-positive-fixnum)
(setq inhibit-startup-messages t)
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(setq package-enable-at-startup nil)
(tool-bar-mode 0)
(menu-bar-mode 0)

(setq frame-title-format
      '("" invocation-name ": "(:eval (if (buffer-file-name)
					  (abbreviate-file-name (buffer-file-name))
					"%b"))))

(defun eshell/exit ()
  "Redefined by mitch. Same-ish behavior as Evil's ZZ."
  (save-buffers-kill-emacs))
(setq initial-major-mode 'eshell)
(setq-default scroll-up-aggressively 0.01
	      scroll-down-aggressively 0.01)
