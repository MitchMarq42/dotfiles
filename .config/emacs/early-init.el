;; Tell the emacs startup time instead of the banal
;; "For information about GNU Emacs and the GNU system, type C-h C-a."
(defun display-startup-echo-area-message ()
  (message (emacs-init-time)))

;; Crash the computer by overloading memory
(setq gc-cons-threshold most-positive-fixnum)

;; Disable package.el so we can use straight
(setq package-enable-at-startup nil)

;; Hide default dashboard
(setq inhibit-startup-messages t)
(setq inhibit-startup-screen t)
;; diable stupid file open box thingy
(setq use-file-dialog nil)
(setq use-dialog-box nil)

;; Don't pop up error window on native-comp emacs
(setq native-comp-async-report-warnings-errors 'silent)

