(defun display-startup-echo-area-message ()
  "A re-definition of the function.
Tell the emacs startup time instead of the banal
\"For information about GNU Emacs and the GNU system, type C-h C-a.\""
  (message (emacs-init-time)))

;; Crash the computer by overloading memory
;; (setq gc-cons-threshold most-positive-fixnum)

;; Disable package.el so we can use straight
(setq package-enable-at-startup nil)

;; Hide default dashboard
(setq inhibit-startup-messages t)
(setq inhibit-startup-screen t)

;; Don't pop up error window on native-comp emacs
(setq native-comp-async-report-warnings-errors 'silent)

;; Run stuff after opening a new frame
;(setq server-after-make-frame-hook (mitch/graphical-setup))
;(setq before-make-frame-hook (mitch/graphical-setup))
