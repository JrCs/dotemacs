;;; init-flycheck.el --- Setup for flycheck          -*- lexical-binding: t; -*-

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

(use-package flycheck
  :ensure t
  :defer 5
  :diminish "FC"
  :bind ( "\C-c!t" . flycheck-mode )
  :config
  ;; lisp (disable emacs-lisp-checkdoc)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

  (defun force-flycheck-mode()
	(when (not flycheck-mode)
	  (flycheck-mode 1)))
  (global-set-key "\M-p" '(lambda()
							(interactive)
							(progn (force-flycheck-mode)
								   (flycheck-previous-error))))
  (global-set-key "\M-n" '(lambda()
							(interactive)
							(progn (force-flycheck-mode)
								   (flycheck-next-error))))

  (use-package flycheck-gometalinter
	:ensure t
	:config
	(progn
	  (flycheck-gometalinter-setup))
	(setq
	 ;; Set different deadline (default: 5s)
	 flycheck-gometalinter-deadline "15s"
	 ;; Enable vendoring support
	 flycheck-gometalinter-vendor t)))


(provide 'init-flycheck)
;;; init-flycheck.el ends here
