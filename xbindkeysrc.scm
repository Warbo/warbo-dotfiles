;; xbindkeys uses Guile, so this configuration file is written in Scheme

;; Key bindings have two forms:
;; Scheme functions: (xbindkey-function '(event-id) my-function)
;; Shell commands:   (xbindkey          '(event-id) "my-command")
;; You can get event IDs using "xbindkeys -k"
(xbindkey "XF86AudioRaiseVolume" "amixer sset Master 1+")
(xbindkey "XF86AudioLowerVolume" "amixer sset Master 1-")
(define muted #t)
(define mute (lambda () ((run-command (if muted "amixer sset Master unmute"
                                           "amixer sset Master mute"))
                    (set-variable! muted (not muted))
                    (display (if muted "muted" "unmuted"))
                    (xbindkey-function "XF86AudioMute" mute))))

(xbindkey-function "XF86AudioMute"
                   (let ((muted #f))
                     (lambda ()
                        (run-command (if muted "amixer sset Master unmute"
                                               "amixer sset Master mute"))
                        (run-command "amixer sset Headphone unmute")
                        (set! muted (not muted))
                        (display (if muted "muted" "unmuted")))))
