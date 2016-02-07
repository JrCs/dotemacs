;;; init-ibuffer.el --- IBuffer init file            -*- lexical-binding: t; -*-

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

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  :functions ibuffer-switch-to-saved-filter-groups
  :init
  (add-hook 'ibuffer-mode-hook
            #'(lambda ()
                (ibuffer-switch-to-saved-filter-groups "mine")))
  :config
  ;; Use human readable Size column instead of original one
  (define-ibuffer-column size-h
	(:name "Size" :inline t)
	(cond
	 ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
	 ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
	 (t (format "%8d" (buffer-size)))))

  ;; Modify the default ibuffer-formats
  (setq
   ibuffer-formats '((mark modified read-only vc-status-mini " "
						   (name 18 18 :left :elide)
						   " "
						   (size-h 9 -1 :right)
						   " "
						   (mode 16 16 :left :elide)
						   " "
						   (vc-status 16 16 :left)
						   " "
						   filename-and-process))

   ibuffer-saved-filter-groups '(("mine"
								  ("Perl" (mode . perl-mode))
								  ("GO"   (mode . go-mode))
								  ("emacs-config" (or (filename . ".emacs.d")
													  (filename . "emacs-config")))
								  ("Help" (or (name . "\*Help\*")
											  (name . "\*Apropos\*")
											  (name . "\*info\*")))))

   ibuffer-filter-group-name-face 'font-lock-doc-face)

  (setq-default
   ibuffer-expert t
   ibuffer-show-empty-filter-groups nil)

  (use-package ibuffer-vc
	:ensure t
	:preface
	(eval-when-compile
	  (defun vc-darcs-find-root() t))))

(provide 'init-ibuffer)
;;; init-ibuffer.el ends here
