;;; mitch-packages --- Declare and configure use-package statements

;;; Commentary:
;; This is a file in which I put declarations for packages and things.

;;; Code:

;; diminish
(use-package diminish)
(use-package eldoc
  :defer 1
  :diminish)

;; Keybinding manager
(use-package general
  :config (mitch/general-config))

;; load evil
(use-package evil
  :general
  (general-define-key
   :states 'normal
   "<escape>" 'evil-beginning-of-line
   "C-p" 'scroll-down-line
   "C-n" 'scroll-up-line)
  (general-define-key
   :states 'insert
   "C-w" 'evil-window-map
   "C-V" (general-key-dispatch
	     'evil-quoted-insert
	   "u" 'insert-char))
  :diminish visual-line-mode
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll nil)
  (evil-want-C-i-jump nil)
  (evil-vsplit-window-right t)
  (evil-split-window-below t)
  (evil-undo-system
   (if (>= (string-to-number emacs-version) 28)
       (quote undo-redo)
     (quote undo-fu)))
  :init
  (evil-mode t))
(use-package evil-collection
  :after evil
  :diminish evil-collection-unimpaired-mode
  :config (evil-collection-init))
(use-package evil-commentary
  :diminish 'evil-commentary-mode
  :config (evil-commentary-mode)
  :after evil)
(use-package evil-surround
  :diminish 'global-evil-surround-mode
  :after evil
  :config (global-evil-surround-mode 1))
(use-package evil-terminal-cursor-changer
  :after evil
  :diminish
  :if (not (display-graphic-p))
  :config
  (evil-terminal-cursor-changer-activate)
  (xterm-mouse-mode))
(use-package undo-fu
  :after evil
  :if (< (string-to-number emacs-version) 29)
  :diminish)

;; Completion framework...
(use-package vertico
  :custom (vertico-resize t)
  :config (vertico-mode))
(use-package consult
  :after vertico)
(use-package savehist
  :straight (:type built-in)
  :after vertico
  :init (savehist-mode))
(use-package marginalia
  :after (vertico consult)
  :init (marginalia-mode))
(use-package orderless
  :after vertico
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; broken terminal that doesn't compile but at least it's fast when it does
(use-package vterm
  :custom (vterm-always-compile-module t)
  :config
  (add-hook 'vterm-mode-hook
	    #'(lambda ()
		(display-line-numbers-mode -1))))
;; Better modeline?
(use-package powerline
  :init
  :custom (powerline-default-separator 'slant))
(use-package airline-themes
  :custom (airline-cursor-colors nil)
  :after powerline
  :config
  (load-theme 'airline-ravenpower t))

;; Custom Theme.
;; Not to be confused with a color theme, or a color scheme, or a custom scheme.
(use-package autothemer
  :custom
  (window-divider-default-places t)
  (right-divider-width 5)
  (ring-bell-function 'ignore)
  :config
  (tooltip-mode -1)
  (menu-bar-mode -1)
  (load-theme 'mitch t))

(use-package yascroll
  :diminish
  :defer 1
  :if (not (display-graphic-p))
  :custom (yascroll:delay-to-hide nil)
  :custom-face
  (yascroll:thumb-text-area ((t (:background "ForestGreen"))))
  (yascroll:thumb-fringe
   ((t (:background "ForestGreen" :foreground "ForestGreen"))))
  :config (global-yascroll-bar-mode 1))

;; parentheses settingses
(use-package paredit
  :defer 0.1
  :general (general-define-key
	    :states 'normal
	    "M-j" 'paredit-forward-slurp-sexp
	    "M-k" 'paredit-forward-barf-sexp
	    "M-h" 'paredit-backward-barf-sexp
	    "M-l" 'paredit-backward-slurp-sexp)
  :config
  (show-paren-mode 1)
  (electric-pair-mode 1)
  :custom
  (show-paren-delay 0)
  (show-paren-style 'parenthesis))

;; org mode and messy things
(use-package org
  :straight (:type built-in)
  :mode (("\\.org$" . org-mode))
  :custom
  (org-ellipsis " ▾")
  (org-hide-leading-stars t)
  (org-startup-indented t)
  :config
  (org-indent-mode)
  (add-hook 'org-mode-hook
	    #'(lambda ()
		(add-hook 'after-save-hook
			  #'(lambda ()
			      (org-babel-tangle)))))
  (add-hook 'org-mode-hook
	    #'(lambda ()
		(display-line-numbers-mode -1))))
(use-package org-contrib
  :after org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((powershell . t)
     (shell . t)
     )))
(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :custom
  (org-appear-autolinks t))
(use-package ob-powershell
  :after (org powershell)
  :custom
  (ob-powershell-powershell-command "pwsh"))
(use-package visual-fill-column
  :config
  (setq-default visual-fill-column-center-text t)
  (setq-default fill-column 140)
  :hook (org-mode-hook . visual-fill-column-mode))
(use-package company-org-block
  :after (org company))

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

(use-package cider)

;; or a bad language
(use-package haskell-mode
  :mode "\\.hs\\'"
  ;; :init
  ;; (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  ;; (add-hook 'haskell-mode-hook #'lsp)
  :bind (
	 :map haskell-mode-map
	 ("C-c h" . hoogle)
	 ("C-c s" . haskell-mode-stylish-buffer))
  :config (message "Loaded haskell-mode")
  (setq haskell-mode-stylish-haskell-path "brittany")
  (setq haskell-hoogle-url "https://www.stackage.org/lts/hoogle?q=%s"))

;; Better help-pages. Genuinely pretty great.
(use-package helpful
  :general (general-define-key
	    [remap describe-key] 'helpful-key
	    [remap describe-variable] 'helpful-variable
	    [remap describe-function] 'helpful-callable)
  (general-define-key
   :keymaps 'help-map
   "F" 'describe-face
   "k" 'helpful-key)
  (general-define-key
   :keymaps 'emacs-lisp-mode-map
   :states 'normal
   "K" 'helpful-at-point)
  )

;; Better lisp highlighting?
(use-package highlight-defined
  :hook (emacs-lisp-mode . highlight-defined-mode))

;; Shell linting?
(use-package flycheck
  :defer 5
  :diminish
  :config (global-flycheck-mode))

;; Emacs startup profiling
(use-package esup
  :commands esup)

;; Blingy file tree view
(use-package treemacs
  :general (general-define-key
	    :states 'normal
	    :prefix-command 'treemacs-map-prefix
	    :prefix-map 'treemacs-map
	    :prefix "SPC t"
	    "t" 'treemacs)
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
  :general (general-define-key
	    :states 'normal
	    :prefix-command 'mini-map-prefix
	    :prefix-map 'mini-map
	    :prefix "SPC m"
	    "m" 'minimap-mode
	    "k" 'minimap-kill)
  :custom
  (minimap-window-location 'right)
  (minimap-update-delay 0)
  :custom-face
  (minimap-active-region-background
   ((t (:background "#303030" :extend t))))
  (minimap-current-line-face
   ((t (:background "#afafaf" :extend t)))))

;; epic drop-down completion
(use-package company
  :diminish
  :custom (company-idle-delay 0.75)
  :hook (prog-mode . company-mode)
  :config (global-company-mode t))

;; Visualize whitespace. In a very chill and invisible way.
(use-package whitespace
  :straight (:type built-in)
  :defer 1
  :diminish global-whitespace-mode
  :custom
  (whitespace-style '(face lines-tail))
  (whitespace-line-column 80)
  :config (global-whitespace-mode t))

(provide 'mitch-packages)
;;; mitch-packages.el ends here
