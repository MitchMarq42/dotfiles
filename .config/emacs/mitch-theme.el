(require 'autothemer)

(autothemer-deftheme
 mitch "Based on my nvim theme. Because everything else looks the same."

 ;; Specify the color classes used by the theme
 (
  (
   ((class color) (min-colors #xFFFFFF)) ;; truecolor
   ((class color) (min-colors #xFF    )) ;; 256color
   ((class color) (min-colors 16color )) ;; 16color
   )

  ;; Specify the color palette for each of the classes above.
  (mitch-black   "#000000")
  (mitch-red     "#ff0000")
  (mitch-green   "#00aa00")
  (mitch-yellow  "#ffee11")
  (mitch-blue    "#0000ff")
  (mitch-magenta "#ff00ff")
  (mitch-cyan    "#00ffff")
  (mitch-white   "#ffffff")
  (mitch-light-black   "#303030")
  (mitch-light-red     "#ffa000")
  (mitch-light-green   "#00c000")
  (mitch-light-yellow  "#eeee99")
  (mitch-light-blue    "#0077ff")
  (mitch-light-magenta "#9f00aa")
  (mitch-light-cyan    "#00c0c0")
  (mitch-light-white   "#afafaf")
  (mitch-visual-bg     "#3f0090")
  (mitch-dark-gray     "#101010")
  )

 ;; specifications for Emacs faces.
 (
  (default                (:background mitch-black :foreground mitch-light-yellow))
  (highlight              (:background mitch-visual-bg))
  (font-lock-comment-face (:foreground mitch-green))
  (mode-line     (:background mitch-light-black :foreground mitch-white :weight 'bold))
  (line-number            (:foreground mitch-yellow :weight 'normal))
  (line-number-current-line (:foreground mitch-yellow :weight 'bold))
  (font-lock-function-name-face (:foreground mitch-red :weight 'bold))
  (font-lock-keyword-face (:foreground mitch-red :weight 'bold))
  (font-lock-constant-face (:foreground mitch-light-cyan))
  (font-lock-string-face (:foreground mitch-light-blue))
  (font-lock-builtin-face (:foreground mitch-light-white :weight 'bold))
  (rainbow-delimiters-depth-1-face (:foreground mitch-light-magenta))
  (rainbow-delimiters-depth-2-face (:foreground mitch-magenta :weight 'normal))
  (rainbow-delimiters-depth-3-face (:foreground mitch-light-magenta))
  (rainbow-delimiters-depth-4-face (:foreground mitch-magenta :weight 'normal))
  (rainbow-delimiters-depth-5-face (:foreground mitch-light-magenta))
  (window-divider (:foreground mitch-light-magenta :weight 'bold))
  (window-divider-first-pixel (:foreground mitch-light-magenta :weight 'bold))
  (window-divider-last-pixel (:foreground mitch-light-magenta :weight 'bold))
  (yascroll:thumb-fringe (:foreground mitch-green :background mitch-green))
  (show-paren-match (:background mitch-light-cyan))
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (org-block nil   (:inherit 'fixed-pitch))
  (org-table nil   (:inherit 'fixed-pitch))
  (org-formula nil (:inherit 'fixed-pitch))
  (org-code nil    (:inherit '(shadow fixed-pitch)))
  (org-table nil   (:inherit '(shadow fixed-pitch)))
  (org-verbatim nil (:inherit '(shadow fixed-pitch)))
  (org-special-keyword nil (:inherit '(font-lock-comment-face fixed-pitch)))
  (org-meta-line nil (:inherit '(font-lock-comment-face fixed-pitch)))
  (org-checkbox nil  (:inherit 'fixed-pitch))
  )

 ;; Forms after the face specifications are evaluated.
 ;; (palette vars can be used.)
 (custom-theme-set-variables
  'mitch
  `(ansi-color-names-vector
    [,mitch-red
     ,mitch-green
     ,mitch-blue
     ,mitch-light-magenta
     ,mitch-yellow
     ,mitch-light-red
     ,mitch-cyan]))
 )

(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(setq window-divider-default-places t)
(setq right-divider-width 5)
(setq ring-bell-function 'ignore)
;; set font
(defvar mitchcustom/default-font-size 130)
(defvar mitchcustom/only-good-font "MesloLGS NF")
(set-face-attribute 'default nil
		    :font mitchcustom/only-good-font
		    :height mitchcustom/default-font-size)
(set-face-attribute 'fixed-pitch nil
		    :font mitchcustom/only-good-font
		    :height mitchcustom/default-font-size)
(set-face-attribute 'variable-pitch nil
		    :font "Ubuntu"
		    :height mitchcustom/default-font-size)

;; Set faces for heading levels
;; (dolist (face '((org-level-1 . 1.2)
;; 		(org-level-2 . 1.1)
;; 		(org-level-3 . 1.05)
;; 		(org-level-4 . 1.0)
;; 		(org-level-5 . 1.1)
;; 		(org-level-6 . 1.1)
;; 		(org-level-7 . 1.1)
;; 		(org-level-8 . 1.1)))
;;   (set-face-attribute (car face) nil :font "Ubuntu" :weight 'regular :height (cdr face)))


(provide-theme 'mitch)
