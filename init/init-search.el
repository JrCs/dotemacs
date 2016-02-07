;;; init-search.el --- Setup for misc search  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Yves Blusseau

;; Author: Yves Blusseau <90z7oey02@sneakemail.com>
;; Keywords: convenience

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

(use-package color-moccur
  :ensure t
  :commands (dmoccur isearch-moccur isearch-moccur-all)
  :bind ("M-s O" . moccur)
  :init
  (bind-key "M-o" #'isearch-moccur isearch-mode-map)
  (bind-key "M-O" #'isearch-moccur-all isearch-mode-map)
  :config
  (use-package moccur-edit))

(defun isearch-delete-non-matching ()
  "Delete non-matching text or the last character."
  ;; Mostly copied from `isearch-del-char'
  (interactive)
  (if (= 0 (length isearch-string))
      (ding)
    (setq isearch-string
          (substring isearch-string
                     0
                     (or (isearch-fail-pos) (1- (length isearch-string)))))
    (setq isearch-message
          (mapconcat #'isearch-text-char-description isearch-string "")))
  (if isearch-other-end (goto-char isearch-other-end))
  (isearch-search)
  (isearch-push-state)
  (isearch-update))

(define-key isearch-mode-map (kbd "<backspace>")  #'isearch-delete-non-matching)

(provide 'init-search)
;;; init-search.el ends here
