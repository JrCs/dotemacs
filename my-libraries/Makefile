EMACS_INFO  = emacs

EMACS		= emacs
RM		    = -rm -f

AUTOLOAD_FILE = my-libraries-loaddefs.el

LISP_FILES	= $(filter-out $(AUTOLOAD_FILE), $(wildcard *.el))
CLEAN_FILES	= .\\\#* \\\#* .*~ *~ *.aux *.cp *.cps *.diff *.dvi *.elc *.fn *.fns *.html *.info *.ky *.log *.pg *.tmp *.toc *.tp *.vr *.vrs

ifeq ($(EMACS_INFO), emacs)
#  EM = $(EMACS) --no-site-file -batch
	EM = $(EMACS) -batch
else
  EM = $(EMACS) -no-autoloads -batch -l cl-macs
endif

.PHONY: all autoloads clean distclean

.SUFFIXES: .elc .el

all: autoloads $(addsuffix .elc, $(basename $(LISP_FILES)))

autoloads: $(AUTOLOAD_FILE)

$(AUTOLOAD_FILE): Makefile $(LISP_FILES)
	@$(EM) -l autoload                                         \
	  --eval "(setq generated-autoload-file                    \
		      (expand-file-name \"$(AUTOLOAD_FILE)\"))"       \
	  --eval "(setq make-backup-files nil)"				       \
      --eval "(unless (string-equal \"$(EMACS_INFO)\" \"emacs\") \
        (defalias 'autoload-trim-file-name                     \
            'file-name-sans-extension))"                       \
	  -f batch-update-autoloads .
	# Emacs 22 does not add the `provide' form to the generated $(AUTOLOAD_FILE).
	@grep -q provide $@ || echo "(provide '$(AUTOLOAD_FILE)" >>$@

%.elc: %.el
	@echo "Compiling $?"
	@$(EM) -l bytecomp \
	  --eval "(add-to-list 'load-path default-directory)"		\
	  -f batch-byte-compile $?

clean:
	$(RM) $(CLEAN_FILES)

distclean: clean
	$(RM) $(AUTOLOAD_FILE)
