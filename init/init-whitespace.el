;;; init-whitespace.el --- Setup whitespace mode     -*- lexical-binding: t; -*-

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

(use-package whitespace
  :diminish (global-whitespace-mode
			 whitespace-mode
			 whitespace-newline-mode)
  :commands (whitespace-cleanup
			 whitespace-mode)
  :preface
  (defun normalize-file ()
	"Force encoding of the buffer to utf-8 (unix) and whitespace-clean
  it then save the file"
	(interactive)
	(save-excursion
	  (goto-char (point-min))
	  (whitespace-cleanup)
	  (delete-trailing-whitespace)
	  (goto-char (point-max))
	  (delete-blank-lines)
	  (set-buffer-file-coding-system 'unix)
	  (goto-char (point-min))
	  (while (re-search-forward "\r$" nil t)
		(replace-match ""))
	  (set-buffer-file-coding-system 'utf-8)
	  (let ((require-final-newline t))
		(save-buffer))))

  (defun maybe-turn-on-whitespace ()
	"Check parents dir to see if a .whitespace file exists. In this case the
file is whitespace cleanup on save"
	(let ((file (expand-file-name ".whitespace"))
		  parent-dir)
	  (while (and (not (file-exists-p file))
				  (progn
					(setq parent-dir
						  (file-name-directory
						   (directory-file-name
							(file-name-directory file))))
					;; Give up if we are already at the root dir.
					(not (string= (file-name-directory file)
								  parent-dir))))
		;; Move up to the parent dir and try again.
		(setq file (expand-file-name ".whitespace" parent-dir)))
	  ;; If we found a change log in a parent, use that.
	  (when (and (file-exists-p file)
				 (not (file-exists-p ".nowhitespace"))
				 (not (and buffer-file-name
						   (string-match "\\.texi\\'" buffer-file-name))))
		(add-hook 'write-contents-hooks
				  #'(lambda () (ignore (whitespace-cleanup))) nil t)
		(whitespace-cleanup))))

  :init
  (add-hook 'find-file-hooks 'maybe-turn-on-whitespace t)
  (global-set-key "\C-cn" #'normalize-file))


(provide 'init-whitespace)
;;; init-whitespace.el ends here
