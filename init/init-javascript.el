;;; init-javascript.el --- Setup for javascript mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Yves Blusseau

;; Author: Yves Blusseau <90z7oey02@sneakemail.com>
;; Keywords: abbrev

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

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :config
  (setq js2-strict-missing-semi-warning nil) ; don't warn in case of missing semicolon

  (use-package ac-js2
	:ensure t
	:init
	(add-hook 'js2-mode-hook 'ac-js2-mode))) ; enable ac-js2 (autocomplete for js2)


(provide 'init-javascript)
;;; init-javascript.el ends here
