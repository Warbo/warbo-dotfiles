;; xbindkeys uses Guile, so this configuration file is written in Scheme

;; Key bindings have two forms:
;; Scheme functions: (xbindkey-function '(event-id) my-function)
;; Shell commands:   (xbindkey          '(event-id) "my-command")
;; You can get event IDs using "xbindkeys -k"

;; Command hotkeys
(xbindkey "Menu" "inv")

;; Audio buttons
(xbindkey "XF86AudioRaiseVolume" "amixer -c 0 sset Master 1+")
(xbindkey "XF86AudioLowerVolume" "amixer -c 0 sset Master 1-")
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
