;; This is a comment. It's kind of pointless, but
;; it's here. You can delete it if you want.

;; remove auto-generated bits
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; line wrap
(global-visual-line-mode t)

;; straight.el minified bootstrap
;; (the better package manager?) (split lines if you want)
(defvar bootstrap-version) (let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)) (bootstrap-version 5)) (unless (file-exists-p bootstrap-file) (with-current-buffer (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" 'silent 'inhibit-cookies) (goto-char (point-max)) (eval-print-last-sexp))) (load bootstrap-file nil 'nomessage)) (straight-use-package 'use-package) (setq straight-use-package-by-default t)

;; load evil
(use-package evil
  :straight t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode t)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))
(use-package evil-collection
  :straight t
  :after evil
  :config (evil-collection-init))
(use-package evil-commentary
  :straight t
  :config
  (evil-commentary-mode)
  :after evil)
(use-package undo-fu
  :straight t)

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
  :init
  (ivy-mode 1))

;; Custom Theme.
;; Not to be confused with a color theme, or a color scheme, or a custom scheme.
(use-package autothemer
  :straight t)
(load-theme 'mitch t)

;; Relative numbers
(use-package linum-relative
  :straight t
  :defer 0.1
  :config
  (setq linum-relative-backend 'display-line-numbers-mode)
  ;; (setq linum-relative-backend 'linum-mode)
  (setq linum-relative-current-symbol "%3s ")
  (linum-relative-global-mode t)
  )

;; Better modeline?
(use-package doom-modeline
  :straight t
  :init
  (doom-modeline-mode 1))

;; scroll step stuff
(setq scroll-margin 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

;; parentheses settingses
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)

;; Org mode and messy things
(use-package org
  :straight t
  :mode (("\\.org$" . org-mode))
  :config
  (org-indent-mode)
  (variable-pitch-mode 1)
  ;; (visual-line-mode 1)
  (setq org-ellipsis " ▾"))
(use-package writeroom-mode
  :straight t
  :after org
  :hook (org-mode . writeroom-mode)
  )
(use-package evil-terminal-cursor-changer
  :straight t
  :if (null (display-graphic-p))
  :config
  (evil-terminal-cursor-changer-activate)
  )

