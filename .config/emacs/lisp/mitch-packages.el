;;; mitch-packages --- Declare and configure use-package statements

;;; Commentary:
;; This is a file in which I put declarations for packages and things.

;;; Code:

;; diminish
(use-package diminish)
(use-package eldoc
  :defer 1
  :diminish)

;; load evil
(use-package evil
  :diminish
  :init
  (mitch/evil-init)
  :config
  (mitch/evil-config))
(use-package evil-collection
  :diminish 'evil-collection-unimpaired-mode
  :after evil
  :config (evil-collection-init))
(use-package evil-commentary
  :diminish 'evil-commentary-mode
  :config (evil-commentary-mode)
  :after evil)
(use-package evil-surround
  :diminish 'global-evil-surround-mode
  :after evil
  :config
  (global-evil-surround-mode 1))

(if (< (string-to-number emacs-version) 29)
    (use-package undo-fu
      :diminish))
(use-package evil-terminal-cursor-changer
  :after evil
  :diminish
  :if (not (display-graphic-p))
  :config
  (evil-terminal-cursor-changer-activate)
  (xterm-mouse-mode))

;; Completion framework...
(use-package ivy
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
  :diminish
  :after ivy
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  :init (counsel-mode t))

;; Better modeline?
(use-package all-the-icons
  :defer 10
  :if (display-graphic-p))
(use-package powerline
  :init
  (setq powerline-default-separator 'slant))
(use-package airline-themes
  :init
  (setq airline-cursor-colors nil)
  :after powerline
  :config
  (load-theme 'airline-ravenpower t))

;; Custom Theme.
;; Not to be confused with a color theme, or a color scheme, or a custom scheme.
(use-package autothemer)
(load-theme 'mitch t)

(use-package yascroll
  :diminish
  :defer 1
  :if (display-graphic-p)
  :config
  (setq yascroll:delay-to-hide nil)
  (global-yascroll-bar-mode 1))

;; parentheses settingses
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)
(electric-pair-mode 1)
;; Better parentheses settingses
(use-package paredit)

;; org mode and messy things
(use-package org
  :straight (:type built-in)
  :mode (("\\.org$" . org-mode))
  :config
  (org-indent-mode)
  (setq org-ellipsis " ▾")
  (setq org-startup-indented t)
  (add-hook 'org-mode-hook
	    #'(lambda ()
		(add-hook 'after-save-hook #'org-babel-tangle)))
  (add-hook 'org-mode-hook
	    #'(lambda ()
	       (display-line-numbers-mode -1)))
  ;; :hook (org-mode . variable-pitch-mode)
  )
(use-package org-contrib
  :after org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((powershell . t)
     (shell . t)
     ))
  )
(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t))

;; cheaty key popups
(use-package which-key
  :diminish
  :defer 5
  :init (which-key-mode t))

;; parentheses are boring
(use-package rainbow-delimiters
  :diminish
  :defer 1
  :hook (prog-mode . rainbow-delimiters-mode))

;; Hex colors
(use-package rainbow-mode
  :diminish
  :defer 10
  :hook (prog-mode . rainbow-mode))

;; Nobody loves a good language
(use-package powershell)
(use-package ob-powershell
  :after org
  :config
  (setq ob-powershell-powershell-command "pwsh"))

;; or a bad language
(use-package haskell-mode
  :defer t
  :init
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  (add-hook 'haskell-mode-hook #'lsp)
  :bind (
	 :map haskell-mode-map
	 ("C-c h" . hoogle)
	 ("C-c s" . haskell-mode-stylish-buffer))
  :config (message "Loaded haskell-mode")
  (setq haskell-mode-stylish-haskell-path "brittany")
  (setq haskell-hoogle-url "https://www.stackage.org/lts/hoogle?q=%s"))

;; Better help-pages. Genuinely pretty great.
(use-package helpful)

;; Keybinding manager
(use-package general
  :config (mitch/general-config))

;; Better lisp highlighting?
(use-package highlight-defined
  ;; :config
  ;; (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)
  :hook (emacs-lisp-mode . highlight-defined-mode))

;; Shell linting?
(use-package flycheck
  :defer 5
  :hook (prog-mode . flycheck-mode))

;; Emacs startup profiling
(use-package esup)

;; Blingy file tree view
(use-package treemacs
  :defer 1
  :config
  (treemacs-project-follow-mode)
  (treemacs-git-mode 'simple)
  (add-hook
   'treemacs-mode-hook
   #'(lambda () (display-line-numbers-mode -1))))
(use-package treemacs-evil
  :after treemacs)
(use-package treemacs-all-the-icons
  :after treemacs)

;; Blingy laggy minimap on the right
(use-package minimap
  :init
  (setq minimap-window-location 'right
	minimap-update-delay 0))

;; internal emacs window manager
;; (use-package edwina
;;   ;;   :config
;;   (setq display-buffer-base-action '(display-buffer-below-selected))
;;   (edwina-setup-dwm-keys)
;;   (edwina-mode 1)
;; )

(use-package visual-fill-column
  :config
  (setq-default visual-fill-column-center-text t)
  (setq-default fill-column 140)
  :hook (org-mode-hook . visual-fill-column-mode))

;; epic drop-down completion
(use-package company
  :config
  (setq company-idle-delay 0.3)
  :hook (prog-mode . company-mode)
  :init (global-company-mode t))
(use-package company-org-block
  :after (org company))
  
;; Visualize whitespace. In a very chill and invisible way.
(use-package whitespace
  :straight (:type built-in)
  :defer 1
  :init
  (setq-default whitespace-style '(face lines-tail))
  (setq-default whitespace-line-column 80)
  :config (global-whitespace-mode t))

(provide 'mitch-packages)
;;; mitch-packages.el ends here
