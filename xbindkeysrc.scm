;; xbindkeys uses Guile, so this configuration file is written in Scheme

;; Key bindings have two forms:
;; Scheme functions: (xbindkey-function '(event-id) my-function)
;; Shell commands:   (xbindkey          '(event-id) "my-command")
;; You can get event IDs using "xbindkeys -k"

;; Command hotkeys
(xbindkey "Menu" "inv")
