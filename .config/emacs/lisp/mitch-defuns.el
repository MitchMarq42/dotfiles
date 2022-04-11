;; 	        _  _         _
;;   _ __ ___  (_)| |_  ___ | |__
;;  | '_ ` _ \ | || __|/ __|| '_ \  _____
;;  | | | | | || || |_| (__ | | | ||_____|
;;  |_| |_| |_||_| \__|\___||_| |_|
;;      _         __                              _
;;   __| |  ___  / _| _   _  _ __   ___      ___ | |
;;  / _` | / _ \| |_ | | | || '_ \ / __|    / _ \| |
;; | (_| ||  __/|  _|| |_| || | | |\__ \ _ |  __/| |
;;  \__,_| \___||_|   \__,_||_| |_||___/(_) \___||_|
;;
;; Some functions to run when loading packages...
         
(defun mitch/evil-init ()
  "A batch of commands to run as the :init of evil's
`use-package'. Made solely to reduce lines in the
init-file."
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-want-C-u-scroll nil
	evil-want-C-i-jump nil)
  (setq evil-undo-system
	(if (>= (string-to-number emacs-version) 29)
	    (quote undo-redo)
	  (quote undo-fu)))
  (setq evil-vsplit-window-right t
	evil-split-window-below t))
(defun mitch/evil-config ()
  "A batch of commands to run as the :config of
evil's `use-package'. Made solely to reduce lines
in the init-file."
  (evil-mode t)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (global-visual-line-mode t)
  (diminish 'visual-line-mode)
  ;; Make evil-join combine lines. Taken from https://github.com/hlissner/doom-emacs/commit/40cf6139ed53b635fec37ce623c4b1093c78a11e
;;   (evil-define-operator +evil-join-a (beg end)
;;     "Join the selected lines.
;; This advice improves on `evil-join' by removing comment delimiters when joining
;; commented lines, by using `fill-region-as-paragraph'.
;; From https://github.com/emacs-evil/evil/issues/606"
;;     :motion evil-line
;;     (let* ((count (count-lines beg end))
;; 	   (count (if (> count 1) (1- count) count))
;; 	   (fixup-mark (make-marker)))
;;       (dotimes (var count)
;; 	(if (and (bolp) (eolp))
;; 	    (join-line 1)
;; 	  (let* ((end (line-beginning-position 3))
;; 		 (fill-column (1+ (- end beg))))
;; 	    (set-marker fixup-mark (line-end-position))
;; 	    (fill-region-as-paragraph beg end nil t)
;; 	    (goto-char fixup-mark)
;; 	    (fixup-whitespace))))
;;       (set-marker fixup-mark nil)))
;;   (advice-add #'evil-join :override #'+evil-join-a)
  )
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
   "C-H F" 'counsel-describe-face
   "C-H k" 'helpful-key)
  (general-define-key
   :states 'motion
   "j" 'evil-next-visual-line
   "k" 'evil-previous-visual-line)
  (general-define-key
   :states 'normal
   "<escape>" 'evil-beginning-of-line
   "SPC SPC" 'evil-buffer
   "SPC w" 'evil-window-map)
  (general-define-key
   :states 'insert
   "C-w" 'evil-window-map
   "q" (general-key-dispatch
	   'self-insert-command
	 "q" 'toggle-input-method)
   "C-V" (general-key-dispatch
	     'evil-quoted-insert
	   "u" 'counsel-unicode-char))
  )

;; This one line cost me over an hour of frustration...
(provide 'mitch-defuns)
