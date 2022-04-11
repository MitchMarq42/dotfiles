;; Eshell settings. settings for eshell.

(defun eshell/emacs (&rest file)
  "When your shell is emacs,
your emacs is but an oyster..."
  (if (null args)
      (bury-buffer)
    (mapc
     #'find-file
     (mapcar
      #'expand-file-name (eshell-flatten-list (reverse args))))))
(defun eshell/clear ()
  "Clear the scrollback buffer, like `clear' in
a real shell"
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
