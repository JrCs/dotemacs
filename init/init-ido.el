;;; init-ido.el --- IDO init file                    -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Yves Blusseau

;; Author: Yves Blusseau <90z7oey02@sneakemail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;; Use C-f during file selection to switch to regular find-file

;;; Code:

;; Use C-f during file selection to switch to regular find-file

;;(require-package 'ido-ubiquitous)

(use-package ido
  :demand t
  :defines (ido-cur-item
			ido-require-match
			ido-selected
			ido-final-text
			ido-show-confirm-message)
  :bind (("C-x b" . ido-switch-buffer)
		 ("C-x B" . ido-switch-buffer-other-window))
  :preface
  (eval-when-compile
	(defvar ido-require-match)
	(defvar ido-cur-item)
	(defvar ido-show-confirm-message)
	(defvar ido-selected)
	(defvar ido-final-text))

  :config
  (setq-default
   ido-auto-merge-work-directories-length 0
   ido-default-buffer-method 'selected-window
   ido-enable-flex-matching t
   ido-use-filename-at-point nil
   ido-use-virtual-buffers t
   )
  (add-to-list 'backup-directory-alist
			   (cons (expand-file-name ido-save-directory-list-file) nil))
  (ido-mode 'both)

  (use-package ido-ubiquitous
	:ensure t
	:config
	(ido-ubiquitous-mode t)
	)
  )

;;;; Display ido results vertically, rather than horizontally
;;;;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;;(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
;;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)
;;
;;;; https://gist.github.com/493269
;;(defun split-window-vertically-and-switch ()
;;  (interactive)
;;  (split-window-vertically)
;;  (other-window 1))
;;
;;(defun split-window-horizontally-and-switch ()
;;  (interactive)
;;  (split-window-horizontally)
;;  (other-window 1))
;;
;;(defun ido-invoke-in-other-window ()
;;  "signals ido mode to switch to (or create) another window after exiting"
;;  (interactive)
;;  (setq ido-exit-minibuffer-target-window 'other)
;;  (ido-exit-minibuffer))
;;
;;(defun ido-invoke-in-horizontal-split ()
;;  "signals ido mode to split horizontally and switch after exiting"
;;  (interactive)
;;  (setq ido-exit-minibuffer-target-window 'horizontal)
;;  (ido-exit-minibuffer))
;;
;;(defun ido-invoke-in-vertical-split ()
;;  "signals ido mode to split vertically and switch after exiting"
;;  (interactive)
;;  (setq ido-exit-minibuffer-target-window 'vertical)
;;  (ido-exit-minibuffer))
;;
;;(defun ido-invoke-in-new-frame ()
;;  "signals ido mode to create a new frame after exiting"
;;  (interactive)
;;  (setq ido-exit-minibuffer-target-window 'frame)
;;  (ido-exit-minibuffer))
;;
;;(defadvice ido-read-internal (around ido-read-internal-with-minibuffer-other-window activate)
;;  (let* (ido-exit-minibuffer-target-window
;;		 (this-buffer (current-buffer))
;;		 (result ad-do-it))
;;	(cond
;;	 ((equal ido-exit-minibuffer-target-window 'other)
;;	  (if (= 1 (count-windows))
;;		  (split-window-horizontally-and-switch)
;;		(other-window 1)))
;;	 ((equal ido-exit-minibuffer-target-window 'horizontal)
;;	  (split-window-horizontally-and-switch))
;;
;;	 ((equal ido-exit-minibuffer-target-window 'vertical)
;;	  (split-window-vertically-and-switch))
;;	 ((equal ido-exit-minibuffer-target-window 'frame)
;;	  (make-frame)))
;;	(switch-to-buffer this-buffer) ;; why? Some ido commands, such as textmate.el's textmate-goto-symbol don't switch the current buffer
;;	result))
;;
;;(defadvice ido-init-completion-maps (after ido-init-completion-maps-with-other-window-keys activate)
;;  (mapcar (lambda (map)
;;			(define-key map (kbd "C-o") 'ido-invoke-in-other-window)
;;			(define-key map (kbd "C-2") 'ido-invoke-in-vertical-split)
;;			(define-key map (kbd "C-3") 'ido-invoke-in-horizontal-split)
;;			(define-key map (kbd "C-4") 'ido-invoke-in-other-window)
;;			(define-key map (kbd "C-5") 'ido-invoke-in-new-frame))
;;		  (list ido-buffer-completion-map
;;				ido-common-completion-map
;;				ido-file-completion-map
;;				ido-file-dir-completion-map)))
;;

(provide 'init-ido)
;;; init-ido.el ends here
