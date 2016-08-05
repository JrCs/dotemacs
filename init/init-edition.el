;;; init-edition.el --- Setup misc edition parameters  -*- lexical-binding: t; -*-

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

;;

;;; Code:

;;----------------------------------------------------------------------------
;; Delete Selection mode
;;----------------------------------------------------------------------------
;; text inserted while the region is active will replace the region contents.
(use-package delsel
  :init (delete-selection-mode t))


;;----------------------------------------------------------------------------
;; Electric Pair mode
;;----------------------------------------------------------------------------
;; Electric Pair mode is a global minor mode.  When enabled, typing
;; an open parenthesis automatically inserts the corresponding
;; closing parenthesis.  (Likewise for brackets, etc.).
;;(use-package elec-pair
;;  :init (electric-pair-mode t))

;;----------------------------------------------------------------------------
;; Parens mode
;;----------------------------------------------------------------------------
;; Visualization of matching parens
(use-package mic-paren
  :ensure t
  :defer 2
  :config
  (paren-activate))
;; (use-package paren
;;   :init
;;   (show-paren-mode t)
;;   (setq-default
;;    show-paren-style (quote mixed)))

;;----------------------------------------------------------------------------
;; Redo mode
;;----------------------------------------------------------------------------
;; Visualization of matching parens
(use-package redo+
  :ensure t
  :init
  (global-set-key (kbd "<f12>") 'undo)
  (global-set-key (kbd "<f15>") 'undo)
  (global-set-key (kbd "<pause>") 'undo)
  (global-set-key (kbd "<C-f12>") 'redo)
  (global-set-key (kbd "<C-f15>") 'redo)
  (global-set-key (kbd "<C-pause>") 'redo)
  )

;;----------------------------------------------------------------------------
;; Copy, Cut & Paste
;;----------------------------------------------------------------------------
;; handle copy/paste intelligently
(defun copy-from-osx ()
  "Handle copy/paste intelligently on osx."
  (let ((tramp-mode nil)
        (default-directory "~"))
    (shell-command-to-string "/usr/bin/pbpaste")))

(defun paste-to-osx (text &optional push)
  "Handle copy/paste intelligently on osx.
TEXT gets put into the Macosx clipboard.

The PUSH argument is ignored."
  (let* ((process-connection-type nil)
         (proc (start-process "pbcopy" "*Messages*" "pbcopy")))
    (process-send-string proc text)
    (process-send-eof proc)))

(define-minor-mode pbcopy-pbpaste-mode
  "Toggle pbcopy-pbpaste mode"
  :init-value *is-a-mac*
  :global t
  (cond
   ((and *is-a-mac* pbcopy-pbpaste-mode) ; pbcopy-pbpaste-mode on
    (setq interprogram-cut-function 'paste-to-osx
          interprogram-paste-function 'copy-from-osx))
   (t					; pbcopy-pbpaste-mode off
    (setq interprogram-cut-function nil
          interprogram-paste-function nil))))

;; Use the kill-ring for copy/paste
(setq mouse-drag-copy-region t)
(global-set-key [mouse-2] 'mouse-yank-at-click)

(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))

(global-set-key "\M-Y" 'yank-pop-forwards) ; M-Y (Meta-Shift-Y)


;;----------------------------------------------------------------------------
;; Hungry Delete mode
;;----------------------------------------------------------------------------
;; Remove consecutive white spaces
(use-package hungry-delete
  :ensure t
  :init
  (global-hungry-delete-mode))

;;----------------------------------------------------------------------------
;; nlinum mode
;;----------------------------------------------------------------------------
(use-package nlinum
  :ensure t
  :preface
  (defun goto-line-with-feedback ()
    "Show line numbers temporarily, while prompting for the line number input"
    (interactive)
    (unwind-protect
        (progn
          (nlinum-mode 1)
          (let ((num (read-number "Goto line: ")))
            (goto-char (point-min))
            (forward-line (1- num))))
      (nlinum-mode -1)))

  :init
  (bind-key "C-c g" #'goto-line)
  (global-set-key [remap goto-line] 'goto-line-with-feedback))


(global-set-key "\C-t" #'transpose-lines)

(provide 'init-edition)
;;; init-edition.el ends here
