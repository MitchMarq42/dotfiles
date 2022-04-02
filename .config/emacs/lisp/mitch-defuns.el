(defun mitch/evil-init ()
  "A batch of commands to run as the :init of evil's
`use-package'. Made solely to reduce lines in the
init-file."
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll nil)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-fu)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t))
(defun mitch/evil-config ()
  "A batch of commands to run as the :config of
evil's `use-package'. Made solely to reduce lines
in the init-file."
  (evil-mode t)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (global-visual-line-mode t)
  (diminish 'visual-line-mode))
(defun mitch/graphical-setup ()
  "A batch of commands to run at the beginning of
the init file when we're on a graphical display.
This prevents errors in termux and speeds up init
when editing from the console."
  ;; hide gui scrollbars and menubar etc
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (set-fringe-mode 8)
  ;; diable stupid file open box thingy
  (setq use-file-dialog nil)
  (setq use-dialog-box nil)
  ;; Pixel scrolling. Only in emacs 29+...
  (if (>= (string-to-number emacs-version) 29)
      (pixel-scroll-precision-mode t)))

(defun mitch/general-config ()
  "A batch of commands to run immediately after loading the
`general' package. Made solely to reduce lines in the init
file."
  (general-define-key
   "<escape>" 'keyboard-escape-quit
   "C-H F" 'counsel-describe-face)
  (general-define-key
   :states 'motion
   "j" 'evil-next-visual-line
   "k" 'evil-previous-visual-line)
  (general-define-key
   :states 'normal
   "<escape>" 'evil-beginning-of-line)
  (general-define-key
   :states 'normal
   "SPC SPC" 'evil-buffer)
  )

;; This one line cost me over an hour of frustration...
(provide 'mitch-defuns)
