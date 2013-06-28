;;; init.el --- Prelude's configuration entry point.
;;
;; Copyright (c) 2011 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: http://batsov.com/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file simply sets up the default load path and requires
;; the various modules defined within Emacs Prelude.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(message "Prelude is powering up... Be patient, Master %s!" (getenv "USER"))

(defvar prelude-dir (file-name-directory load-file-name)
  "The root dir of the Emacs Prelude distribution.")
(defvar prelude-core-dir (expand-file-name "core" prelude-dir)
  "The home of Prelude's core functionality.")
(defvar prelude-modules-dir (expand-file-name  "modules" prelude-dir)
  "This directory houses all of the built-in Prelude modules.")
(defvar prelude-personal-dir (expand-file-name "personal" prelude-dir)
  "This directory is for your personal configuration.

Users of Emacs Prelude are encouraged to keep their personal configuration
changes in this directory.  All Emacs Lisp files there are loaded automatically
by Prelude.")
(defvar prelude-vendor-dir (expand-file-name "vendor" prelude-dir)
  "This directory houses packages that are not yet available in ELPA (or MELPA).")
(defvar prelude-snippets-dir (expand-file-name "snippets" prelude-dir)
  "This folder houses additional yasnippet bundles distributed with Prelude.")
(defvar prelude-personal-snippets-dir (expand-file-name "snippets" prelude-personal-dir)
  "This folder houses additional yasnippet bundles added by the users.")
(defvar prelude-savefile-dir (expand-file-name "savefile" prelude-dir)
  "This folder stores all the automatically generated save/history-files.")
(defvar prelude-modules-file (expand-file-name "prelude-modules.el" prelude-dir)
  "This files contains a list of modules that will be loaded by Prelude.")

(unless (file-exists-p prelude-savefile-dir)
  (make-directory prelude-savefile-dir))

(defun prelude-add-subfolders-to-load-path (parent-dir)
 "Add all first level PARENT-DIR subdirs to the `load-path'."
 (dolist (f (directory-files parent-dir))
   (let ((name (expand-file-name f parent-dir)))
     (when (and (file-directory-p name)
                (not (equal f ".."))
                (not (equal f ".")))
       (add-to-list 'load-path name)))))

;; add Prelude's directories to Emacs's `load-path'
(add-to-list 'load-path prelude-core-dir)
(add-to-list 'load-path prelude-modules-dir)
(add-to-list 'load-path prelude-vendor-dir)
(prelude-add-subfolders-to-load-path prelude-vendor-dir)

;; the core stuff
(require 'prelude-packages)
(require 'prelude-ui)
(require 'prelude-core)
(require 'prelude-mode)
(require 'prelude-editor)
(require 'prelude-global-keybindings)

;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'prelude-osx))

;; the modules
(when (file-exists-p prelude-modules-file)
  (load prelude-modules-file))

;; config changes made through the customize UI will be store here
(setq custom-file (expand-file-name "custom.el" prelude-personal-dir))

;; load the personal settings (this includes `custom-file')
(when (file-exists-p prelude-personal-dir)
  (message "Loading personal configuration files in %s..." prelude-personal-dir)
  (mapc 'load (directory-files prelude-personal-dir 't "^[^#].*el$")))

(message "Prelude is ready to do thy bidding, Master %s!" (getenv "USER"))

(prelude-eval-after-init
 ;; greet the use with some useful tip
 (run-at-time 5 nil 'prelude-tip-of-the-day))

;;; init.el ends here

;; ORG-mode stuff
;; Don't clobber windmove bindings (this must run before ORG loads)
;; "(add-hook 'org-shiftup-final-hook 'windmove-up)", etc. don't seem to work
;; Default disputed keys remap so that windowmove commands aren't overridden
(setq org-disputed-keys '(([(shift up)] . [(meta p)])
                          ([(shift down)] . [(meta n)])
                          ([(shift left)] . [(meta -)])
                          ([(shift right)] . [(meta +)])
                          ([(meta return)] . [(control meta return)])
                          ([(control shift right)] . [(meta shift +)])
                          ([(control shift left)] . [(meta shift -)])))
(setq org-replace-disputed-keys t)

;; Email
(require 'gnus)
(defun my-gnus-group-list-subscribed-groups ()
  "List all subscribed groups with or without un-read messages"
  (interactive)
  (gnus-group-list-all-groups 5)
  )
(add-hook 'gnus-group-mode-hook
          ;; List all the subscribed groups even they contain zero un-read
          ;; messages
          (lambda () (local-set-key "o" 'my-gnus-group-list-subscribed-groups)))

;; Make Gnus NOT ignore [Gmail]/... mailboxes
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;; Posting styles, to make Gnus behave differently for each account
(setq mail-signature nil)
(setq gnus-parameters
      ;; Work email
      '((".*wandisco.*"
         (posting-style
          (address "chris.warburton@wandisco.com")
          (name "Chris Warburton")
          (body "\n\nRegards,\n-- \nChris Warburton | Developer\n\nWANdisco // Non-Stop Data\n\ne. chris.warburton@wandisco.com")
          (eval (setq message-sendmail-extra-arguments '("-a" "wandisco")))
          (user-mail-address "chris.warburton@wandisco.com")))
        ;; Personal email
        (".*gmail.*"
         (posting-style
          (address "chriswarbo@gmail.com")
          (name "Chris Warburton")
          (body "\n\nCheers,\nChris")
          (eval (setq message-sendmail-extra-arguments '("-a" "gmail")))
          (user-mail-address "chriswarbo@gmail.com")))))

;; Discourage HTML emails
(eval-after-load "gnus-sum"
  '(add-to-list
    'gnus-newsgroup-variables
    '(mm-discouraged-alternatives
      . '("text/html" "image/.*"))))

;; Encourage HTML when reading RSS
(add-to-list
 'gnus-parameters
 '("\\`nnrss:" (mm-discouraged-alternatives nil)))

;; If an RSS feed is actually ATOM, convert it
(require 'mm-url)
(defadvice mm-url-insert (after DE-convert-atom-to-rss () )
  "Converts atom to RSS by calling xsltproc."
  (when (re-search-forward "xmlns=\"http://www.w3.org/.*/Atom\"" 
                           nil t)
    (message "Converting Atom to RSS... ")
    (goto-char (point-min))
    (call-process-region (point-min) (point-max) 
                         "xsltproc" 
                         t t nil 
                         (expand-file-name "~/atom2rss.xsl") "-")
    (goto-char (point-min))
    (message "Converting Atom to RSS... done")))
(ad-activate 'mm-url-insert)

;; XMPP details
(require 'jabber)
(setq jabber-account-list
      '(("chris.warburton@wandisco.com"
         (:network-server . "talk.google.com")
         (:connection-type . ssl))
        ("chriswarbo@gmail.com"
         (:network-server . "talk.google.com")
         (:connection-type . ssl))
        ("warbo@jabber.org"
         (:network-server . "jabber.org")
         (:connection-type . ssl))
        ("warbo-updates@jabber.org"
         (:network-server . "jabber.org")
         (:connection-type . ssl))))
;; Enable auto-away for Jabber
(add-hook 'jabber-post-connect-hook 'jabber-autoaway-start)
;; FIXME: Enable libnotify notifications for Jabber
(add-hook 'jabber-alert-message-hooks
          (lambda (from buf text proposed-alert)
                  (jabber-libnotify-message text
                                            ; Strip the resource off the sender
                                            (car (split-string from "/")))))

;; Swap cursor keys and C-p/C-n in EShell.
;; C-up/C-down still does history like Shell mode
(defun m-eshell-hook ()
; define control p, control n and the up/down arrow
  (define-key eshell-mode-map [(control p)]
                              'eshell-previous-matching-input-from-input)
  (define-key eshell-mode-map [(control n)]
                              'eshell-next-matching-input-from-input)

  (define-key eshell-mode-map [up] 'previous-line)
  (define-key eshell-mode-map [down] 'next-line)
)
(add-hook 'eshell-mode-hook 'm-eshell-hook)

;; Auto-complete should stop at the first ambiguity
(setq eshell-cmpl-cycle-completions nil)

;; Use ansi-term for these commands
(add-hook
 'eshell-first-time-mode-hook
  (lambda ()
          (setq eshell-visual-commands
                (append '("mutt"
                          "vim"
                          "screen"
                          "lftp"
                          "ipython"
                          "telnet"
                          "ssh"
                          "mysql")
                        eshell-visual-commands))))

;; Settings for W3M browser
(setq w3m-use-cookies t)                   ; Use cookies
(setq w3m-default-display-inline-images t) ; Show images

;; Use W3M by default
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; Identi.ca. Credentials are taken from ~/.netrc
(when (require 'netrc nil t)
  (autoload 'identica-mode "identica-mode" nil t)
  (let ((identica (netrc-machine (netrc-parse "~/.netrc") "identi.ca" t))) ; remove this `t' if you didn't specify a port
    (setq identica-password (netrc-get identica "password") ; if it's last, avoid doing C-M-x in public spaces at least ;-)
          identica-username (netrc-get identica "login"))))

;; Load GEBEN for debugging PHP via Xdebug
(autoload 'geben "geben" "PHP Debugger on Emacs" t)

;; Set some repositories for the package manager
(setq package-archives '(("gnu"       . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa"     . "http://melpa.milkbox.net/packages/")))

;; JIRA for issue tracking (not very useful TBH)
(require 'jira)

;; Resize windows with Shift-Control-Arrow-Cursor
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; Turn off pesky scrollbars
(scroll-bar-mode -1)

;; Allow sudo-over-ssh with TRAMP
;; FIXME: This is a bit picky at the moment. If I enable sudo-over-ssh for
;; staging-store.wandisco.com then it interferes with ssh as root to
;; wandisco.com :(
(set-default 'tramp-default-proxies-alist nil)
;;(add-to-list 'tramp-default-proxies-alist
;;             '(nil "\\`root\\'" "/ssh:chris.warburton@%h:"))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote "debian") nil nil))
;; (add-to-list 'tramp-default-proxies-alist
;;              '((regexp-quote "wandisco.com") nil nil))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote "staging-store.wandisco.com") "\\`root\\'" "/ssh:chris.warburton@%h:"))

;; When TRAMP connections die, auto-save can hang
(setq auto-save-default nil)

;; Turn off Prelude's auto-save-when-switching-buffer
(ad-unadvise 'switch-to-buffer)
(ad-unadvise 'other-window)
(ad-unadvise 'windmove-up)
(ad-unadvise 'windmove-down)
(ad-unadvise 'windmove-left)
(ad-unadvise 'windmove-right)

;; Auto-increment shell names. Get a new EShell with "M-x sh", get a new Shell
;; with "M-x bash"
(setq sh-counter 1)
(defun sh ()
  "Start a new EShell"
  (interactive)
  (setq sh-counter (+ sh-counter 1))
  (progn (command-execute 'eshell)
         (rename-buffer (concat "*eshell-"
                                (number-to-string sh-counter)
                                "*"))))
(setq bash-counter 1)
(defun bash ()
  "Start a bash shell"
  (interactive)
  (setq bash-counter (+ bash-counter 1))
  (let
      ((explicit-shell-file-name "/bin/bash"))
    (shell (concat "*shell-" (number-to-string bash-counter) "*"))
    ))

;; Make parentheses dimmer when editing LISP
(defface paren-face
  '((((class color) (background dark))
     (:foreground "grey30"))
    (((class color) (background light))
     (:foreground "grey30")))
  "Face used to dim parentheses.")
(add-hook 'emacs-lisp-mode-hook 
 	  (lambda ()
 	    (font-lock-add-keywords nil 
 				    '(("(\\|)" . 'paren-face)))))
(add-hook 'scheme-mode-hook
 	  (lambda ()
 	    (font-lock-add-keywords nil 
 				    '(("(\\|)" . 'paren-face)))))
