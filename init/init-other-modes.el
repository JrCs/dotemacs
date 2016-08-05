;;; init-other-modes.el ---                         -*- lexical-binding: t; -*-

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

;;----------------------------------------------------------------------------
;; RPM Spec mode
;;----------------------------------------------------------------------------
(use-package rpm-spec-mode
  :ensure t
  :mode ("\\.spec\\(\\.in\\|\\.tm?pl\\)?$" . rpm-spec-mode)
  :config
  (add-hook 'rpm-spec-mode-hook
            #'(lambda ()
                (hungry-delete-mode -1)))) ; disable hungry mode


;;----------------------------------------------------------------------------
;; JSON mode
;;----------------------------------------------------------------------------
(use-package json-mode :ensure t)


;;----------------------------------------------------------------------------
;; YAML mode
;;----------------------------------------------------------------------------
(use-package yaml-mode :ensure t)


;;----------------------------------------------------------------------------
;; Dockerfile mode
;;----------------------------------------------------------------------------
(use-package dockerfile-mode
  :ensure t
  :config
  (add-hook 'dockerfile-mode-hook
            #'(lambda ()
                (aggressive-indent-mode -1); disable agressive-indent mode
                (hungry-delete-mode -1)))) ; disable hungry mode


;;----------------------------------------------------------------------------
;; Markdown mode
;;----------------------------------------------------------------------------
(use-package markdown-mode
  :ensure t
  :mode (("\\bREADME\\.md\\'" . gfm-mode))
  :config
  (use-package markdown-preview-eww :ensure t))


;;----------------------------------------------------------------------------
;; Lisp mode
;;----------------------------------------------------------------------------
;; could be bad, will not let you save at all, until you correct the error
(add-hook 'emacs-lisp-mode-hook
          (function (lambda ()
                      (add-hook 'local-write-file-hooks
                                'check-parens))))

;;----------------------------------------------------------------------------
;; Terraform mode
;;----------------------------------------------------------------------------
(use-package terraform-mode :ensure t)


(provide 'init-other-modes)
;;; init-other-modes.el ends here
