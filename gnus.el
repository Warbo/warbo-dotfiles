;; Incoming mail via IMAP

; Set the default select method to WANdisco
(setq gnus-select-method '(nnimap "wandisco"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)
                                  (nnimap-authinfo-file "~/.authinfo")))

(setq gnus-secondary-select-methods
      ;; My GMail
      '((nnimap "gmail"
                (nnimap-address "imap.gmail.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl)
                (nnimap-authinfo-file "~/.authinfo"))))

;; SMTP
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp")
(setq message-sendmail-extra-arguments '("-a" "gmail"))

;; Use plaintext when available
(eval-after-load "mm-decode"
                 '(progn (add-to-list 'mm-discouraged-alternatives
                                      "text/html")
                         (add-to-list 'mm-discouraged-alternatives
                                      "text/richtext")))
