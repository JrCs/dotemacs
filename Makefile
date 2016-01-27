SUBDIRS       := my-libraries
CLEANDIRS     := $(SUBDIRS:%=clean-%)
DISTCLEANDIRS := $(SUBDIRS:%=distclean-%)
RM            := -rm -f
CLEAN_FILES   := .\\\#* \\\#* .*~ *~ *.aux *.cp *.cps *.diff *.dvi *.elc *.fn *.fns *.html *.info *.ky *.log *.pg *.tmp *.toc *.tp *.vr *.vrs

.PHONY: all $(SUBDIRS) clean

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

$(CLEANDIRS):
	$(MAKE) -C $(@:clean-%=%) clean

$(DISTCLEANDIRS):
	$(MAKE) -C $(@:distclean-%=%) distclean

local-clean:
	@find . -name '*~' -print0 | xargs -0 rm -f
	$(RM) $(CLEAN_FILES)

clean: local-clean $(CLEANDIRS)

local-distclean: local-clean

distclean: local-distclean $(DISTCLEANDIRS)
