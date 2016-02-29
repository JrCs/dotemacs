;;; init-indent.el --- Setup for configuring indentation  -*- lexical-binding: t; -*-

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

;;-----------------------------------------------------------------------------
;; TAB Width
;;-----------------------------------------------------------------------------
(setq-default tab-width 4)


;;-----------------------------------------------------------------------------
;; Aggressive Indent Mode (https://github.com/Malabarba/aggressive-indent-mode)
;;-----------------------------------------------------------------------------
(use-package aggressive-indent
  :ensure t
  :defer 6
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'perl-mode)
  (add-to-list
   'aggressive-indent-dont-indent-if
   '(and (or (derived-mode-p 'c-mode)
			 (derived-mode-p 'c++-mode))
		 (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
							 (thing-at-point 'line))))))


;;-----------------------------------------------------------------------------
;; dtrt-indent-mode (https://github.com/jscheid/dtrt-indent)
;;-----------------------------------------------------------------------------
(use-package dtrt-indent
  :ensure t
  :init (dtrt-indent-mode t))


(provide 'init-indent)
;;; init-indent.el ends here
