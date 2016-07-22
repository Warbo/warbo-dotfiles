;; Dummy primary so that our real accounts are all equal (second-class) citizens
(setq gnus-select-method '(nnnil ""))

;; Incoming mail via IMAP
(setq gnus-secondary-select-methods
      '((nnmaildir "home"   (directory "~/Mail/gmail"))
        (nnmaildir "dd"     (directory "~/Mail/dundee"))
        (nnmaildir "feeds"  (directory "~/.imm-feeds")
                            (directory-files nnheader-directory-files-safe))))

;; Outgoing mail via SMTP

;; This is needed to allow msmtp to do its magic:
(setq message-sendmail-f-is-evil 't)

(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program
      "~/.nix-profile/bin/msmtp")

(setq message-sendmail-extra-arguments '("--read-envelope-from"
                                         "--read-recipients"))

;; Use plaintext when available
(eval-after-load "mm-decode"
                 '(progn (add-to-list 'mm-discouraged-alternatives
                                      "text/html")
                         (add-to-list 'mm-discouraged-alternatives
                                      "text/richtext")))
