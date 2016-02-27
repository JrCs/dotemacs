;;; init-modeline.el --- Setup for configuring the modeline  -*- lexical-binding: t; -*-

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

(setq-default
 column-number-mode t
 display-time-24hr-format t
 size-indication-mode t)

(use-package spaceline-config
  :ensure spaceline
  :config

  (spaceline-define-segment my-buffer-encoding
	"My buffer encoding."
	(let ((buf-coding (format "%s" buffer-file-coding-system)))
	  (if (string-match "\\(.+\\)-\\(dos\\|unix\\|mac\\)" buf-coding)
		  (concat
		   (replace-regexp-in-string "\\(iso\\|prefer\\)-" "" (match-string 1 buf-coding))
		   " ("
		   (match-string 2 buf-coding)
		   ")")
		buf-coding)))

  (spaceline-install
   `(((
	   (((persp-name :fallback workspace-number)
		 window-number) :separator "|")
	   buffer-modified)
	  :face highlight-face)
	 line-column
	 anzu
	 auto-compile
	 (buffer-id remote-host)
	 major-mode
	 ((flycheck-error flycheck-warning flycheck-info)
	  :when active)
	 (((minor-modes :separator spaceline-minor-modes-separator)
	   process)
	  :when active)
	 (erc-track :when active)
	 (version-control)
	 (org-pomodoro :when active)
	 (org-clock :when active)
	 nyan-cat)

   `(which-function
	 (python-pyvenv :fallback python-pyenv)
	 (battery :when active)
	 selection-info
	 input-method
	 my-buffer-encoding
	 (( point-position
		buffer-size)
	  :separator " | ")
	 (global :when active)
	 buffer-position
	 hud))
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-modified
		powerline-default-separator 'curve))


(provide 'init-modeline)
;;; init-modeline.el ends here
