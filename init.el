;;; -*- coding: utf-8 -*-
;;; init.el --- My init file
;;; Commentary: see https://github.com/fgeller/emacs-init
;;; Code:
;;;

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *spell-check-support-enabled* nil)
(setq *macbook-pro-support-enabled* t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

(setq inhibit-startup-message t)  ;; Permet de ne pas afficher le message de startup

;; Load modules in my-libraries
(defvar my-libraries-dir (expand-file-name (concat user-emacs-directory "my-libraries/")))
(add-to-list 'load-path my-libraries-dir)
;; Compile the files and create the autoload file if not exists
(if
	(not (file-exists-p (concat my-libraries-dir "my-libraries-loaddefs.el")))
	(let ((default-directory user-emacs-directory))
	  (progn
		(message "Updating my-libraries...")
		(call-process "make"))))
(require 'my-libraries-loaddefs)
;;	(shell-command "make" nil nil))

(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "init")))
;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
(require 'init-elpa)
(require 'init-exec-path) ;; Set up $PATH
(require 'init-frame-hooks)

(require 'init-ibuffer)
(require 'init-ido)
(require 'init-recentf)

;; Customize Plus
(require 'cus-edit+)
(customize-toggle-outside-change-updates 99)

;;;;;;;;;;
;; Buffers
(defun switch-to-previous-buffer()
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer) 1)))

;;;;;;;;;;;
;; Encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;;;;;;;;;;;;
;; Popwin
(require 'popwin)
(popwin-mode t)
(delete 'help-mode popwin:special-display-config)
;;(push '(help-mode :width 62 :position right)
;;	  popwin:special-display-config)
(global-set-key "\C-ci" 'import-popwin)

;;;;;;;;;;;;;;;;
;; Auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;;;;;;;;;;
;; Shell

;; Add a new face
(defface sh-variable-used
  '((((class color) (background dark))
     (:foreground "violet"))
    (((class color) (background light))
     (:foreground "violet")))
  "Face to show use of variable like $var or ${var}")
;;; GNU emacs font-lock needs these...
(defvar sh-variable-used-face 'sh-variable-used)

(font-lock-add-keywords
 'sh-mode
 '(; fontify variable use
   ("[$][{]?\\([A-Za-z_][A-Za-z0-9_]*\\)[}]?" 1 sh-variable-used-face t)))

;;(add-hook 'sh-mode-hook '(lambda () (message "hello")))

;;;;;;;;;;
;; Perl
;(autoload 'perltidy "perltidy-mode" nil t)
;(autoload 'perltidy-mode "perltidy-mode" nil t)
(eval-after-load "perl-mode"
  '(define-key perl-mode-map "\C-ct" 'perltidy-dwim-safe))
;(eval-after-load "cperl-mode"
;  '(progn (add-hook 'cperl-mode-hook 'perltidy-mode)
;		  (define-key cperl-mode-map "\C-ct" 'perltidy)))

;; perlcritic
(autoload 'perlcritic        "perlcritic" "" t)
(autoload 'perlcritic-region "perlcritic" "" t)
(autoload 'perlcritic-mode   "perlcritic" "" t)

;;;;;;;;;;;;;;
;; Javascript
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)) ; use js2-mode
(setq js2-strict-missing-semi-warning nil)				; don't warn in case of missing semicolon
(add-hook 'js2-mode-hook 'ac-js2-mode)					; enable ac-js2 (autocomplete for js2)

;;;;;;;;;;;;
;; FlyCheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; lisp (disable emacs-lisp-checkdoc)
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(require 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)
;; popwin
(push '("\*Flycheck checkers\*" :regexp t :position right :width 56 :dedicated t)
	  popwin:special-display-config)
;; keymap
(global-set-key "\C-c!t" 'flycheck-mode)
(defun force-flycheck-mode()
  (when (not flycheck-mode)
	(flycheck-mode 1)))

(global-set-key "\M-p" '(lambda()
						  (interactive)
						  (progn (force-flycheck-mode)
								 (flycheck-previous-error))))
(global-set-key "\M-n" '(lambda()
						  (interactive)
						  (progn (force-flycheck-mode)
								 (flycheck-next-error))))

;;;;;;;;;;;;
;; GO
(require 'go-mode)
(add-hook 'before-save-hook #'gofmt-before-save)
;;(require 'golint)
(define-key go-mode-map (kbd "C-c j") 'go-direx-pop-to-buffer)
(push '("^\*go-direx:" :regexp t :position right :width 0.4 :dedicated t)
	  popwin:special-display-config)

;;;;;;;;;;;;;;;;;;;;;;;
;; Unix <-> Dos
;;
(defun dos-unix ()
  "Convert buffer from DOS to Unix."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun unix-dos ()
  "Convert buffer from Unix to DOS."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autoinsert
;;
(require 'autoinsert)
(add-hook 'find-file-hooks 'auto-insert)

;;;;;;;;;;;;;;;;;;;;;;;
;; indentation
;;
;; Agressive Indent Mode (https://github.com/Malabarba/aggressive-indent-mode)
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
(add-to-list
 'aggressive-indent-dont-indent-if
 '(and (or (derived-mode-p 'c-mode)
	   (derived-mode-p 'c++-mode))
       (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
			   (thing-at-point 'line)))))

;; dtrt-indent-mode (https://github.com/jscheid/dtrt-indent)
(dtrt-indent-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Whitespace
(global-set-key "\C-cw" 'whitespace-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mouse Avoidance
(mouse-avoidance-mode 'animate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Desktop Settings
(desktop-save-mode nil)

;;;;;;;;;;;;;;;;;;;;;;
;; Custom Key Bindings
(global-set-key (kbd "<C-tab>") 'switch-to-previous-buffer)

(global-set-key (kbd "<f5>") 'font-lock-fontify-buffer)

;; undo
(require 'redo+)
(global-set-key (kbd "<f12>") 'undo)
(global-set-key (kbd "<f15>") 'undo)
(global-set-key (kbd "<pause>") 'undo)
(global-set-key (kbd "<C-f12>") 'redo)
(global-set-key (kbd "<C-f15>") 'redo)
(global-set-key (kbd "<C-pause>") 'redo)

(global-set-key (kbd "<mouse-8>") 'mouse-yank-primary)
(global-set-key (kbd "<M-mouse-8>") 'mouse-yank-secondary)
(global-set-key (kbd "<C-down-mouse-8>") 'facemenu-menu)
(global-set-key [vertical-line C-mouse-8] 'mouse-split-window-vertically)
(global-set-key [vertical-scroll-bar C-mouse-8] 'mouse-split-window-vertically)
(global-set-key [mode-line C-mouse-8] 'mouse-split-window-horizontally)
(global-set-key [mode-line mouse-8] 'mouse-delete-other-windows)

;; Ouverture du buffer *scratch*
(global-set-key
 (kbd "<C-insert>")
 '(lambda ()
	(interactive)
	(split-window)
	(switch-to-buffer "*scratch*")))

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))

;;;;;;;;;;;;;;;;;
;; Customizations
(load (concat user-emacs-directory "custom-default.el"))
(setq custom-file (concat user-emacs-directory "custom-" (user-login-name) ".el"))
(load custom-file)

(provide 'init)
;;; init.el ends here
