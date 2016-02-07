;;; init-sh-mode.el --- Setup for sh-mode         -*- lexical-binding: t; -*-

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

(use-package sh-script
  :defer t
  :init
  ;; Add a new face
  (defface sh-variable-used
	'((((class color) (background dark))
	   (:foreground "violet"))
	  (((class color) (background light))
	   (:foreground "violet")))
	"Face to show use of variable like $var or ${var}")
  ;; GNU emacs font-lock needs these...
  (defvar sh-variable-used-face 'sh-variable-used)
  
  :config
  (font-lock-add-keywords
   'sh-mode
   '(; fontify variable use
	 ("[$][{]?\\([A-Za-z_][A-Za-z0-9_]*\\)[}]?" 1 sh-variable-used-face t))))

(provide 'init-sh-mode)
;;; init-sh-mode.el ends here
