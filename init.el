
(setq inhibit-startup-message t)  ;; Permet de ne pas afficher le message de startup

;;;;;;;;;;;;;;;;;
;; Customizations
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

;; Load modules in my-libraries
(defvar my-libraries-dir (expand-file-name (concat user-emacs-directory "my-libraries/")))
(add-to-list 'load-path my-libraries-dir)
;; Compile the files and create the autoload file if not exists
(if
	(not (file-exists-p (concat my-libraries-dir "my-libraries-loaddefs.el")))
	(call-process "make"))
(require 'my-libraries-loaddefs)
;;	(shell-command "make" nil nil))

;;(load "initsplit")
;;(custom-set-variables
;; '(xxxx
;;   (("user-" "ok" t)
;;		   )))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Package configuration
(require 'package)

;; Marmalade configuration
(add-to-list 'package-archives
			 '("marmalade" . "http://marmalade-repo.org/packages/"))

;; MELPA configuration
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;;;;;;;;;;;;;
;; Load Theme
(load-theme 'jrcs)
;(add-to-list 'default-frame-alist
;             '(font . "Inconsolata-13"))

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

;;;;;;
;; IDO
(require 'ido)
(require 'ido-completing-read+)
(ido-mode t)
(ido-everywhere 1)

;;;;;;;;;;
;; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      '(("home"
         ("Perl" (mode . perl-mode))
         ("GO"   (mode . go-mode))
         ("emacs-config" (or (filename . ".emacs.d")
                             (filename . "emacs-config")))
         ("Help" (or (name . "\*Help\*")
                     (name . "\*Apropos\*")
                     (name . "\*info\*"))))))
(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-switch-to-saved-filter-groups "home")))

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

;;;;;;;;;;;;
;; RPM Spec
(autoload 'rpm-spec-mode "rpm-spec-mode.el" "RPM spec mode." t)
(setq auto-mode-alist
      (append '(("\\.spec" . rpm-spec-mode)) auto-mode-alist))

;;;;;;;;;;;;
;; FlyCheck
;(add-hook 'after-init-hook #'global-flycheck-mode)

;;;;;;;;;;;;
;; GO
(add-hook 'before-save-hook #'gofmt-before-save)
(require 'golint)

;;;;;;;;;;;;;;;;;;;;;;;
;; Unix <-> Dos
;;
(defun dos-unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun unix-dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autoinsert
;;
(require 'autoinsert)
(add-hook 'find-file-hooks 'auto-insert)

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

