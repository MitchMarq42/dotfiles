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
(use-package evil-commentary
  :diminish 'evil-commentary-mode
  :config (evil-commentary-mode)
  :after evil)
(use-package evil-surround
  :diminish 'global-evil-surround-mode
  :after evil
  :config
  (global-evil-surround-mode 1))
(use-package evil-terminal-cursor-changer
  :after evil
  :diminish
  :if (not (display-graphic-p))
  :config
  (evil-terminal-cursor-changer-activate)
  (xterm-mouse-mode))
(if (< (string-to-number emacs-version) 29)
    (use-package undo-fu
      :diminish))

;; Completion framework...
(use-package vertico
  :after consult
  :init (vertico-mode))
(use-package consult
  :defer 1)
(use-package savehist
  :straight (:type built-in)
  :after consult
  :init (savehist-mode))
(use-package marginalia
  :after (vertico consult)
  :init (marginalia-mode))
(use-package orderless
  :after consult
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

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
  :if (display-graphic-p)
  :custom (yascroll:delay-to-hide nil)
  :custom-face
  (yascroll:thumb-text-area ((t (:background "ForestGreen"))))
  (yascroll:thumb-fringe
   ((t (:background "ForestGreen" :foreground "ForestGreen"))))
  :config (global-yascroll-bar-mode 1))

;; parentheses settingses
(use-package paredit
  :defer 0.1
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
  :after org
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
(use-package helpful
  :defer 0.75)

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
  :diminish
  :config (global-flycheck-mode))

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
  :custom
  (minimap-window-location 'right)
  (minimap-update-delay 0)
  :custom-face
  (minimap-active-region-background
   ((t (:background "#303030" :extend t))))
  (minimap-current-line-face
   ((t (:background "#afafaf" :extend t)))))

;; internal emacs window manager
;; (use-package edwina
;;   ;;   :config
;;   (setq display-buffer-base-action '(display-buffer-below-selected))
;;   (edwina-setup-dwm-keys)
;;   (edwina-mode 1)
;; )

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
  :diminish
  :init
  (setq-default whitespace-style '(face lines-tail))
  (setq-default whitespace-line-column 80)
  :config (global-whitespace-mode t))

(use-package pdf-tools
  :straight (:type git :host github
		      :repo "dalanicolai/pdf-tools"
		      :branch "pdf-roll"
		      :files ("lisp/*.el"
			      "README"
			      ("build" "Makefile")
			      ("build" "server")
			      (:exclude "lisp/tablist.el" "lisp/tablist-filter.el")))
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  ;; (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
	TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
	TeX-source-correlate-start-server t)
  (add-hook 'pdf-view-mode-hook
	    #'(lambda () (display-line-numbers-mode -1) (mini-modeline-mode t)))
  :hook (TeX-after-compilation-finished-functions TeX-revert-document-buffer))

(use-package image-roll
  :straight (:type git :repo "dalanicolai/image-roll.el.git"))
;; (use-package hide-mode-line
;;   ;; :hook (PDFView . hide-mode-line-mode)
;;   :config
;;   (hide-mode-line-mode)
;;   (setq input-method-use-echo-area nil)
;;   (setq resize-mini-windows nil))
;; (use-package mini-modeline
;;   :straight (:type git :repo "kiennq/emacs-mini-modeline")
;;   :config
;;   (mini-modeline-mode))

(provide 'mitch-packages)
;;; mitch-packages.el ends here
