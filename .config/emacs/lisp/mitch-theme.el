(require 'autothemer)

;; set font
(defvar mitchcustom/default-font-size 130)
(defvar mitchcustom/only-good-font "MesloLGS NF")
(set-face-attribute 'default nil
		    :font mitchcustom/only-good-font
		    :height mitchcustom/default-font-size)
(set-face-attribute 'fixed-pitch nil
		    :inherit 'default
		    )
(set-face-attribute 'variable-pitch nil
		    :font "Ubuntu"
		    :height 200)

(defface yascroll:thumb-text-area
  '((t (:background "#00aa00")))
  "Face for text-area scroll bar thumb."
  :group 'yascroll)
(defface yascroll:thumb-fringe
  '((t (:background "#00aa00" :foreground "#00aa00")))
  "Face for fringe scroll bar thumb."
  :group 'yascroll)
(defface minimap-active-region-background
  '((t (:background "#303030" :extend t)))
  "portion of little window shown in big window")
(defface minimap-current-line-face
  '((t (:background "#afafaf" :extend t)))
  "current line in little window")

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
  (mitch-black   "black" )
  (mitch-red     "red" )
  (mitch-green   "SeaGreen3")
  (mitch-yellow  "gold1" )
  (mitch-blue    "blue" )
  (mitch-magenta "magenta")
  (mitch-cyan    "cyan")
  (mitch-white   "white")
  (mitch-pink    "pink2")
  (mitch-light-black   "grey19")
  (mitch-light-red     "orange")
  (mitch-light-green   "green3")
  (mitch-light-yellow  "PaleGoldenrod")
  (mitch-light-blue    "RoyalBlue")
  (mitch-light-magenta "DarkMagenta")
  (mitch-light-cyan    "turquoise3")
  (mitch-light-white   "grey69")
  (mitch-visual-bg     "DarkBlue")
  (mitch-dark-gray     "grey7")
  (mitch-dark-yellow   "DarkGoldenrod1")
  )

 ;; specifications for Emacs faces.
 (
  (default (:background mitch-black :foreground mitch-light-yellow))
  (cursor (:inherit 'default))
  (highlight (:background mitch-visual-bg))
  (region (:inherit 'highlight))
  (link (:foreground mitch-light-blue))
  (whitespace-line (:background "#880000"))
  (line-number (:inherit 'fixed-pitch :foreground mitch-light-black :weight 'normal))
  (line-number-current-line (:inherit 'line-number :foreground mitch-yellow :weight 'bold))
  (linum (:inherit 'line-number))
  (linum-relative-current-face (:inherit 'line-number-current-line))
  ;; font-lock faces. The defaults that are important to get right.
  (font-lock-comment-face (:foreground mitch-green :slant 'oblique))
  (font-lock-comment-delimiter-face (:foreground mitch-light-black))
  (font-lock-constant-face (:foreground mitch-light-white :weight 'normal))
  (font-lock-string-face (:foreground mitch-light-blue :slant 'italic))
  (font-lock-builtin-face (:foreground mitch-light-white :weight 'bold))
  (font-lock-keyword-face (:foreground mitch-red :weight 'bold))
  (font-lock-type-face (:foreground mitch-light-red :weight 'bold))
  (font-lock-function-name-face (:foreground mitch-red :weight 'normal))
  (font-lock-variable-name-face (:foreground mitch-light-cyan :weight 'normal))
  (font-lock-negation-char-face (:foreground mitch-visual-bg :weight 'bold))
  (transient-heading (:foreground mitch-magenta :weight 'bold))
  (rainbow-delimiters-depth-1-face (:foreground mitch-light-magenta))
  (rainbow-delimiters-depth-2-face (:foreground mitch-magenta :weight 'normal))
  (vertical-border (:foreground mitch-light-magenta :weight 'bold))
  (fringe (:inherit 'default))
  (show-paren-match (:foreground mitch-black :background mitch-light-magenta))
  (whitespace-space (:foreground mitch-black))
  (whitespace-tab (:foreground mitch-black))
  (whitespace-newline (:foreground mitch-black))
  (isearch (:foreground mitch-dark-yellow :background mitch-light-magenta :weight 'bold))
  (lazy-highlight (:inherit 'isearch))
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (org-block (:inherit 'fixed-pitch))
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
