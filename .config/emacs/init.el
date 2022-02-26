;; This is a comment. It's kind of pointless, but
;; it's here. You can delete it if you want.

;; hide gui scrollbars and menubar etc (needs a hook)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-fringe-mode 8)

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
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))

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
  :straight t
  :diminish
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-fu)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-mode t)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-global-set-key 'normal (kbd "<escape>") 'evil-beginning-of-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (global-visual-line-mode t)
  (diminish 'visual-line-mode))
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
  (evil-terminal-cursor-changer-activate))

;; Completion framework...
(use-package ivy
  :straight t
  :defer 0.5
  :diminish
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
;; (setq display-line-numbers 'relative)
(use-package linum-relative
  :straight t
  :diminish
  :defer 0.1
  :config
  ;; (setq linum-relative-backend 'display-line-numbers-mode)
  (setq linum-relative-backend 'linum-mode)
  (setq linum-relative-current-symbol "")
  (linum-relative-global-mode t)
  :hook (prog-mode . linum-relative-mode))
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		treemacs-mode-hook
		eshell-mode-hook
		counsel-mode-hook
		ivy-mode-hook
		help-mode-hook))
  (add-hook mode (lambda ()
	      (linum-relative-mode -1))))

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

;; run launcher exists. Copy it from
;; https://www.reddit.com/r/unixporn/comments/s7p7pr/so_which_run_launcher_do_you_use_rofi_or_dmenu/
;; I don't have it here because I don't use it right now.
