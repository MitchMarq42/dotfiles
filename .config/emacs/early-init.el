;;; Early-init --- do all these things early in the init process

;;; Commentary:
;; do the first initial beginning things

;;; Code:

(defun display-startup-echo-area-message ()
  "A re-definition of the function.
Tell the Emacs startup time and number of garbage-collections
instead of the banal
\"For information about GNU Emacs and the GNU system, type \\[about-emacs].\""
  (message
   (concat (emacs-init-time) ", gc ran " (number-to-string gcs-done) " times"
    )))

(setq initial-scratch-message (purecopy "\
;; Write some lisp in this buffer and it can be executed,either with
;; \\[eval-last-sexp] locally or \\[eval-buffer] globally.

"))

;; Crash the computer by overloading memory
(setq gc-cons-threshold (* 17 gc-cons-threshold))

;; Disable package.el so we can use straight
(setq package-enable-at-startup nil)

;; Hide default dashboard
(defvar inhibit-startup-messages t)
(setq inhibit-startup-screen t)

;; Don't pop up error window on native-comp emacs
(defvar native-comp-async-report-warnings-errors 'silent)

;; Run stuff after opening a new frame
;(setq server-after-make-frame-hook (mitch/graphical-setup))
;(setq before-make-frame-hook (mitch/graphical-setup))

;;; early-init.el ends here
