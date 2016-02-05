;;; init-recentf.el --- Recentf init file            -*- lexical-binding: t; -*-

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

;; it's better to disable auto-cleanup when using tramp
(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!

(recentf-mode t)

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
	(when file
	  (find-file file))))
(global-set-key (kbd "C-x C-r") 'recentf-ido-find-file)

(setq recentf-max-saved-items 300
      recentf-exclude '("/sudo:"))

(provide 'init-recentf)
;;; init-recentf.el ends here
