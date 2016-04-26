# laptasus - ASUS laptop tools (backlight, keyboard backlight and etc.)
# Pavel Kulyov <kulyov.pavel@gmail.com>, 2016

# TODO: add plugin library installation

PROJ = laptasus
VERSION = 0.1
PACKAGE = $(PROJ)-$(VERSION)

# Standard GNU variables
SHELL       ?= /bin/sh
prefix      ?= $(DESTDIR)
exec_prefix ?= $(prefix)/usr
bindir      ?= $(exec_prefix)/bin
sysconfdir  ?= $(prefix)/etc

# Specific source variables
INITNAME     = $(PROJ)
INITSCRIPT   = $(PROJ)/$(INITNAME)
CONFIG       = $(PROJ)/config
PLUGDIR      = $(CONFDIR)/plugins

# Specific installation variables
CONFDIR      = $(sysconfdir)/$(PROJ)
ELIBDIR      = $(libexecdir)/$(PROJ)

DISTFILES =      \
	$(PROJ)/     \
	LICENSE      \
	Makefile     \
	README.md

PLUGINFILES = $(shell find $(PROJ)/plugins -name "la-*")


all: $(CONFIG) $(INITSCRIPT)

$(CONFIG):
	@echo "Generating default $(PROJ) configuration..."
	@cp -uv $(PROJ)/config.in $(CONFIG)
	@sed -i -s "s,%PLUGDIR%,$(PLUGDIR)," $(CONFIG)

$(INITSCRIPT):
	@echo "Generating OpenRC init script..."
	@cp -uv $(INITSCRIPT).in $(INITSCRIPT)
	@sed -i -s "s,%PROJ%,lactl," $(INITSCRIPT)
	@sed -i -s "s,%BINDIR%,$(bindir)," $(INITSCRIPT)

dist: clean
	@echo "Creating dist tarball:"
	@mkdir -pv $(PACKAGE)
	@cp -av $(DISTFILES) $(PACKAGE)
	@tar -cvf $(PACKAGE).tar $(PACKAGE)
	@gzip -fv $(PACKAGE).tar
	@rm -rfv $(PACKAGE)
	@echo "Dist tarball '$(PACKAGE).tar' created."

install: $(CONFIG) installdirs
	@echo "Installing $(PACKAGE):"
	@echo "Binary: $(bindir)"
	@echo "Config: $(CONFDIR)"
	@echo "Libexec: $(ELIBDIR)"
	@cp -uv $(PROJ)/lactl $(bindir)
	@cp -uv $(INITSCRIPT) $(sysconfdir)/init.d
	@cp  -v $(CONFIG) $(CONFDIR)
	@cp -uRv $(PLUGINFILES) $(PLUGDIR)

installdirs:
	@mkdir -pv $(bindir) $(PLUGDIR)

uninstall:
	@echo "Uninstalling $(PACKAGE):"
	@rm -fv  $(bindir)/lactl
	@rm -fv  $(sysconfdir)/init.d/$(INITNAME)
	@rm -rfv $(CONFDIR)
	@echo "$(PACKAGE) uninstalled."

clean:
	@rm -rfv $(PACKAGE) $(CONFIG) $(INIT)

.PHONY: dist install installdirs uninstall clean
