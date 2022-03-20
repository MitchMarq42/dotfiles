;; This is a comment. It's kind of pointless, but
;; it's here. You can delete it if you want.
(server-start)

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
;; minibuffer frame basically (disabled because gnome borders are ugly)
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

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; straight.el minified bootstrap
;; (the better package manager?) (split lines if you want) (or not)
(defvar bootstrap-version) (let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)) (bootstrap-version 5)) (unless (file-exists-p bootstrap-file) (with-current-buffer (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" 'silent 'inhibit-cookies) (goto-char (point-max)) (eval-print-last-sexp))) (load bootstrap-file nil 'nomessage)) (straight-use-package 'use-package) (setq straight-use-package-by-default t)

(require 'mitch-packages)

;; Relative numbers
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

;; Fix ansi-term not closing when it closes (broken?)
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
	ad-do-it
	(kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)
;; Ansi-term always use zsh?
(defvar my-term-shell "/bin/zsh")
(defadvice ansi-term (before force-zsh)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
;; ansi-term utf-8 everything better
(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(add-hook 'term-exec-hook 'my-term-use-utf8)
(defun my-term-setup ()
  "custom function of things to run when launching
a new terminal."
  (display-line-numbers-mode -1))
;; Term cleanup things
(add-hook 'term-mode-hook 'my-term-setup)
(setq evil-collection-term-sync-state-and-mode-p nil)

;; (use-package oneonone :straight t)

;; (use-package origami :straight t)


(require 'webkit)
(require 'man-plus)
