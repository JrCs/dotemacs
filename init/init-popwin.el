;;; init-popwin.el --- Setup for popwin              -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Yves Blusseau

;; Author: Yves Blusseau <90z7oey02@sneakemail.com>
;; Keywords: frames

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

(use-package popwin
  :ensure t
  :demand t
  :config
  (delete 'help-mode popwin:special-display-config) ; Remove popwin for *help* buffers
  (push '("\*Flycheck checkers\*" :regexp t :position right :width 70 :dedicated t)
		popwin:special-display-config)
  (push '("^\*go-direx:" :regexp t :position right :width 0.4 :dedicated t)
		popwin:special-display-config)
  (popwin-mode t)

  (use-package import-popwin
	:ensure t
	:bind ("C-c i" . import-popwin)))

(provide 'init-popwin)
;;; init-popwin.el ends here
