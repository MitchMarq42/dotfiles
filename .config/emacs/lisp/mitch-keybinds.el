;; mitch-keybinds.el-- do keybinding things, mostly with General...
  (general-define-key
   "<escape>" 'keyboard-escape-quit
   "C--" 'text-scale-decrease
   "C-=" 'text-scale-increase)
  (general-define-key
   :keymaps 'help-map
   "F" 'describe-face
   "k" 'helpful-key)
  (general-define-key
   :keymaps 'emacs-lisp-mode-map
   :states 'normal
   "K" 'helpful-at-point)
  (general-define-key
   :states 'motion
   "j" 'evil-next-visual-line
   "k" 'evil-previous-visual-line)
  (general-define-key
   :states 'normal
   "<escape>" 'evil-beginning-of-line
   "C-p" 'scroll-down-line
   "C-n" 'scroll-up-line)
  (general-define-key
   :states '(normal visual)
   :prefix "SPC"
   :non-normal-prefix "SPC"
   "w" 'evil-window-map
   "h" 'help-command
   "b" 'counsel-switch-buffer
   "SPC" 'evil-buffer)
  (general-define-key
   :states 'normal 
   :prefix-command 'eval-map-prefix
   :prefix-map 'eval-map
   :prefix "SPC e"
   "l" 'eval-last-sexp
   "b" 'eval-buffer
   "r" 'eval-region
   ":" 'eval-expression)
  (general-define-key
   :states 'normal
   :prefix-command 'mini-map-prefix
   :prefix-map 'mini-map
   :prefix "SPC m"
   "m" 'minimap-mode
   "k" 'minimap-kill)
  (general-define-key
   :states 'normal
   :prefix-command 'treemacs-map-prefix
   :prefix-map 'treemacs-map
   :prefix "SPC t"
   "t" 'treemacs)
  (general-define-key
   :states 'insert
   "C-w" 'evil-window-map
   "q" (general-key-dispatch
	   'self-insert-command
	 "q" 'toggle-input-method)
   "C-V" (general-key-dispatch
	     'evil-quoted-insert
	   "u" 'counsel-unicode-char))

(provide 'mitch-keybinds)
