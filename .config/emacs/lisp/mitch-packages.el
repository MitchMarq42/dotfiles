;; use-package statements...

;; diminish
(use-package diminish :straight t)
(use-package eldoc
  :defer 1
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
	
(if (< (string-to-number emacs-version) 29)
    (use-package undo-fu
      :diminish
      :straight t))
(use-package evil-terminal-cursor-changer
  :straight t
  :after evil
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
  :config (setq ivy-initial-inputs-alist nil)
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

;; Better modeline?
(use-package all-the-icons :straight t
  :defer 10
  :if (display-graphic-p))
(use-package powerline :straight t
  :init (setq powerline-default-separator 'slant))
(use-package airline-themes :straight t
  :init (setq airline-cursor-colors nil)
  :after powerline
  :config (load-theme 'airline-ravenpower t))

;; Custom Theme.
;; Not to be confused with a color theme, or a color scheme, or a custom scheme.
(use-package autothemer :straight t)
(load-theme 'mitch t)

(use-package yascroll
  :straight t
  :diminish
  :defer 1
  :if (display-graphic-p)
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
  (setq org-startup-indented t)
  (add-hook 'org-mode-hook
	    (lambda ()
	      (add-hook 'after-save-hook #'org-babel-tangle)))
  :hook (org-mode . variable-pitch-mode))
(use-package org-appear
  :straight t
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t))

;; cheaty key popups
(use-package which-key
  :straight t
  :diminish
  :defer 5
  :init (which-key-mode t))

;; parentheses are boring
(use-package rainbow-delimiters
  :straight t
  :diminish
  :defer 1
  :hook (prog-mode . rainbow-delimiters-mode))

;; Hex colors
(use-package rainbow-mode
  :straight t
  :diminish
  :defer 10
  :hook (prog-mode . rainbow-mode))

;; Nobody loves a good language
(use-package powershell :straight t)

;; Better help-pages. Genuinely pretty great.
(use-package helpful :straight t)

;; Keybinding manager
(use-package general :straight t
  :config
  (mitch/general-config))

;; Better lisp highlighting?
(use-package highlight-defined :straight t
  :config
  (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode))

;; Shell linting?
(use-package flycheck :straight t
  :defer 5
  :config
  (add-hook 'sh-mode-hook 'flycheck-mode))

;; Emacs startup profiling
(use-package esup :straight t)

;; Blingy file tree view
(use-package treemacs
  :straight t
  :defer 1
  :config
  (treemacs-project-follow-mode)
  (treemacs-git-mode 'simple)
  (add-hook
   'treemacs-mode-hook
   #'(lambda () (display-line-numbers-mode -1))))
(use-package treemacs-evil
  :straight t
  :after treemacs)
(use-package treemacs-all-the-icons
  :straight t
  :after treemacs)

;; Blingy laggy minimap on the right
(use-package minimap
  :straight t
  :init
  (setq minimap-window-location 'right
	minimap-update-delay 0))

(provide 'mitch-packages)
