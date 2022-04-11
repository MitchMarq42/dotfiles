;; Eshell settings. settings for eshell.

(defun eshell/emacs (&optional file)
  "When your shell is emacs,
your emacs is but an oyster..."
      (counsel-find-file file))
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
