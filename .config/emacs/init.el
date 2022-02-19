;; This is a comment. It's kind of pointless, but
;; it's here. You can delete it if you want.

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
  (evil-global-set-key 'normal (kbd "<escape>") 'evil-beginning-of-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (global-visual-line-mode t))
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
(use-package evil-terminal-cursor-changer
  :straight t
  :if (null (display-graphic-p))
  :config
  (evil-terminal-cursor-changer-activate)
  )

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
  :after ivy)

;; Custom Theme.
;; Not to be confused with a color theme, or a color scheme, or a custom scheme.
(use-package autothemer :straight t)
(load-theme 'mitch t)

;; Relative numbers
(use-package linum-relative
  :straight t
  :defer 0.1
  :config
  ;; (setq linum-relative-backend 'display-line-numbers-mode)
  (setq linum-relative-backend 'linum-mode)
  (setq linum-relative-current-symbol "")
  (linum-relative-global-mode t)
  )
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		treemacs-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda ()
		   (linum-relative-mode 0)
		   )))
;; Better modeline?
(use-package all-the-icons :straight t :if (display-graphic-p))
(use-package doom-modeline :straight t :init (doom-modeline-mode 1))
;; (use-package mode-line-frame
;;   :straight t
;;   :init
;;   (setq mode-line-frame-format mode-line-format)
;;   (setq mode-line-format nil)
;;   :config
;;   (mode-line-frame-create)
;;   )

;; scroll step stuff
(setq scroll-margin 2
      scroll-conservatively 1
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

(use-package yascroll
  :straight t
  :config
  (setq yascroll:delay-to-hide nil)
  (global-yascroll-bar-mode 1))


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
  (setq org-ellipsis " ▾")
  :hook (org-mode . variable-pitch-mode))
;; (use-package writeroom-mode
;;   :straight t
;;   :after org
;;   :hook (org-mode . writeroom-mode)
;;   )

;; cheaty key popups
(use-package which-key
  :straight t
  :init
  (which-key-mode t))

;; diable stupid file open box thingy
(setq use-file-dialog nil)
(setq use-dialog-box nil)

;; run launcher. Copied from
;; https://www.reddit.com/r/unixporn/comments/s7p7pr/so_which_run_launcher_do_you_use_rofi_or_dmenu/
(defun emacs-run-launcher ()
  "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Run counsel-linux-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
  (interactive)
  (with-selected-frame
      (make-frame '((name . "emacs-run-launcher")
		    (minibuffer . only)
		    (width . 120)
		    (height . 11)))
    (unwind-protect
	(counsel-linux-app)
      (delete-frame))))

;; Same, but will edit a new buffer. BROKEN.
(defun emacs-edit-launcher ()
  "Create and select a frame called emacs-edit-launcher which consists only of a minibuffer and has specific dimensions. Run find-file-other-frame on that frame, which is an emacs command that prompts you to select a file and open it in a dmenu like behaviour. Delete the frame after that command has exited"
  (interactive)
  (with-selected-frame
      (make-frame '((name . "emacs-edit-launcher")
		    (minibuffer . only)
		    (width . 120)
		    (height . 11)))
    (unwind-protect
	;; (counsel-find-file-extern emacs)
	(counsel-locate-action-extern)
      (delete-frame)
      )
    ))
