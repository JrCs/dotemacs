;;; init-go.el --- Setup for go-mode                 -*- lexical-binding: t; -*-

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

(use-package go-mode
  :ensure t
  :defer t
  :config
  (add-hook 'before-save-hook #'gofmt-before-save)
  (add-hook 'go-mode-hook (lambda ()
							(local-set-key (kbd "M-.") #'godef-jump)))
  (use-package go-autocomplete :ensure t)
  (use-package go-direx
	:ensure t
	:commands go-direx-pop-to-buffer
	:init
	(bind-key "C-c j" 'go-direx-pop-to-buffer go-mode-map)))

(provide 'init-go)
;;; init-go.el ends here
