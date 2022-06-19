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

;; insane font stuff. Might be what breaks something.
;; (defun mitch/setup-main-fonts (default-height variable-pitch-height)
;;   "Set up default fonts.

;; Use DEFAULT-HEIGHT for default face and VARIABLE-PITCH-HEIGHT
;; for variable-pitch face."
;;   (set-face-attribute 'default nil
;; 		      :family "MesloLGS NF"
;; 		      :height default-height)
;;   (set-face-attribute 'variable-pitch nil
;; 		      :height variable-pitch-height
;; 		      :weight 'regular))
;; ;; Now I just have to call this function with the proper values for :height
;; ;; according to the screen size.
;; (when window-system
;;   (if (> (x-display-pixel-width) 1800)
;;       (mitch/setup-main-fonts 130 140)
;;     (mitch/setup-main-fonts 110 120)))

;; sane font stuff
(set-face-attribute 'fixed-pitch nil
		    :family "MesloLGS NF"
		    :height 130)
(set-face-attribute 'default nil
		    :family "MesloLGS NF"
		    :height 130)
(set-face-attribute 'variable-pitch nil
		    :height 140
		    :weight 'regular)

(setq rainbow-delimiters-max-face-count 2)
;; (setq org-fontify-quote-and-verse-blocks t)

;; Set transparent background; might break older emacsen
(add-to-list 'initial-frame-alist '(alpha-background . 50))
(add-to-list 'default-frame-alist '(alpha-background . 50))
(add-to-list 'default-frame-alist '(cursor-color . "white"))

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
  ;; (default (:background mitch-black :foreground mitch-light-yellow))
  ;; (fixed-pitch (:inherit 'default))
  (default (:background mitch-black :foreground mitch-white))
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
  ;; other things
  (transient-heading (:inherit 'default :foreground mitch-magenta :weight 'bold))
  (rainbow-delimiters-depth-1-face ('default :foreground mitch-light-magenta))
  (rainbow-delimiters-depth-2-face ('default :foreground mitch-magenta :weight 'normal))
  (vertical-border (:foreground mitch-light-magenta :weight 'bold))
  (fringe (:inherit 'default))
  (whitespace-space (:foreground mitch-black))
  (whitespace-tab (:foreground mitch-black))
  (whitespace-newline (:foreground mitch-black))
  (isearch (:foreground mitch-dark-yellow :background mitch-light-magenta :weight 'bold))
  (lazy-highlight (:inherit 'isearch))
  (completions-highlight (:background mitch-mid-violet))
  (corfu-default (:background mitch-mid-gray))
  (corfu-current (:inherit 'completions-highlight))
  (vterm-color-red (:foreground mitch-red :background mitch-light-red))
  (vterm-color-blue (:foreground mitch-blue :background mitch-light-blue))
  (vterm-color-cyan (:foreground mitch-cyan :background mitch-light-cyan))
  (vterm-color-black (:foreground mitch-black :background mitch-light-black))
  (vterm-color-green (:foreground mitch-green :background mitch-light-green))
  (vterm-color-white (:foreground mitch-white :background mitch-light-white))
  (vterm-color-yellow (:foreground mitch-yellow :background mitch-light-yellow))
  (vterm-color-magenta (:foreground mitch-magenta :background mitch-light-magenta))
  )
 )

(provide-theme 'mitch)
;;; mitch-theme.el ends here
