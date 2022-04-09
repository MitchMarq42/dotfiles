;; Mitch's...
;;  _         _  _            _
;; (_) _ __  (_)| |_     ___ | |
;; | || '_ \ | || __|   / _ \| |
;; | || | | || || |_  _|  __/| |
;; |_||_| |_||_| \__|(_)\___||_|
;;
;; (above text graphic generated with command `figlet -k "init.el"')

;; (server-mode) ; breaks things

;; Load the files that I put my settings in...
(setq mitch-directory
      (directory-file-name
       (concat user-emacs-directory
	       (convert-standard-filename "lisp/"))))
(setq load-path
      (cons mitch-directory load-path))
(require 'mitch-defuns)
(require 'webkit)
(require 'man-plus)
;; (require 'ansi-term-plus)

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
(defvar backup-directory
  (expand-file-name "emacs-backups" (getenv "XDG_CACHE_HOME")))
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))
(setq backup-directory-alist `(("." . ,backup-directory)))

;; auto-save-mode doesn't create the path automatically!
(defvar auto-save-directory
  (expand-file-name "tmp/auto-saves/" user-emacs-directory))
(make-directory auto-save-directory t)
(setq auto-save-list-file-prefix
      (expand-file-name "sessions/" auto-save-directory)
      auto-save-file-name-transforms
      `((".*" ,auto-save-directory t)))
(setq create-lockfiles nil)

;; straight.el minified bootstrap
;; (the better package manager?) (split lines if you want) (or not)
(defvar bootstrap-version) (let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)) (bootstrap-version 5)) (unless (file-exists-p bootstrap-file) (with-current-buffer (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" 'silent 'inhibit-cookies) (goto-char (point-max)) (eval-print-last-sexp))) (load bootstrap-file nil 'nomessage)) (straight-use-package 'use-package) (setq straight-use-package-by-default t)

(require 'mitch-packages)

;; Absolute line numbers. Relative ones are an annoyance to set up, sadly.
(global-display-line-numbers-mode)

;; scroll step stuff
(setq scroll-margin 2
      scroll-conservatively 100
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

;; run launcher exists. Copy it from
;; https://www.reddit.com/r/unixporn/comments/s7p7pr/so_which_run_launcher_do_you_use_rofi_or_dmenu/
;; I don't have it here because I don't use it right now.


;; UTF-8 supremacy (Snippet from https://www.masteringemacs.org/article/working-coding-systems-unicode-emacs)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Toggle Japanese with `qq'
;; Sample text: 真外記 の 巨人
;; (shingeki no kyojin (attack on titan))
(setq default-input-method 'japanese)
(toggle-input-method)

;; Visualize whitespace. In a very chill and invisible way.
(global-whitespace-mode t)
(setq whitespace-style
      (quote (face tabs tab-mark spaces space-mark newline newline-mark)))
(setq whitespace-display-mappings
      '((space-mark 32 [95])
	(newline-mark 10 [36 10])
	(tab-mark 9 [8614 9])))
