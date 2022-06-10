;;; mitch-keybinds.el --- do keybinding things, mostly with General...

;;; Commentary:
;; -----------------------------------------------------------------------------
;; There are a lot of things we do with the keyboard.  Perhaps all of the
;; things, in fact.  Thus, we use the `general' package for transparently
;; defining keybindings in various states.  See
;; `https://github.com/noctuid/general.el' for more.
;; -----------------------------------------------------------------------------
;;; Code:
(general-define-key
 "<escape>" 'keyboard-escape-quit
 "C--" 'text-scale-decrease
 "C-=" 'text-scale-increase)
(general-define-key
 :states 'motion
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line)
(general-define-key
 :states 'normal
 :map 'org-mode-map
 "RET" 'org-open-at-point)
(general-define-key
 :states '(normal visual)
 :prefix "SPC"
 :non-normal-prefix "SPC"
 "w" 'evil-window-map
 "h" 'help-command
 "b" 'switch-to-buffer
 "SPC" 'evil-buffer
 "v" 'vterm)
(general-define-key
 :states 'normal
 :prefix-command 'eval-map-prefix
 :prefix-map 'eval-map
 :prefix "SPC e"
 "l" 'eval-last-sexp
 "b" 'eval-buffer
 "r" 'eval-region
 ":" 'eval-expression
 "s" 'eshell)

;; fixed?
(general-define-key
 :states 'normal
 :prefix-map 'ctl-x-4-map
 :prefix "SPC 4"
 "v" 'vterm-other-window)

;; broken
(general-define-key
 :prefix-map 'minibuffer-mode-map
 "DEL" 'backward-kill-word)

(provide 'mitch-keybinds)
;;; mitch-keybinds.el ends here
