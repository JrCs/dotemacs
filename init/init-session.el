;;; init-session.el --- Save and restore session     -*- lexical-binding: t; -*-

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


(use-package desktop
  :init (desktop-save-mode nil)
  :config
  ;; save a bunch of variables to the desktop file
  ;; for lists specify the len of the maximal saved data also
  (setq desktop-globals-to-save
		(append '((comint-input-ring        . 50)
				  (compile-history          . 30)
				  desktop-missing-file-warning
				  (dired-regexp-history     . 20)
				  (extended-command-history . 30)
				  (face-name-history        . 20)
				  (file-name-history        . 100)
				  (grep-find-history        . 30)
				  (grep-history             . 30)
				  (magit-read-rev-history   . 50)
				  (minibuffer-history       . 50)
				  (org-clock-history        . 50)
				  (org-refile-history       . 50)
				  (org-tags-history         . 50)
				  (query-replace-history    . 60)
				  (read-expression-history  . 60)
				  (regexp-history           . 60)
				  (regexp-search-ring       . 20)
				  register-alist
				  (search-ring              . 20)
				  (shell-command-history    . 50)
				  tags-file-name
				  tags-table-list))))

(use-package saveplace
  :defer 1
  :config
  (setq-default save-place t))

(provide 'init-session)
;;; init-session.el ends here
