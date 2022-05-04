;;; mitch-theme.el --- set visual theme in the only unique way

;;; Commentary:
;; When I first started using `nvim', I copied my `nano' config
;; which was very cringe and basic.  And so I scoured the internet
;; for themes.  And discovered something truly disturbing:
;; Every single `nvim' and `emacs' theme looks exactly the same,
;; and they're all gray-on-gray cringe.  I prefer my cringe to really
;; pop rather than ooze before my eyes, so I somehow found the `nvim'
;; theme that gradually became this.
;; We require 'autothemer because it makes the face declaration so much
;; simpler.

;;; Code:
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
  (mitch-green   "ForestGreen")
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
  (whitespace-line (:background "#660000"))
  (line-number (:inherit 'fixed-pitch :foreground mitch-light-black :weight
			 'normal))
  (line-number-current-line (:inherit 'line-number :foreground mitch-yellow
				      :weight 'bold))
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
  (isearch (:foreground mitch-dark-yellow :background mitch-light-magenta
			:weight 'bold))
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

(provide-theme 'mitch)
;;; mitch-theme.el ends here
