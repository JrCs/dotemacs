;;; init-elpa.el --- Check needed packages           -*- lexical-binding: t; -*-

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

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(require-package 'use-package)

(defvar use-package-verbose t)
(require 'use-package)

;;(require-package 'fastnav)
;;(require-package 'pretty-symbols-mode)
;;(require-package 'bookmark+)
;;(require-package 'json)
;;(require-package 'js-comint)
;;(require-package 'paredit)
;;(require-package 'mic-paren)
;;(require-package 'eldoc-eval)
;;(require-package 'slime)
;;(require-package 'rainbow-mode)
;;(require-package 'rainbow-delimiters)
;;(require-package 'session)
;;(require-package 'tidy)
;;(require-package 'whole-line-or-region)
;;(require-package 'move-text)
;;(require-package 'hl-sexp)
;;(require-package 'pointback)
;;(require-package 'regex-tool)
;;(require-package 'flymake-cursor)
;;(require-package 'maxframe)
;;(require-package 'ace-jump-mode)

(provide 'init-elpa)
;;; init-elpa.el ends here
