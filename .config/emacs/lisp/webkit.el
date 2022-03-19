;; webkit.el
;;
;; This file is barely a thing.
;; It was taken from https://raw.githubusercontent.com/emacksnotes/emacsnotes.wordpress.com/master/my-xwidget-menu.el
;; as a simple and painless way to embed webkit into an emacs window,
;; ideally for use in something...


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

(provide 'webkit)
