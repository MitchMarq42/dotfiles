;; This is a comment. It's kind of pointless, but
;; it's here. You can delete it if you want.
(server-start)

;; Load the files that I put my settings in...
(setq mitch-directory
      (directory-file-name
       (concat user-emacs-directory
	       (convert-standard-filename "lisp/"))))
(setq load-path
      (cons mitch-directory load-path))
(require 'mitch-defuns)

;; minify yes/no prompts
(defalias 'yes-or-no-p 'y-or-n-p)
;; minibuffer frame basically (disabled because gnome borders are ugly)
;; (setq initial-frame-alist (append '((minibuffer . nil)) initial-frame-alist))
;; (setq default-frame-alist (append '((minibuffer . nil)) default-frame-alist))
;; (setq minibuffer-auto-raise t)
;; (setq minibuffer-exit-hook '(lambda () (lower-frame)))
;; (setq minibuffer-frame-alist '((width . 80) (height . 10)))
;; do the things
(setq server-after-make-frame-hook 'mitch/graphical-setup)
(if (display-graphic-p) (mitch/graphical-setup))

;; remove auto-generated bits
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (not (file-exists-p custom-file))
    (make-empty-file custom-file t))
(load custom-file)

;; Control backups/swapfiles
(defvar backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))
(setq backup-directory-alist `(("." . ,backup-directory)))

;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))
(setq create-lockfiles nil)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; straight.el minified bootstrap
;; (the better package manager?) (split lines if you want) (or not)
(defvar bootstrap-version) (let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)) (bootstrap-version 5)) (unless (file-exists-p bootstrap-file) (with-current-buffer (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" 'silent 'inhibit-cookies) (goto-char (point-max)) (eval-print-last-sexp))) (load bootstrap-file nil 'nomessage)) (straight-use-package 'use-package) (setq straight-use-package-by-default t)

(require 'mitch-packages)

;; Relative numbers
(setq display-line-numbers-type 'relative
      display-line-numbers-width-start 1)
(global-display-line-numbers-mode)

;; scroll step stuff
(setq scroll-margin 2
      scroll-conservatively 100
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

;; run launcher exists. Copy it from
;; https://www.reddit.com/r/unixporn/comments/s7p7pr/so_which_run_launcher_do_you_use_rofi_or_dmenu/
;; I don't have it here because I don't use it right now.

;; Fix ansi-term not closing when it closes (broken?)
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
	ad-do-it
	(kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)
;; Ansi-term always use zsh?
(defvar my-term-shell "/bin/zsh")
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

;; (use-package oneonone :straight t)

;; (use-package origami :straight t)

(use-package slime :straight t)
(setq inferior-lisp-program "sbcl")

(use-package powershell :straight t)
(use-package vertico
  :straight t)
;; https://raw.githubusercontent.com/emacksnotes/emacsnotes.wordpress.com/master/my-xwidget-menu.el

(require 'xwidget)

(when
    (featurep 'xwidget-internal)
  (easy-menu-define my-xwidget-tools-menu nil "Menu for Xwidget Webkit."
    `("Xwidget Webkit" :visible
      (featurep 'xwidget-internal)
      ["Browse Url ..." xwidget-webkit-browse-url :help "Ask xwidget-webkit to browse URL"]
      ["End Edit Textarea" xwidget-webkit-end-edit-textarea :help "End editing of a webkit text area"]))
  (easy-menu-add-item menu-bar-tools-menu nil my-xwidget-tools-menu 'separator-net)
  (easy-menu-define my-xwidget-menu xwidget-webkit-mode-map "Menu for Xwidget Webkit."
    '("Xwidget Webkit"
      ["Browse Url" xwidget-webkit-browse-url :help "Ask xwidget-webkit to browse URL"]
      ["Reload" xwidget-webkit-reload :help "Reload current url"]
      ["Back" xwidget-webkit-back :help "Go back in history"]
      "--"
      ["Insert String" xwidget-webkit-insert-string :help "current webkit widget"]
      ["End Edit Textarea" xwidget-webkit-end-edit-textarea :help "End editing of a webkit text area"]
      "--"
      ["Scroll Forward" xwidget-webkit-scroll-forward :help "Scroll webkit forwards"]
      ["Scroll Backward" xwidget-webkit-scroll-backward :help "Scroll webkit backwards"]
      "--"
      ["Scroll Up" xwidget-webkit-scroll-up :help "Scroll webkit up"]
      ["Scroll Down" xwidget-webkit-scroll-down :help "Scroll webkit down"]
      "--"
      ["Scroll Top" xwidget-webkit-scroll-top :help "Scroll webkit to the very top"]
      ["Scroll Bottom" xwidget-webkit-scroll-bottom :help "Scroll webkit to the very bottom"]
      "--"
      ["Zoom In" xwidget-webkit-zoom-in :help "Increase webkit view zoom factor"]
      ["Zoom Out" xwidget-webkit-zoom-out :help "Decrease webkit view zoom factor"]
      "--"
      ["Fit Width" xwidget-webkit-fit-width :help "Adjust width of webkit to window width"]
      ["Adjust Size" xwidget-webkit-adjust-size :help "Manually set webkit size to width W, height H"]
      ["Adjust Size Dispatch" xwidget-webkit-adjust-size-dispatch :help "Adjust size according to mode"]
      ["Adjust Size To Content" xwidget-webkit-adjust-size-to-content :help "Adjust webkit to content size"]
      "--"
      ["Copy Selection As Kill" xwidget-webkit-copy-selection-as-kill :help "Get the webkit selection and put it on the kill-ring"]
      ["Current Url" xwidget-webkit-current-url :help "Get the webkit url and place it on the kill-ring"]
      "--"
      ["Show Element" xwidget-webkit-show-element :help "Make webkit xwidget XW show a named element ELEMENT-SELECTOR"]
      ["Show Id Element" xwidget-webkit-show-id-element :help "Make webkit xwidget XW show an id-element ELEMENT-ID"]
      ["Show Id Or Named Element" xwidget-webkit-show-id-or-named-element :help "Make webkit xwidget XW show a name or element id ELEMENT-ID"]
      ["Show Named Element" xwidget-webkit-show-named-element :help "Make webkit xwidget XW show a named element ELEMENT-NAME"]
      "--"
      ["Cleanup" xwidget-cleanup :help "Delete zombie xwidgets"]
      ["Event Handler" xwidget-event-handler :help "Receive xwidget event"]
      "--"
      ["Xwidget Webkit Mode" xwidget-webkit-mode :style toggle :selected xwidget-webkit-mode :help "Xwidget webkit view mode"])))
