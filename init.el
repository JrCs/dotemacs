
(setq inhibit-startup-message t)  ;; Permet de ne pas afficher le message de startup

;;;;;;;;;;;;;;;;;
;; Customizations
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

;; Modify load path
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "my-libraries/")))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Package configuration
(require 'package)

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

;; Customize Plus
(require 'cus-edit+)
(customize-toggle-outside-change-updates 99)

;;;;;;;;;;
;; Buffers
(defun switch-to-previous-buffer()
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer) 1)))

;;;;;;
;; IDO
(require 'ido)
(ido-mode t)
(ido-everywhere 1)

(require 'ido-completing-read+)

;;;;;;;;;;
;; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;;;;;;;;;
;; Perl
(autoload 'perltidy "perltidy-mode" nil t)
(autoload 'perltidy-mode "perltidy-mode" nil t)
(eval-after-load "cperl-mode"
  '(define-key cperl-mode-map "\C-ct" 'perltidy))
;(eval-after-load "cperl-mode"
;  '(progn (add-hook 'cperl-mode-hook 'perltidy-mode)
;		  (define-key cperl-mode-map "\C-ct" 'perltidy)))

;; perlcritic
(autoload 'perlcritic        "perlcritic" "" t)
(autoload 'perlcritic-region "perlcritic" "" t)
(autoload 'perlcritic-mode   "perlcritic" "" t)

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
(desktop-save-mode 1)

(global-set-key (kbd "<mouse-8>") 'mouse-yank-primary)
(global-set-key (kbd "<M-mouse-8>") 'mouse-yank-secondary)
(global-set-key (kbd "<C-down-mouse-8>") 'facemenu-menu)
(global-set-key [vertical-line C-mouse-8] 'mouse-split-window-vertically)
(global-set-key [vertical-scroll-bar C-mouse-8] 'mouse-split-window-vertically)
(global-set-key [mode-line C-mouse-8] 'mouse-split-window-horizontally)
(global-set-key [mode-line mouse-8] 'mouse-delete-other-windows)

;;;;;;;;;;;;;;;;;;;;;;
;; Custom Key Bindings
(global-set-key (kbd "<C-tab>") 'switch-to-previous-buffer)

;; undo
(require 'redo+)
(global-set-key (kbd "<f12>") 'undo)
(global-set-key (kbd "<f15>") 'undo)
(global-set-key (kbd "<pause>") 'undo)
(global-set-key (kbd "<C-f12>") 'redo)
(global-set-key (kbd "<C-f15>") 'redo)
(global-set-key (kbd "<C-pause>") 'redo)






