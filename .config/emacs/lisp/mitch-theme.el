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

;; set font...
;; Taken from https://web.archive.org/web/20210622224446/https://www.manueluberti.eu/emacs/2017/02/26/dynamicfonts/
(defun mitch/setup-main-fonts (default-height variable-pitch-height)
  "Set up default fonts.

Use DEFAULT-HEIGHT for default face and VARIABLE-PITCH-HEIGHT
for variable-pitch face."
  (set-face-attribute 'default nil
		      :family "MesloLGS NF"
		      :height default-height)
  (set-face-attribute 'variable-pitch nil
		      ;; :family "Fira Sans"
		      :height variable-pitch-height
		      :weight 'regular))
;; Now I just have to call this function with the proper values for :height according to the screen size.
(when window-system
  (if (> (x-display-pixel-width) 1800)
      (mitch/setup-main-fonts 130 140)
    (mitch/setup-main-fonts 110 120)))

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
  (mitch-yellow  "gold1" "white")
  (mitch-blue    "blue" )
  (mitch-magenta "magenta")
  (mitch-cyan    "cyan")
  (mitch-white   "white")
  (mitch-pink    "pink2")
  (mitch-light-black   "grey19" "grey19" "gray")
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
  (mitch-dark-red      "DarkRed")
  (mitch-mid-gray      "grey33")
  (mitch-mid-violet    "BlueViolet")
  )

 ;; specifications for Emacs faces.
 (
  (default (:background mitch-black :foreground mitch-light-yellow))
  (fixed-pitch (:inherit 'default))
  (cursor (:inherit 'default))
  (highlight (:background mitch-visual-bg))
  (region (:inherit 'highlight))
  (link (:foreground mitch-light-blue :underline 't))
  (link-visited (:foreground mitch-mid-violet :underline 't))
  (whitespace-line (:background mitch-dark-red))
  (line-number (:inherit 'fixed-pitch :foreground mitch-light-black :weight 'normal))
  (line-number-current-line (:inherit 'line-number :foreground mitch-yellow :weight 'bold))
  (linum (:inherit 'line-number))
  (linum-relative-current-face (:inherit 'line-number-current-line))
  ;; font-lock faces. The defaults that are important to get right.
  (font-lock-comment-face (:inherit 'default :foreground mitch-green :slant 'oblique))
  (font-lock-comment-delimiter-face (:inherit 'default :foreground mitch-light-black))
  (font-lock-constant-face (:inherit 'default :foreground mitch-light-white :weight 'normal))
  (font-lock-string-face (:inherit 'default :foreground mitch-light-blue :slant 'italic))
  (font-lock-builtin-face (:inherit 'default :foreground mitch-light-white :weight 'bold))
  (font-lock-keyword-face (:inherit 'default :foreground mitch-red :weight 'bold))
  (font-lock-type-face (:inherit 'default :foreground mitch-light-red :weight 'bold))
  (font-lock-function-name-face (:inherit 'default :foreground mitch-red :weight 'normal))
  (font-lock-variable-name-face (:inherit 'default :foreground mitch-light-cyan :weight 'normal))
  (font-lock-negation-char-face (:inherit 'default :foreground mitch-visual-bg :weight 'bold))
  ;; other things
  (transient-heading (:inherit 'default :foreground mitch-magenta :weight 'bold))
  (rainbow-delimiters-depth-1-face (:inherit 'default :foreground mitch-light-magenta))
  (rainbow-delimiters-depth-2-face (:inherit 'default :foreground mitch-magenta :weight 'normal))
  (vertical-border (:inherit 'default :foreground mitch-light-magenta :weight 'bold))
  (fringe (:inherit 'default))
  (whitespace-space (:foreground mitch-black))
  (whitespace-tab (:foreground mitch-black))
  (whitespace-newline (:foreground mitch-black))
  (isearch (:inherit 'default :foreground mitch-dark-yellow :background mitch-light-magenta :weight 'bold))
  (lazy-highlight (:inherit 'isearch))
  (corfu-default (:background mitch-mid-gray))
  (corfu-current (:background mitch-mid-violet :foreground mitch-light-yellow))
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (org-block-begin-line (:inherit 'font-lock-comment-delimiter-face))
  (org-block-end-line (:inherit 'font-lock-comment-delimiter-face))
  (org-formula (:inherit 'default))
  (org-code (:inherit 'font-lock-constant-face))
  (org-table (:inherit 'org-code))
  (org-block (:inherit 'org-code))
  (org-verbatim (:inherit 'org-code))
  (org-special-keyword (:inherit '(font-lock-comment-face fixed-pitch)))
  (org-meta-line (:inherit 'font-lock-comment-face))
  (org-checkbox (:inherit 'org-table))
  ;; (org-level-1 (:inherit 'default :height 'mitch/font/heading-height :weight 'bold :foreground mitch-light-magenta))
  ;; (org-level-2 (:inherit 'org-level-1 :foreground "magenta3"))
  )
 )

(provide-theme 'mitch)
;;; mitch-theme.el ends here
