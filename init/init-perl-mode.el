;;; init-perl-mode.el --- Setup for perl-mode        -*- lexical-binding: t; -*-

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

(use-package perl-mode
  :defer t
  :config
  (use-package perltidy
	:commands (perltidy-region perltidy-buffer perltidy-subroutine perltidy-dwim-safe perltidy-dwim)
	)
  (define-key perl-mode-map "\C-ct" 'perltidy-dwim-safe))


(provide 'init-perl-mode)
;;; init-perl-mode.el ends here
