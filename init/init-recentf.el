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

(use-package recentf
  :defer 10
  :commands (recentf-mode
             recentf-add-file
             recentf-apply-filename-handlers
			 recentf-ido-find-file)
  :bind ("C-x C-r" . recentf-ido-find-file)
  :preface
  (defun recentf-add-dired-directory ()
    (if (and dired-directory
             (file-directory-p dired-directory)
             (not (string= "/" dired-directory)))
        (let ((last-idx (1- (length dired-directory))))
          (recentf-add-file
           (if (= ?/ (aref dired-directory last-idx))
               (substring dired-directory 0 last-idx)
             dired-directory)))))
  :init
  (add-hook 'dired-mode-hook 'recentf-add-dired-directory)

  :config
  (defun recentf-ido-find-file ()
	"Find a recent file using Ido."
	(interactive)
	(let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
	  (when file
		(find-file file))))

  (setq-default
   recentf-max-saved-items 200)
  (recentf-mode 1))

(provide 'init-recentf)
;;; init-recentf.el ends here
