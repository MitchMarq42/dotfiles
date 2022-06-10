;;; eshell-settings --- settings for eshell.
;;; Commentary:
;; the elisp linter wants me to put some text here so I guess I will

;;; Code:
(defun eshell/emacs (&rest args)
  "Basically you can edit ARGS and it will open in a new buffer.
When your shell is Emacs, your Emacs is but an oyster...
This is taken from a website that I can't remember at the moment."
  (if (null args)
      (bury-buffer)
    (mapc
     #'find-file
     (mapcar
      #'expand-file-name (eshell-flatten-list (reverse args))))))
(defun eshell/clear ()
  "Clear the scrollback buffer, like `clear' in a real shell..."
  (eshell/clear-scrollback))
(defun eshell/faketty (args)
  "USAGE: `faketty ARGS` where ARGS is anything that spews colors.
Credit: https://stackoverflow.com/questions/1401002/how-to-trick-an-application-into-thinking-its-stdout-is-a-terminal-not-a-pipe"
  (let
      ((shell-command-dont-erase-buffer t))
    (shell-command
     (concat "script -qfc " args " /dev/null")
     (current-buffer))
    ))

(provide 'eshell-settings)
;;; eshell-settings.el ends here
