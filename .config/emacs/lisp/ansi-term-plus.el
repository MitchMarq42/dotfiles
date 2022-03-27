;; Fix ansi-term not closing when it closes (broken?)
(defadvice term-sentinel
    (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
	ad-do-it
	(kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)
;; Ansi-term always use zsh?
(defvar my-term-shell (getenv "ZSH"))
(defadvice ansi-term (before force-zsh)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
;; ansi-term utf-8 everything better
(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(add-hook 'term-exec-hook 'my-term-use-utf8)
(defun my-term-setup ()
  "custom function of things to run when launching
a new terminal."
  (display-line-numbers-mode -1))
;; Term cleanup things
(add-hook 'term-mode-hook 'my-term-setup)
(setq evil-collection-term-sync-state-and-mode-p nil)

(provide 'ansi-term-plus)
