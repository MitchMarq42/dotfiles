;; Emacs configuration. Written while watching SystemCrafters' tutorial.
;; I think nvim is a mostly better editor, and I am well aware of the
;; problems with emacs' GUI layer. However, until the whole of nvim's vi
;; nature is rewritten in pure-ish lua, emacs is at least more internally
;; consistent. As such, this config will primarily "feel" like a vimmer's
;; usual config file.

;; https://mitchmarq42.xyz

;; Variable setting
(defvar mitchcustom/default-font-size 130)
(defvar mitchcustom/only-good-font "MesloLGS NF")

;; Cucky auto settings
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(mitch))
 '(custom-safe-themes
   '("540eb4ccec92b3f0a8450567466b3f69ed856183a45a27c1e6c57428aa07bb9e" "4b621b042cc820dd651b44de264a4ab5cd68c42b27a57150cd34ae5468338352" "d72929ea2bef9c28898936b8a0e9f7b5a846a8cbd72984a174383587caa7d355" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))
 '(package-selected-packages
   '(doom-modeline org-evil evil-commentary evil which-key rainbow-delimiters use-package smart-mode-line-powerline-theme ivy command-log-mode)))

;; Disable landing screen
(setq inhibit-startup-message t)
;; Disable scroll and tool bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
;; disable bell
(setq visible-bell t)
;; set font
(set-face-attribute 'default nil :font mitchcustom/only-good-font :height mitchcustom/default-font-size)
(set-face-attribute 'fixed-pitch nil :font mitchcustom/only-good-font :height mitchcustom/default-font-size)
(set-face-attribute 'variable-pitch nil :font mitchcustom/only-good-font :height mitchcustom/default-font-size)
;; theme setting (temporary)
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

;; (use-package ivy
;;   :bind (("C-s" . swiper)
;;          :map ivy-minibuffer-map
;;          ("TAB" . ivy-alt-done)	
;;          ("C-l" . ivy-alt-done)
;;          ("C-j" . ivy-next-line)
;;          ("C-k" . ivy-previous-line)
;;          :map ivy-switch-buffer-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-l" . ivy-done)
;;          ("C-d" . ivy-switch-buffer-kill)
;;          :map ivy-reverse-i-search-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-d" . ivy-reverse-i-search-kill))
;;   :config
;;   (ivy-mode 1))

;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers 'relative)
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook (prog.mode . rainbow-delimiters-mode))
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
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))
;; (require 'evil)
(use-package evil-commentary)
(evil-commentary-mode)
(use-package org-evil)
(require 'org-evil)

;; smooth scrolling
(setq scroll-step 1
  scroll-conservatively 10000)
;; terminal cursor destruction
(use-package evil-terminal-cursor-changer)
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate))
(setq evil-motion-state-cursor 'box)  ; █
(setq evil-visual-state-cursor 'box)  ; █
(setq evil-normal-state-cursor 'box)  ; █
(setq evil-insert-state-cursor 'bar)  ; ⎸
(setq evil-emacs-state-cursor  'hbar) ; _

(use-package doom-modeline
  :init (doom-modeline-mode 1))
(use-package all-the-icons
  :if (display-graphic-p))

;; (add-to-list 'default-frame-alist '(foreground-color . "#ffffcc"))
;; (add-to-list 'default-frame-alist '(background-color . "black"))
