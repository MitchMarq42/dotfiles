;; Emacs configuration. Written while watching SystemCrafters' tutorial.
;; I think nvim is a mostly better editor, and I am well aware of the
;; problems with emacs' GUI layer. However, until the whole of nvim's vi
;; nature is rewritten in pure-ish lua, emacs is at least more internally
;; consistent. As such, this config will primarily "feel" like a vimmer's
;; usual config file.

;; https://mitchmarq42.xyz

;; Disable landing screen, gui elements, bell
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Cucky auto settings (make sure to try defining elsewhere)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-bullets undo-fu magit undo-tree yascroll which-key use-package smart-mode-line-powerline-theme rainbow-mode rainbow-delimiters org-evil linum-relative ivy highlight-parentheses evil-terminal-cursor-changer evil-commentary eterm-256color doom-themes doom-modeline command-log-mode autothemer)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Variable setting

;; START TABS CONFIG (copied from https://dougie.io/emacs/indentation/)
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)
;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))
;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)
;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript
;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)
;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)
;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)
;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(setq whitespace-style '(face tabs tab-mark trailing))
(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere
;; END TABS CONFIG

;; make Esc quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; package/plugin bootstrap?
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; theme
(use-package autothemer
  :ensure t)

(use-package ivy
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
  :config
  (ivy-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
;; Good-ish vim emulation...
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  )
(use-package undo-fu)
;; comment with gcc
(use-package evil-commentary
  :config
  (evil-commentary-mode))
(use-package org-evil
  :config
  (require 'org-evil))

;; terminal cursor shape fixer
(use-package evil-terminal-cursor-changer
  :config
  (setq evil-motion-state-cursor 'box)  ; █
  (setq evil-visual-state-cursor 'box)  ; █
  (setq evil-normal-state-cursor 'box)  ; █
  (setq evil-insert-state-cursor 'bar)  ; ⎸
  (setq evil-emacs-state-cursor 'hbar)) ; _
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate))

;; smooth scrolling
(setq scroll-step 1
      scroll-conservatively 10000)

(use-package doom-modeline
  :init (doom-modeline-mode 1))
(use-package all-the-icons
  :if (display-graphic-p))

;; line numbers
(use-package linum-relative
  :config
  (column-number-mode)
  (global-display-line-numbers-mode t)
  (setq display-line-numbers 'relative)
  (setq linum-relative-backend 'display-line-numbers-mode)
  :init
  (require 'linum-relative)
  (linum-on))
(linum-relative-mode)
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; highlight parentheses
(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; hex colors
(use-package rainbow-mode
  :ensure t
  :hook prog-mode)

;; better emacs-terminal
(use-package eterm-256color
  :ensure t)
(add-hook 'term-mode-hook #'eterm-256color-mode)

;; text scrollbar
(use-package yascroll
  :ensure t
  :init
  (global-yascroll-bar-mode 1)
  (setq yascroll:delay-to-hide nil)
  )

;; magit-- git client
(use-package magit
  :ensure t)

;; org stuff
(defun mitch/org-mode-setup()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))
(use-package org
  :hook (org-mode . mitch/org-mode-setup)
  :config
  (setq org-ellipses " (expand)"
        org-hide-emphasis-markers t))
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  )

(load-theme 'mitch t)
