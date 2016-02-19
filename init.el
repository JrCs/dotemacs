;;; -*- coding: utf-8 -*-
;;; init.el --- My init file
;;; Commentary: see https://github.com/fgeller/emacs-init
;;; Code:
;;;

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
	(error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

;; Add directories to load-path
(eval-and-compile
  (mapc #'(lambda (path)
			(add-to-list 'load-path (expand-file-name path user-emacs-directory)))
		'("init" "site-lisp")))

;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
(defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
		  (lambda () (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst enable-init-benchmarking t)

;;----------------------------------------------------------------------------
;; Enable init benchmarking ?
;;----------------------------------------------------------------------------
(if enable-init-benchmarking
	(progn
	  (require 'init-benchmarking) ;; Measure startup time
	  (add-hook 'after-init-hook
				(lambda ()
				  (message "init completed in %.2fms"
						   (sanityinc/time-subtract-millis after-init-time before-init-time))))))


;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
(require 'init-elpa)
(require 'init-utils)
(require 'init-exec-path) ;; Set up $PATH


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)


;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-frame-hooks)
(require 'init-ibuffer)
(require 'init-ido)
(require 'init-recentf)

(require 'init-search)
(require 'init-popwin)
(require 'init-autocomplete)

(require 'init-flycheck)
(require 'init-sh-mode)
(require 'init-perl-mode)
(require 'init-javascript)
(require 'init-go)
(require 'init-other-modes)

(require 'init-backup)
(require 'init-edition)
(require 'init-autoinsert)
(require 'init-indent)
(require 'init-tramp)

(require 'init-theme)
(require 'init-fonts)
(require 'init-modeline)
(require 'init-windows)
(require 'init-gui-frames)
(require 'init-session)


;;----------------------------------------------------------------------------
;; Misc
;;----------------------------------------------------------------------------
(defalias 'yes-or-no-p 'y-or-n-p) ;; y or n is enough


;; ;; Customize Plus
;; (require 'cus-edit+)
;; (customize-toggle-outside-change-updates 99)
;;

;;----------------------------------------------------------------------------
;; Whitespace mode
;;----------------------------------------------------------------------------
(global-set-key "\C-cw" 'whitespace-mode)


;;----------------------------------------------------------------------------
;; Mouse
;;----------------------------------------------------------------------------
(mouse-avoidance-mode 'animate)


;;----------------------------------------------------------------------------
;; Custom Key Bindings
;;----------------------------------------------------------------------------
(global-set-key (kbd "<C-tab>") 'switch-to-previous-buffer)

(global-set-key (kbd "<f5>") 'font-lock-fontify-buffer)

(bind-keys :prefix-map my-lisp-devel-map
		   :prefix "C-c e"
		   ("E" . elint-current-buffer)
		   ("b" . do-eval-buffer)
		   ("c" . cancel-debug-on-entry)
		   ("d" . debug-on-entry)
		   ("e" . toggle-debug-on-error)
		   ("f" . emacs-lisp-byte-compile-and-load)
		   ("j" . emacs-lisp-mode)
		   ("l" . find-library)
		   ("r" . do-eval-region)
		   ("s" . switch-to-scratch-buffer)
		   ("z" . byte-recompile-directory))

(when *is-a-mac*
  (setq mac-option-key-is-meta nil)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  (defkbalias (kbd "<mouse-8>") (kbd "<mouse-2>"))
  (global-set-key (kbd "<M-mouse-8>") 'mouse-yank-primary)
  (defkbalias (kbd "<C-down-mouse-8>") (kbd "<C-down-mouse-2>"))
  (defkbalias [vertical-line C-mouse-8] [vertical-line C-mouse-2])
  (defkbalias [vertical-scroll-bar C-mouse-8] [vertical-scroll-bar C-mouse-2])
  (defkbalias [mode-line C-mouse-8] [mode-line C-mouse-2])
  (defkbalias [mode-line mouse-8] [mode-line mouse-2]))

(bind-keys :prefix-map endless/toggle-map
		   :prefix "C-c t"
		   ("a" . auto-complete-mode)
		   ("c" . flycheck-mode)
		   ("d" . toggle-debug-on-error)
		   ("f" . auto-fill-mode)
		   ("h" . hungry-delete-mode)
		   ("i" . aggressive-indent-mode)
		   ("w" . whitespace-mode))

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq-default custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p custom-file)
	(load custom-file))


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)


(provide 'init)
;;; init.el ends here
