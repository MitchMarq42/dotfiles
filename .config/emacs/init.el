;;; init.el --- basic initial declarations
;;; Commentary:
;;  _         _  _            _
;; (_) _ __  (_)| |_     ___ | |
;; | || '_ \ | || __|   / _ \| |
;; | || | | || || |_  _|  __/| |
;; |_||_| |_||_| \__|(_)\___||_|
;;
;; '((above text graphic generated with command `figlet -k "init.el"'))

;;; Code:
;; Speed up loading/finding files
(let
    ((file-name-handler-alist nil))

  ;; Load the files that I put my settings in...
  (defvar mitch-directory
	(directory-file-name
	 (concat user-emacs-directory
		 (convert-standard-filename "lisp/"))))
  (setq load-path
	(cons mitch-directory load-path))
  (setq custom-theme-directory mitch-directory)
  (require 'mitch-defuns)
  (require 'webkit)
  (require 'man-plus)
  ;; (require 'ansi-term-plus)

  ;; minify yes/no prompts
  (if (>= (string-to-number emacs-version) 28)
      (defvar use-short-answers t)
    (defalias 'yes-or-no-p 'y-or-n-p))

  ;; do the things
  (add-hook 'server-after-make-frame-hook #'mitch/graphical-setup)
  (if (display-graphic-p) (mitch/graphical-setup))

  ;; Control backups/swapfiles
  (defvar backup-directory
    (expand-file-name "emacs-backups"
		      (or (getenv "XDG_CACHE_HOME")
			  (expand-file-name
			    ".cache" "~"))))
  (if (not (file-exists-p backup-directory))
      (make-directory backup-directory t))
  (setq backup-directory-alist `(("." . ,backup-directory)))

  ;; auto-save-mode doesn't create the path automatically!
  (defvar auto-save-directory
    (expand-file-name "tmp/auto-saves/" backup-directory))
  (make-directory auto-save-directory t)
  (setq auto-save-list-file-prefix
	(expand-file-name "sessions/" auto-save-directory)
	auto-save-file-name-transforms
	`((".*" ,auto-save-directory t)))
  (setq create-lockfiles nil)

  ;; remove auto-generated bits
  (setq custom-file (expand-file-name "custom.el" backup-directory))
  (if (not (file-exists-p custom-file))
      (make-empty-file custom-file t))
  (load custom-file)

  ;; straight.el: the better package manager?
  ;; minified bootstrap (split lines if you want) (or not)
  (defvar bootstrap-version) (let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)) (bootstrap-version 5)) (unless (file-exists-p bootstrap-file) (with-current-buffer (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" 'silent 'inhibit-cookies) (goto-char (point-max)) (eval-print-last-sexp))) (load bootstrap-file nil 'nomessage)) (straight-use-package 'use-package) (setq straight-use-package-by-default t)

  (require 'mitch-packages)

  ;; Absolute line numbers. Relative ones are an annoyance to set up, sadly.
  (global-display-line-numbers-mode)
  (defvar display-line-numbers-width-start t)

  ;; scroll step stuff
  (setq scroll-margin 2
	scroll-conservatively 100
	scroll-up-aggressively 0.01
	scroll-down-aggressively 0.01)

  ;; run launcher exists. Copy it from
  ;; https://www.reddit.com/r/unixporn/comments/s7p7pr/so_which_run_launcher_do_you_use_rofi_or_dmenu/
  ;; I don't have it here because I don't use it right now.

  ;; UTF-8 supremacy (Snippet from https://github.com/doomemacs/doomemacs/blob/master/early-init.el)
  (set-language-environment "UTF-8")
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

  ;; Toggle Japanese with `qq'
  ;; Sample text: 進撃 の 巨人
  ;; (shingeki no kyojin (attack on titan))
  ;; (setq default-input-method 'japanese)
  ;; (setq-default current-input-method 'japanese-ascii)
  ;; DISABLED because something broke and I didn't bother figuring out what...

  ;; barf out emacs errors as they are encountered
  (setq debug-on-error t)

  ;; Visualize whitespace. In a very chill and invisible way.
  (global-whitespace-mode t)
  (setq-default whitespace-style '(face lines-tail))
  (setq-default whitespace-line-column 80)

  ;; clean up modeline things
  (diminish 'lisp-interaction-mode)
  (diminish 'global-whitespace-mode)

  ;; Speed up scrolling down (why is this even a thing?)
  (setq auto-window-vscroll nil)

  ;; save place in all files
  (save-place-mode t)
  (defvar save-place-file
	(expand-file-name "file-position-save" backup-directory))

  ;; load eshell stuff when we start eshell
  (add-hook 'eshell-mode-hook #'(lambda () (require 'eshell-settings)))
  )

;;; init.el ends here
