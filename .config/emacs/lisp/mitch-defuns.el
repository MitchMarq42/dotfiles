(defun mitch/evil-init ()
  "A batch of commands to run as the :init of evil's
`use-package'. Made solely to reduce lines in the
init-file."
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-fu)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t))
(defun mitch/evil-config ()
  "A batch of commands to run as the :config of
evil's `use-package'. Made solely to reduce lines
in the init-file."
  (evil-mode t)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-global-set-key 'normal (kbd "C-j") 'evil-scroll-line-down)
  (evil-global-set-key 'normal (kbd "C-k") 'evil-scroll-line-up)
  (evil-global-set-key 'normal (kbd "<escape>") 'evil-beginning-of-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (global-visual-line-mode t)
  (diminish 'visual-line-mode))
(defun mitch/linum-relative-config ()
  "A batch of commands to run as the :config of
linum-relative's `use-package'. Made solely to
reduce lines in the init-file."
  (setq linum-relative-backend 'linum-mode)
  (setq linum-relative-current-symbol "")
  (linum-relative-mode t)
  (dolist (mode '(org-mode-hook
		  term-mode-hook
		  shell-mode-hook
		  treemacs-mode-hook
		  eshell-mode-hook
		  counsel-mode-hook
		  ivy-mode-hook
		  help-mode-hook))
    (add-hook mode (lambda ()
		     (linum-relative-mode -1)))))
(defun mitch/graphical-setup ()
  "A batch of commands to run at the beginning of
the init file when we're on a graphical display.
This prevents errors in termux and speeds up init
when editing from the console."
  ;; hide gui scrollbars and menubar etc (needs a hook)
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (set-fringe-mode 8)
  ;; diable stupid file open box thingy
  (setq use-file-dialog nil)
  (setq use-dialog-box nil)
  ;; Pixel scrolling. Only in emacs 29+...
					;  (pixel-scroll-precision-mode t)
  )

;; This one line cost me over an hour of frustration...
(provide 'mitch-defuns)
