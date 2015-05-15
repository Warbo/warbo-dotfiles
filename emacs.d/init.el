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
(defvar current-user
      (getenv
       (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "Prelude is powering up... Be patient, Master %s!" current-user)

(when (version< emacs-version "24.1")
  (error "Prelude requires at least GNU Emacs 24.1"))

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
(defvar prelude-savefile-dir (expand-file-name "savefile" prelude-dir)
  "This folder stores all the automatically generated save/history-files.")
(defvar prelude-modules-file (expand-file-name "prelude-modules.el" prelude-dir)
  "This files contains a list of modules that will be loaded by Prelude.")

(unless (file-exists-p prelude-savefile-dir)
  (make-directory prelude-savefile-dir))

(defun prelude-add-subfolders-to-load-path (parent-dir)
 "Add all level PARENT-DIR subdirs to the `load-path'."
 (dolist (f (directory-files parent-dir))
   (let ((name (expand-file-name f parent-dir)))
     (when (and (file-directory-p name)
		(not (equal f ".."))
		(not (equal f ".")))
       (add-to-list 'load-path name)
       (prelude-add-subfolders-to-load-path name)))))

;; add Prelude's directories to Emacs's `load-path'
(add-to-list 'load-path prelude-core-dir)
(add-to-list 'load-path prelude-modules-dir)
(add-to-list 'load-path prelude-vendor-dir)
(prelude-add-subfolders-to-load-path prelude-vendor-dir)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

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

(message "Prelude is ready to do thy bidding, Master %s!" current-user)

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
  (gnus-group-list-all-groups 5))
(add-hook 'gnus-group-mode-hook
	  ;; List all the subscribed groups even they contain zero un-read
	  ;; messages
	  (lambda () (local-set-key "o" 'my-gnus-group-list-subscribed-groups)))

;; Make Gnus NOT ignore [Gmail]/... mailboxes
(setq gnus-ignored-newsgroups "")

;; Posting styles, to make Gnus behave differently for each account
(setq mail-signature nil)
(setq gnus-parameters
      '(("home:.*"
	 (posting-style
	  (address "chriswarbo@gmail.com")
	  (name "Chris Warburton")
	  (body "\n\nCheers,\nChris")
	  (eval (setq message-sendmail-extra-arguments '("-a" "gmail" "--read-envelope-from" "--read-recipients")))
	  (user-mail-address "chriswarbo@gmail.com")))
	("dd:.*"
	 (posting-style
	  (address "cmwarburton@dundee.ac.uk")
	  (body "\n\nRegards,\nChris")
	  (eval (setq message-sendmail-extra-arguments '("-a" "dd" "--read-envelope-from" "--read-recipients")))
	  (user-mail-address "cmwarburton@dundee.ac.uk")))))

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

;; Ignore updates to already-read articles
(setq nnrss-ignore-article-fields '(slash:comments dc:date pubDate))

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

;; Set the default browser to Debian's default.
;; W3M and Conkeror are good choices.
;(setq browse-url-browser-function 'w3m-browse-url)
;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror")

;; Load GEBEN for debugging PHP via Xdebug
(autoload 'geben "geben" "PHP Debugger on Emacs" t)

;; Set some repositories for the package manager
(setq package-archives '(("gnu"       . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa"     . "http://melpa.milkbox.net/packages/")
			 ))

;; Resize windows with Shift-Control-Arrow-Cursor
(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)

;; Turn off pesky scrollbars
(scroll-bar-mode -1)

;; When TRAMP connections die, auto-save can hang
(setq auto-save-default t)

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
  (let ((buf (concat "*eshell-" (number-to-string sh-counter) "*")))
    (command-execute 'eshell)
    (rename-buffer buf)
    buf))

(setq bash-counter 1)
(defun bash ()
  "Start a bash shell"
  (interactive)
  (setq bash-counter (+ bash-counter 1))
  (let
      ((explicit-shell-file-name "bash"))
    (shell (concat "*shell-" (number-to-string bash-counter) "*"))
    ))

;; "Refresh" an SSH shell after a connection dies
(defun refresh-terminal ()
  "Start a new shell, like the current"
  (interactive)
  (let ((buf-name (buffer-name)))
	(progn (command-execute 'bash)
	       (kill-buffer buf-name)
	       (rename-buffer buf-name))))

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

;; Proof General
(ignore-errors (load-file "~/.nix-profile/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el"))

(defun eshell/emacs (file)
  "Running 'emacs' in eshell should open a new buffer"
  (find-file file))

(defun eshell-in (dir)
  "Launch a new eshell in the given directory"
  (let ((buffer (sh)))
    (with-current-buffer buffer
      (eshell/cd dir)
      (eshell-send-input))
    buffer))

(defun eshell-named-in (namedir)
  "Launch a new eshell with the given buffer name in the given directory"
  (let* ((name   (car namedir))
	 (dir    (eval (cadr namedir))))
    (unless (get-buffer name)
      (with-current-buffer (eshell-in dir)
	(rename-buffer name)))
    name))

(defun push-keys (keys)
  "Takes a string describing keypresses and pushes them to the input queue"
  (setq unread-command-events
	(append (listify-key-sequence (kbd keys))
		unread-command-events)))

(defun shell-in (dir)
  "Launch a new shell in the given directory"
  (let ((buffer (bash)))
    (with-current-buffer buffer
      (interactive)
      (insert "cd " dir)
      (push-keys "RET"))
    buffer))

(defun shell-named-in (namedir)
  "Launch a new shell with the given buffer name in the given directory"
  (let* ((name (car namedir))
	 (dir  (eval (cadr namedir))))
    (unless (get-buffer name)
      (with-current-buffer (shell-in dir)
	(rename-buffer name)))
    name))

(defun shell-from-buf (buf)
  "Switch to the given buffer then open a shell.
   Useful for piggybacking on TRAMP."
  (with-current-buffer buf
    (bash)))

(defun shell-with-name-from-buf (namebuf)
  "Switch to a given buffer, open a shell and rename it."
  (let* ((name (car namebuf))
	 (buf  (eval (cadr namebuf))))
    (unless (get-buffer name)
      (with-current-buffer (shell-from-buf buf)
	(rename-buffer name)))
    name))

(defun run-in-buf (buffunc)
  "Call a function in a buffer"
  (let* ((buf  (car buffunc))
	 (func (cadr buffunc)))
    (if (get-buffer buf)
	(with-current-buffer buf (eval func)))))

(defun startup-eshells ()
  "Useful buffers to open at startup"
  (let* (; Some useful shorthand
	(c     'concat)
	(ssh   (lambda (user) (funcall c "/ssh:" user "@")))
	(wdc    "wandisco.com")
	(live   (concat wdc ":/"))
	(dev   (lambda (name) (concat name ".wdev." wdc)))
	(path  (lambda (prefix) (concat prefix ":/")))

	(domains  "var/www/domains/")
	(store    (concat domains "wandisco.com/drupal7/htdocs/"))
	(logs     "var/log/apache2/")
	(www-data "/sudo:www-data@localhost:/")
	(ubuntu   (funcall ssh "ubuntu"))
	(root     (funcall ssh "root"))
	(admin    (funcall ssh "adminwdcom"))
	(stage    "webstage.wandisco.com:/")
	(ci       (funcall dev "webs-ci"))
	(cw       (funcall dev "chrisw"))
	(ci-box   (funcall path ci))
	(cw-box   (funcall path cw))
	(disco    (funcall path "disco.wandisco.com")))

	;; Open an eshell for each user on each server
	(mapcar 'eshell-named-in
	   '(("home"        "~")
	     ("results"     "~")
	     ("debian"      "~/codebase/webs-store/drupal7_22/htdocs")
	     ("discodev"    "~/codebase/discodev/htdocs/")
	     ("www-data"    (concat www-data      store))
	     ("stage"       (concat admin  stage  store))
	     ;("live"        (concat root   live   store))
	     ("ci"          (concat root   ci-box domains))
	     ("cw"          (concat root   cw-box store))
	     ("logs"        (concat "/sudo::/"    logs))
	     ;("logs-live"   (concat root   live   logs))
	     ("logs-stage"  (concat ubuntu stage  logs))
	     ("disco"       (concat root   disco  domains))
	     ("stage-disco" (concat root   disco  domains))))))

(defun startup-shells ()
  "Use our eshells' TRAMP connections to launch some shells"
  (mapcar 'shell-with-name-from-buf
	  '(("store-tester" "home")
	    ("admin@stage"  "stage")
	    ("root@cw"      "cw")
	    ("chris@debian" "debian")

	    ; We use -init to indicate that extra work is needed
	    ("apache@cw-init"   "cw")
	    ;("admin@live-init"  "live")
	    ("root@stage-init"   "stage"))))

(defun initialise-startup-shells ()
  "Run some initialisation commands"
  (let* ((enter (push-keys "RET"))
	 (su    (lambda (&optional user)
		  ((input (c "sudo -u " (or user root) " bash"))
		   (enter))))
	 (run-init (lambda (buffunc)
		     (let* ((buf  (car buffunc))
			    (func (cadr buffunc)))
		       ())
    (mapcar 'run-in-buf
	    '(("admin@live-init"  '(su "adminwdcom"))
	      ("root@stage-init"  '(su))
	      ("admin@stage-init" '(su "adminwdcom"))
	      ("apache@cw-init"   '(su "apache")))))))))

(defun indent-and-align ()
  "Prettier indentation. Tries to align code nicely automatically."
  (message "HELLO"))

(add-hook 'c-special-indent-hook 'indent-and-align)

;; Don't run Flymake over TRAMP
(if (boundp 'flymake-allowed-file-name-masks)
    (setq flymake-allowed-file-name-masks
	  (cons '("^/ssh:" (lambda () nil))
		flymake-allowed-file-name-masks)))

;; PHP lint
;; (require 'php-mode)
;; (require 'flymake)

;; (defun flymake-php-init ()
;;   "Use php to check the syntax of the current file."
;;   (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
;; 	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
;;     (list "php" (list "-f" local "-l"))))

;; (add-to-list 'flymake-err-line-patterns
;;   '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

;; (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

;; Drupal-type extensions
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.module$" flymake-php-init))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.install$" flymake-php-init))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.inc$" flymake-php-init))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.engine$" flymake-php-init))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.test$" flymake-php-init))

;; (add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
;; (define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
;; (define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)

;; active Babel languages
(org-babel-do-load-languages 'org-babel-load-languages '((haskell    . t)
                                                         (sh         . t)
                                                         (gnuplot    . t)
                                                         (dot        . t)))

(setq org-confirm-babel-evaluate nil)

(setq org-src-fontify-natively t)

;; Syntax highlighting for Dash
(eval-after-load "dash" '(dash-enable-font-lock))

;; Unit testing for ELisp
(require 'ert)
(defun ert-silently ()
  (interactive)
  (ert t))
(define-key emacs-lisp-mode-map       (kbd "C-x r") 'ert-silently)
(define-key lisp-interaction-mode-map (kbd "C-x r") 'ert-silently)

;; Make doc-view continuous
(setq doc-view-continuous t)

;; f5 to save-and-export in Org mode
(defun org-export-as-pdf ()
  (interactive)
  (save-buffer)
  (org-latex-export-to-pdf))

(defun org-export-and-preview ()
  (interactive)
  (let* ((pdf (replace-regexp-in-string "\.org$" ".pdf" (buffer-name)))
         (buf (get-buffer pdf)))
    (when buf (with-current-buffer buf (auto-revert-mode 1)))
    (org-export-as-pdf)
    (unless buf (find-file pdf))))

(add-hook
 'org-mode-hook
 (lambda ()
   (define-key org-mode-map
     (kbd "<f5>") 'org-export-and-preview)))

;; Visual line wrapping in Org mode
(add-hook
 'org-mode-hook
 'turn-on-visual-line-mode)

(add-hook
 'org-mode-hook
 (lambda ()
   (whitespace-mode 0)
   (setq-local whitespace-style (remove-if (lambda (x)
                                             (member x (list 'lines-tail
                                                             'lines)))
                                           whitespace-style))
   (whitespace-mode 1)))

;; Render markdown to PDF
(defun md2pdf ()
  (interactive)
  (let* ((md  (buffer-name))
         (pdf (replace-regexp-in-string "\.md$" ".pdf" md))
         (buf (get-buffer pdf)))
    (when buf (with-current-buffer buf (auto-revert-mode 1)))
    (save-buffer)
    (async-shell-command (concat "pandoc --bibliography=/home/chris/Documents/ArchivedPapers/Bibtex.bib --filter panpipe --filter panhandle "
                                 md
                                 " -o " pdf))
    (unless buf (find-file pdf))))

(add-hook
 'markdown-mode-hook
 (lambda ()
   (define-key markdown-mode-map
     (kbd "<f5>") 'md2pdf)))

(add-hook
 'markdown-mode-hook
 'turn-on-visual-line-mode)
