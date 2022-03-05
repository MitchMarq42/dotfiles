;; This is a comment. It's kind of pointless, but
;; it's here. You can delete it if you want.

;; Load the files that I put my settings in...
(setq mitch-directory
      (directory-file-name
       (concat user-emacs-directory
	       (convert-standard-filename "lisp/"))))
(setq load-path
      (cons
       mitch-directory load-path))
(require 'mitch-defuns)

(if (display-graphic-p) (mitch/graphical-setup))

;; minify yes/no prompts
(defalias 'yes-or-no-p 'y-or-n-p)
;; ;; minibuffer frame basically (disabled because gnome borders are ugly)
;; (setq initial-frame-alist (append '((minibuffer . nil)) initial-frame-alist))
;; (setq default-frame-alist (append '((minibuffer . nil)) default-frame-alist))
;; (setq minibuffer-auto-raise t)
;; (setq minibuffer-exit-hook '(lambda () (lower-frame)))

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

;; diminish
(use-package diminish :straight t)
(use-package eldoc :straight t
  :diminish)

;; load evil
(use-package evil
  :straight t :diminish
  :init
  (mitch/evil-init)
  :config
  (mitch/evil-config))
(use-package evil-collection
  :straight t
  :diminish 'evil-collection-unimpaired-mode
  :after evil
  :config (evil-collection-init))
(use-package evil-commentary
  :straight t
  :diminish 'evil-commentary-mode
  :config (evil-commentary-mode)
  :after evil)
(use-package evil-surround
  :straight t
  :diminish 'global-evil-surround-mode
  :after evil
  :config
  (global-evil-surround-mode 1))
(use-package undo-fu
  :diminish
  :straight t)
(use-package evil-terminal-cursor-changer
  :straight t
  :diminish
  :if (not (display-graphic-p))
  :config
  (evil-terminal-cursor-changer-activate)
  (xterm-mouse-mode))

;; Completion framework...
(use-package ivy
  :straight t
  :diminish
  :defer 0.5
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :init (ivy-mode 1))
(use-package counsel
  :straight t
  :diminish
  :after ivy)

;; Relative numbers
;; (use-package linum-relative
;;   :straight t :diminish :defer 0.1
;;   :config
;;   (mitch/linum-relative-config)
;;   :hook (prog-mode . linum-relative-mode))
(setq display-line-numbers-type 'relative
      display-line-numbers-width-start 1)
(global-display-line-numbers-mode)

;; Better modeline?
(use-package all-the-icons :straight t :if (display-graphic-p))
;; (use-package doom-modeline :straight t :init (doom-modeline-mode 1))
(use-package powerline :straight t
  :init (setq powerline-default-separator 'slant))
(use-package airline-themes :straight t
  :init (setq airline-cursor-colors nil)
  :config (load-theme 'airline-ravenpower t))

;; Custom Theme.
;; Not to be confused with a color theme, or a color scheme, or a custom scheme.
(use-package autothemer :straight t)
(load-theme 'mitch t)

;; scroll step stuff
(setq scroll-margin 2
      scroll-conservatively 100
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

(use-package yascroll
  :straight t
  :diminish
  :config (setq yascroll:delay-to-hide nil)
  (global-yascroll-bar-mode 1))

;; parentheses settingses
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)
(electric-pair-mode 1)

;; Org mode and messy things
(use-package org
  :straight t
  :mode (("\\.org$" . org-mode))
  :config
  (org-indent-mode)
  (setq org-ellipsis " ▾")
  :hook (org-mode . variable-pitch-mode))

;; cheaty key popups
(use-package which-key
  :straight t
  :diminish
  :init (which-key-mode t))

;; parentheses are boring
(use-package rainbow-delimiters
  :straight t
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

;; magit, the wonderful overrated git interface
(use-package magit
  :straight t
  :config
  (setq magit-repository-directories (expand-file-name ".local/git/dotfiles" abbreviated-home-dir)))

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
