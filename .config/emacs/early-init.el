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
;; hide gui scrollbars and menubar etc
(scroll-bar-mode -1)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; Don't pop up error window on native-comp emacs
(setq native-comp-async-report-warnings-errors 'silent)
