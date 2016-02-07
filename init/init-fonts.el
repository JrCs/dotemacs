;;; init-fonts.el --- Setup for fonts                -*- lexical-binding: t; -*-

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

(defvar emacs-font
  (cond
   (*is-a-mac*
	"-*-Menlo-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1"
	)
   ((string= system-name "ubuntu")
	;; "-*-Source Code Pro-normal-normal-normal-*-20-*-*-*-m-0-iso10646-1"
	"-*-Hack-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1"
	)
   (t
	(if (string= system-name "fedora")
		"-*-Myriad Pro-normal-normal-normal-*-17-*-*-*-p-0-iso10646-1"
	  ;; "-*-Source Code Pro-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1"
	  "-*-Hack-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1"
	  ))))

(defun init-font()
  (interactive)
  (set-frame-font emacs-font))

(if window-system
	(add-hook 'after-init-hook 'init-font))

(provide 'init-fonts)
;;; init-fonts.el ends here
