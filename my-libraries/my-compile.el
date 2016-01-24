(defun compile-and-load (fichier)
  "Compile et charge avec load-library un fichier elisp."
  (interactive "SQuel fichier ? ")
  (let ((el-file nil) (elc-file nil))
    ;; On recherche les fichiers à compiler
    (setq el-file (locate-file (concat fichier ".el") load-path)
		  elc-file (locate-file (concat fichier ".elc") load-path))
    (if
		(equal elc-file nil)
		(setq elc-file (concat el-file "c"))
      )
    ;; On vérifie l'existence du fichier original
    (if
		(not (equal el-file nil))
		(progn
		  (if
			  (file-newer-than-file-p el-file elc-file)
			  (progn
				(byte-compile-file el-file)
				)
			)
		  (load-library fichier)
		  )
	  (message (concat "Le fichier " fichier " n'a pas été trouvé."))
      )
    )
  )

(defun compile-all-my-lisp ()
  (interactive)
  (byte-recompile-directory (expand-file-name "~/.emacs.d/my-libraries") 0))

;; compilation automatique du init.el
(defun compile-init-file ()
  (interactive)
  (let ((byte-compile-warnings '(unresolved)))
	(byte-compile-file user-init-file)
	(message "Emacs init file saved and compiled.")))
