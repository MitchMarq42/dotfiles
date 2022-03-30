;; use-package statements...

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
  :after ivy
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  :init (counsel-mode t)
  )
(use-package swiper
  :straight t
  :diminish
  :after counsel
  )

;; Better modeline?
(use-package all-the-icons :straight t :if (display-graphic-p))
(use-package powerline :straight t
  :init (setq powerline-default-separator 'slant))
(use-package airline-themes :straight t
  :init (setq airline-cursor-colors nil)
  :config (load-theme 'airline-ravenpower t))

;; Custom Theme.
;; Not to be confused with a color theme, or a color scheme, or a custom scheme.
(use-package autothemer :straight t)
(load-theme 'mitch t)

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
  (setq magit-repository-directories
	(expand-file-name ".local/git/dotfiles" abbreviated-home-dir)))

;; Hex colors
(use-package rainbow-mode
  :straight t
  :diminish
  :hook (prog-mode . rainbow-mode))

;; stupid broken lisp thingy
(use-package slime :straight t
  :config
  (setq inferior-lisp-program "sbcl"))

;; Nobody loves a good language
(use-package powershell :straight t)

;; Better help-pages. Great.
(use-package helpful :straight t)

;; Edit in the browser? broken
(use-package atomic-chrome :straight t)

;; Keybinding manager
(use-package general :straight t
  :config
  (mitch/general-config))

(provide 'mitch-packages)
