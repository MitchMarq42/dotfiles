(require 'autothemer)

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

(defface yascroll:thumb-text-area
  '((t (:background "#00aa00")))
  "Face for text-area scroll bar thumb."
  :group 'yascroll)
(defface yascroll:thumb-fringe
  '((t (:background "#00aa00" :foreground "#00aa00")))
  "Face for fringe scroll bar thumb."
  :group 'yascroll)

(setq rainbow-delimiters-max-face-count 2)

(autothemer-deftheme
 mitch "Based on my nvim theme. Because everything else looks the same."

 ;; Specify the color classes used by the theme
 ((
   ((class color) (min-colors #xFFFFFF)) ;; truecolor
   ((class color) (min-colors #xFF    )) ;; 256color
   ((class color) (min-colors 16 )) ;; 16color
   ((class color) (min-colors 8 )) ;; 8color
   )

  ;; Specify the color palette for each of the classes above.
  (mitch-black   "#000000" "black" )
  (mitch-red     "#ff0000" "red" )
  (mitch-green   "#00aa00" "green" "green")
  (mitch-yellow  "#ffee11" "#ffee11" "yellow" )
  (mitch-blue    "#0000ff" "blue" )
  (mitch-magenta "#ff00ff")
  (mitch-cyan    "#00ffff")
  (mitch-white   "#ffffff")
  (mitch-pink    "#ffaaaa")
  (mitch-light-black   "#303030" "darkgray" )
  (mitch-light-red     "#ffa000")
  (mitch-light-green   "#00c000")
  (mitch-light-yellow  "#eeee99" "#eeee99" "lightyellow")
  (mitch-light-blue    "#0077ff")
  (mitch-light-magenta "#9f00aa")
  (mitch-light-cyan    "#00c0c0")
  (mitch-light-white   "#afafaf")
  (mitch-visual-bg     "#3f0090")
  (mitch-dark-gray     "#101010")
  )

 ;; specifications for Emacs faces.
 (
  (default (:background mitch-black :foreground mitch-light-yellow))
  (cursor (:inherit 'default))
  (highlight (:background mitch-visual-bg))
  (region (:inherit 'highlight))
  (line-number (:foreground mitch-light-black :weight 'normal))
  (line-number-current-line (:foreground mitch-yellow :weight 'bold))
  (linum (:inherit 'line-number))
  (linum-relative-current-face (:inherit 'line-number-current-line))
  ;; font-lock faces. The defaults that are important to get right.
  (font-lock-comment-face (:foreground mitch-green :slant 'italic))
  (font-lock-comment-delimiter-face (:foreground mitch-light-black))
  (font-lock-constant-face (:foreground mitch-light-cyan :weight 'bold))
  (font-lock-string-face (:foreground mitch-light-blue :slant 'italic))
  (font-lock-builtin-face (:foreground mitch-light-white :weight 'bold))
  (font-lock-keyword-face (:foreground mitch-red :weight 'bold))
  (font-lock-type-face (:foreground mitch-blue :weight 'normal))
  (font-lock-function-name-face (:foreground mitch-red :weight 'normal))
  (font-lock-variable-name-face (:foreground mitch-white :weight 'normal))
  (font-lock-negation-char-face (:foreground mitch-visual-bg :weight 'bold))
  (transient-heading (:foreground mitch-magenta :weight 'bold))
  (rainbow-delimiters-depth-1-face (:foreground mitch-light-magenta))
  (rainbow-delimiters-depth-2-face (:foreground mitch-magenta :weight 'normal))
  (vertical-border (:foreground mitch-magenta :weight 'bold))
  (fringe (:inherit 'default))
  (show-paren-match (:foreground mitch-black :background mitch-light-magenta))
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (org-block (:inherit '(font-lock-comment-delimiter-face fixed-pitch)))
  (org-block-begin-line (:foreground mitch-light-black))
  (org-block-end-line (:foreground mitch-light-black))
  (org-table   (:inherit '(font-lock-constant-face fixed-pitch)))
  (org-formula (:inherit 'fixed-pitch))
  (org-code    (:inherit '(shadow fixed-pitch)))
  (org-verbatim (:inherit '(shadow fixed-pitch)))
  (org-special-keyword (:inherit '(font-lock-comment-face fixed-pitch)))
  (org-meta-line (:inherit '(font-lock-comment-face fixed-pitch)))
  (org-checkbox  (:inherit 'org-table))
  )
 )

;; Slightly prettier org-headings
(setq org-hide-leading-stars t)

(tooltip-mode -1)
(menu-bar-mode -1)
(setq window-divider-default-places t)
(setq right-divider-width 5)
(setq ring-bell-function 'ignore)
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
