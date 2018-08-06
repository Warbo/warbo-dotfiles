;; xbindkeys uses Guile, so this configuration file is written in Scheme

;; Key bindings have two forms:
;; Scheme functions: (xbindkey-function '(event-id) my-function)
;; Shell commands:   (xbindkey          '(event-id) "my-command")
;; You can get event IDs using "xbindkeys -k"

;; Desktop switching
(xbindkey "XF86Launch5" "xdotool key super+1")
(xbindkey "XF86Launch6" "xdotool key super+2")
(xbindkey "XF86Launch7" "xdotool key super+3")
(xbindkey "XF86Launch8" "xdotool key super+4")
(xbindkey "XF86Launch9" "xdotool key super+5")

;; Screen switching
(xbindkey "XF86Forward" "xdotool key super+Right")
(xbindkey "XF86Back"    "xdotool key super+Left")

;; Command hotkeys
(xbindkey "XF86Calculator" "run_tests")
(xbindkey "Menu"           "inv")
