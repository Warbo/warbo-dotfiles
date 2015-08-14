;; xbindkeys uses Guile, so this configuration file is written in Scheme

;; Key bindings have two forms:
;; Scheme functions: (xbindkey-function '(event-id) my-function)
;; Shell commands:   (xbindkey          '(event-id) "my-command")
;; You can get event IDs using "xbindkeys -k"

;; Audio buttons
(xbindkey "XF86AudioRaiseVolume" "amixer sset Master 1+")
(xbindkey "XF86AudioLowerVolume" "amixer sset Master 1-")
(xbindkey-function
  "XF86AudioMute"
  (let ((muted #f)
        (cmd   (lambda (chan prefix)
                       (run-command (string-concatenate) '("amixer sset "
                                                           chan
                                                           " "
                                                           prefix
                                                           "mute")))))
       (lambda ()
               (cmd "Master" (if muted "un" ""))
               (set! muted (not muted))

               ;; amixer always mutes Headphone too, so unmute it
               (cmd "Headphone" "un"))))

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
