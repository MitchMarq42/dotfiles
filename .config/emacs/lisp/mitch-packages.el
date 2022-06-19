;;; mitch-packages --- Declare and configure use-package statements

;;; Commentary:
;; -----------------------------------------------------------------------------
;; This is a file in which I put declarations for packages and things.
;; -----------------------------------------------------------------------------
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
;; (use-package vertico
;;   :custom (vertico-resize t)
;;   :config (vertico-mode))
;; (use-package consult
;;   :after vertico)

;; Minibuffer generic stuff
(use-package savehist
  :straight (:type built-in)
  ;; :after vertico
  :init (savehist-mode))
(use-package marginalia
  ;; :after (vertico consult)
  :init (marginalia-mode))
(use-package orderless
  ;; :after vertico
  ;; :config
  ;;  (setq completion-category-defaults nil
  ;;        completion-category-overrides nil)
  :commands 'execute-extended-command
  :custom
  (completion-styles '(orderless partial-completion basic))
  (completion-category-defaults nil)
  ;; (completion-category-overrides '((file (styles basic partial-completion))))
  (completion-category-overrides nil)
  )

;; broken terminal that doesn't compile but at least it's fast when it does
(use-package vterm
  :custom
  (vterm-always-compile-module t)
  (vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=no")
  (vterm-clear-scrollback-when-clearing t)
  :config
  (evil-collection-define-key 'insert 'vterm-mode-map
    (kbd "C-w") 'evil-window-map)
  (add-to-list 'vterm-keymap-exceptions
               "C-w")
  (setq mitch/vterm-eval-cmds-strings
        '("update-pwd"
          "restart-emacs"
          "find-file-other-window"
          "find-file-other-frame"))
  (dolist (emacs-function mitch/vterm-eval-cmds-strings)
    (add-to-list 'vterm-eval-cmds
                 (list emacs-function (intern emacs-function))))
  :hook
  (vterm-mode . mitch/terminal-setup)
  (vterm-exit-functions . save-buffers-kill-terminal))
(use-package multi-vterm)

;; Better modeline?
(use-package powerline
  :init
  :custom
  (powerline-default-separator 'utf-8)
  (powerline-utf-8-separator-left 57532)
  (powerline-utf-8-separator-right 57534)
  (powerline-display-hud nil)
  (powerline-gui-use-vcs-glyph t))
(use-package airline-themes
  :custom
  (airline-cursor-colors nil)
  (airline-display-directory t)
  (airline-eshell-colors nil)
  (airline-shortened-directory-length 20)
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
  (load-theme 'mitch t)
  )
;; (use-package doom-themes
;;   :init (load-theme 'doom-one t))

;; (use-package yascroll
;;   :diminish
;;   :defer 1
;;   :if (not (display-graphic-p))
;;   :custom (yascroll:delay-to-hide nil)
;;   :custom-face
;;   (yascroll:thumb-text-area ((t (:background "ForestGreen"))))
;;   (yascroll:thumb-fringe
;;    ((t (:background "ForestGreen" :foreground "ForestGreen"))))
;;   :config (global-yascroll-bar-mode 1))

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
  (with-eval-after-load 'org
    ;; This is needed as of Org 9.2
    (require 'org-tempo)
    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("ps1" . "src powershell")))
  :hook (org-mode . turn-off-line-numbers))
(use-package org-variable-pitch
  :diminish
  :config
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-delimiter-face fixed-pitch))
  :hook (org-mode . org-variable-pitch-minor-mode))
(use-package org-contrib
  :after org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((powershell . t)
     (shell . t)
     )))
;; (use-package org-appear
;;   :hook (org-mode . org-appear-mode)
;;   :after org
;;   :custom
;;   (org-appear-autolinks t))
(use-package ob-powershell
  :after (org powershell)
  :custom
  (ob-powershell-powershell-command "pwsh"))
;; (use-package visual-fill-column
;;   :config
;;   (setq-default visual-fill-column-center-text t)
;;   (setq-default fill-column 140)
;;   :hook (org-mode . visual-fill-column-mode))
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
(use-package powershell
  :mode ("\\.ps1\\'" . powershell-mode))
(use-package cider
  :defer 1)

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

;; c sharp; taken from https://www.reddit.com/r/emacs/comments/k8tnzg/help_setting_up_c_lsp_omnisharproslyn/
(use-package csharp-mode
  ;; :ensure t
  :mode (("\\.cs\\'" . csharp-mode))
  :config
  (add-to-list 'compilation-error-regexp-alist-alist
               '(my-csharp
                 "^\\(.+\\)(\\([1-9][0-9]+\\),\\([0-9]+\\)): \\(?:\\(warning\\)\\|error\\)?"
                 1 2 3 (4)))
  (add-to-list 'compilation-error-regexp-alist 'my-csharp)
  (defun my-csharp-repl ()
    "Switch to the CSharpRepl buffer, creating it if necessary."
    (interactive)
    (if-let ((buf (get-buffer "*CSharpRepl*")))
        (pop-to-buffer buf)
      (when-let ((b (make-comint "CSharpRepl" "csharp")))
        (switch-to-buffer-other-window b))))
  (define-key csharp-mode-map (kbd "C-c C-z") 'my-csharp-repl)
  ;; (define-key csharp-mode-map (kbd "C-c C-c") #'projectile-compile-project)
  )
(use-package omnisharp
  ;; :ensure t
  :after csharp-mode
  :config
  (eval-after-load 'company '(add-to-list 'company-backends 'company-omnisharp))
  ;; (setq omnisharp-completing-read-function #'ivy-completing-read)
  (put 'my-omnisharp-solution-path 'safe-local-variable #'stringp)
  :hook (csharp-mode . omnisharp-mode))

(use-package lsp-mode
  :hook ((powershell-mode . lsp)
         (csharp-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-completion-mode . my/lsp-mode-setup-completion))
  :commands lsp
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(flex))) ;; Configure flex
  :custom
  (lsp-completion-provider :none))

;; optionally
(use-package lsp-ui
  :after lsp
  :commands lsp-ui-mode)
(use-package lsp-treemacs
  :after lsp
  :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-powershell)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

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
   "K" 'helpful-at-point))

;; Better lisp highlighting?
(use-package highlight-defined
  :hook (emacs-lisp-mode . highlight-defined-mode))

;; Shell linting?
(use-package flycheck
  :diminish
  :hook (prog-mode . flycheck-mode)
  ;; :config (global-flycheck-mode t)
  )

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
  :hook
  (treemacs-mode . turn-off-line-numbers))
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
;; (use-package company
;;   :diminish
;;   :custom (company-require-match nil)
;;   (company-tooltip-align-annotations t)
;;   :hook (prog-mode . company-mode))
;; (use-package company-lsp
;;   :after (lsp company)
;;   :config
;;   (push 'company-lsp company-backends))
;; (use-package company-fuzzy
;;   :hook (company-mode . company-fuzzy-mode)
;;   ;; :init
;;   :custom
;;   ;; (company-fuzzy-sorting-backend 'flx)
;;   (company-fuzzy-prefix-on-top nil)
;;   (company-fuzzy-history-backends '(company-yasnippet))
;;   (company-fuzzy-trigger-symbols '("." "->" "<" "\"" "'" "@"))
;;   (company-fuzzy-passthrough-backends '(company-capf)))
(use-package corfu
  :custom
  (completion-cycle-threshold 3)
  (tab-always-indent 'complete)
  (corfu-auto t)
  (corfu-quit-no-match t)
  (corfu-count 40)
  ;; (corfu-separator ";")
  :init (global-corfu-mode)
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active)
                (bound-and-true-p vertico--input))
      (setq-local corfu-auto nil) ;; Enable/disable auto completion
      (corfu-mode 1)
      (minibuffer-complete)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)
  ;; (defun corfu-kill-in-minibuffer ()
  ;;   "Kill corfu and minibuffer. To be bound to Esc."
  ;;   (interactive)
  ;;   (setq-local inhibit-debugger t)
  ;;   (corfu-quit)
  ;;   (exit-minibuffer)
  ;;   )
  (defun corfu-send-shell (&rest _)
    "Send completion candidate when inside comint/eshell."
    (cond
     ((and (derived-mode-p 'eshell-mode) (fboundp 'eshell-send-input))
      (eshell-send-input))
     ((and (derived-mode-p 'comint-mode) (fboundp 'comint-send-input))
      (comint-send-input))))
  :general
  (general-define-key
   :prefix-map 'corfu-map
   "C-n" 'corfu-next
   "C-p" 'corfu-previous
   "RET" 'corfu-insert
   "ESC" 'corfu-kill-in-minibuffer
   )
  )

(use-package popon
  :straight
  (:type git
         :repo "https://codeberg.org/akib/emacs-popon"))
(use-package corfu-terminal
  :straight
  (:type git
         :repo "https://codeberg.org/akib/emacs-corfu-terminal")
  :init (unless
            (display-graphic-p)
          (corfu-terminal-mode +1)))

;; Visualize whitespace. In a very chill and invisible way.
(use-package whitespace
  :straight (:type built-in)
  :defer 1
  :diminish global-whitespace-mode
  :custom
  (whitespace-style '(face lines-tail))
  (whitespace-line-column 80)
  :config (global-whitespace-mode t))

;; (use-package lsp-dart
;;   ;; :custom (lsp-dart-dap-flutter-hot-reload t)
;;   :init
;;   (add-hook 'dart-mode-hook 'lsp)
;;   (add-hook 'dart-mode-hook
;; 	    #'(lambda ()
;; 		(add-hook 'after-save-hook
;; 			  #'(lambda ()
;; 			      (lsp-dart-dap-flutter-hot-reload))))))

(use-package eshell
  :straight (:type built-in)
  :hook (eshell-mode . mitch/terminal-setup)
  :config (require 'eshell-settings))

(use-package popper
  :custom
  (display-buffer-base-action '(display-buffer-pop-up-window))
  (popper-reference-buffers
   '(
     helpful-mode
     compilation-mode
     ibuffer-mode
     "*Warnings"))
  ;; (popper-display-function
  ;;  #'display-buffer-pop-up-frame)
  (popper-mode-line nil)
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

;; (use-package mini-frame
;;   :init (mini-frame-mode))
(use-package xwidget ;-webkit
  :straight (:type built-in)
  :if (featurep 'xwidget-internal)
  :config
  (add-hook 'xwidget-webkit-mode-hook
	    #'(lambda ()
		(turn-off-line-numbers)
		(scroll-bar-mode -1)
		))
  )

(provide 'mitch-packages)
;;; mitch-packages.el ends here
