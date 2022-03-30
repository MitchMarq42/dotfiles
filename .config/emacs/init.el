;; This is a comment. It's kind of pointless, but
;; it's here. You can delete it if you want.
(server-mode)

;; Load the files that I put my settings in...
(setq mitch-directory
      (directory-file-name
       (concat user-emacs-directory
	       (convert-standard-filename "lisp/"))))
(setq load-path
      (cons mitch-directory load-path))
(require 'mitch-defuns)

;; minify yes/no prompts
(defalias 'yes-or-no-p 'y-or-n-p)
;; ;; minibuffer frame basically (disabled because gnome borders are ugly)
;; (setq initial-frame-alist (append '((minibuffer . nil)) initial-frame-alist))
;; (setq default-frame-alist (append '((minibuffer . nil)) default-frame-alist))
;; (setq minibuffer-auto-raise t)
;; (setq minibuffer-exit-hook '(lambda () (lower-frame)))
;; (setq minibuffer-frame-alist '((width . 80) (height . 10)))
;; do the things
(setq server-after-make-frame-hook 'mitch/graphical-setup)
(if (display-graphic-p) (mitch/graphical-setup))

;; remove auto-generated bits
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (not (file-exists-p custom-file))
    (make-empty-file custom-file t))
(load custom-file)

;; Control backups/swapfiles
(defvar backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))
(setq backup-directory-alist `(("." . ,backup-directory)))

;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))
(setq create-lockfiles nil)

;; straight.el minified bootstrap
;; (the better package manager?) (split lines if you want) (or not)
(defvar bootstrap-version) (let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)) (bootstrap-version 5)) (unless (file-exists-p bootstrap-file) (with-current-buffer (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" 'silent 'inhibit-cookies) (goto-char (point-max)) (eval-print-last-sexp))) (load bootstrap-file nil 'nomessage)) (straight-use-package 'use-package) (setq straight-use-package-by-default t)

(require 'mitch-packages)

;; Relative numbers. Not perfect but they mostly work. Anything else is ridiculously complex and broken.
(setq display-line-numbers-type 'relative
      display-line-numbers-width-start 1)
(global-display-line-numbers-mode)

;; scroll step stuff
(setq scroll-margin 2
      scroll-conservatively 100
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

;; run launcher exists. Copy it from
;; https://www.reddit.com/r/unixporn/comments/s7p7pr/so_which_run_launcher_do_you_use_rofi_or_dmenu/
;; I don't have it here because I don't use it right now.

;; Make evil-join combine lines. Taken from
;; https://github.com/hlissner/doom-emacs/commit/40cf6139ed53b635fec37ce623c4b1093c78a11e
;; ;;;###autoload (autoload '+evil-join-a "editor/evil/autoload/advice" nil nil)
(evil-define-operator +evil-join-a (beg end)
  "Join the selected lines.
This advice improves on `evil-join' by removing comment delimiters when joining
commented lines, by using `fill-region-as-paragraph'.
From https://github.com/emacs-evil/evil/issues/606"
  :motion evil-line
  (let* ((count (count-lines beg end))
	 (count (if (> count 1) (1- count) count))
	 (fixup-mark (make-marker)))
    (dotimes (var count)
      (if (and (bolp) (eolp))
	  (join-line 1)
	(let* ((end (line-beginning-position 3))
	       (fill-column (1+ (- end beg))))
	  (set-marker fixup-mark (line-end-position))
	  (fill-region-as-paragraph beg end nil t)
	  (goto-char fixup-mark)
	  (fixup-whitespace))))
    (set-marker fixup-mark nil)))
(advice-add #'evil-join :override #'+evil-join-a)

;; (use-package oneonone :straight t)

;; (use-package origami :straight t)

(require 'webkit)
(require 'man-plus)
(require 'ansi-term-plus)
