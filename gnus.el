;; Incoming mail via IMAP

; Set the default select method to gmail
;(setq gnus-select-method '(nnimap "gmail"
;                                  (nnimap-address "imap.gmail.com")
;                                  (nnimap-server-port 993)
;                                  (nnimap-stream ssl)
;                                  (nnimap-authinfo-file "~/.authinfo")))

(setq gnus-select-method '(nnimap "home"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)
                                  (nnimap-authinfo-file "~/.authinfo")))

(setq gnus-secondary-select-methods
      '((nnimap "dundee"
                (nnimap-address "outlook.office365.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl)
                (nnimap-authinfo-file "~/.authinfo"))

        (nnimap "dd"
                 (nnimap-address "outlook.office365.com")
                 (nnimaxsp-server-port 993)
                 (nnimap-stream ssl)
                 (nnimap-authinfo-file "~/.authinfo")
                 (nnimap-list-pattern ("INBOX" "*"))
                 (nnimap-expunge-on-close always)
                 (gnus-check-new-newsgroups nil)
                 (gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\”]\”[#’()]"))


))

;; SMTP
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program
      "/run/current-system/sw/bin/nix-shell -p msmtp --command msmtp")
(setq message-sendmail-extra-arguments '("-a" "gmail"
                                         "--read-envelope-from"
                                         "--read-recipients"))

;; Use plaintext when available
(eval-after-load "mm-decode"
                 '(progn (add-to-list 'mm-discouraged-alternatives
                                      "text/html")
                         (add-to-list 'mm-discouraged-alternatives
                                      "text/richtext")))
