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
(use-package elec-pair
  :init (electric-pair-mode t))

;;----------------------------------------------------------------------------
;; Parens mode
;;----------------------------------------------------------------------------
;; Visualization of matching parens
(use-package paren
  :init
  (show-paren-mode t)
  (setq-default
   show-paren-style (quote mixed)))

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
(use-package xclip :ensure t)

;; Use the kill-ring for copy/paste
(setq mouse-drag-copy-region t)
(global-set-key [mouse-2] 'mouse-yank-at-click)

(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))
(global-set-key "\M-Y" 'yank-pop-forwards) ; M-Y (Meta-Shift-Y)

(provide 'init-edition)
;;; init-edition.el ends here
