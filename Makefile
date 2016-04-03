# laptasus - ASUS laptop tools (backlight, keyboard backlight and etc.)
# Pavel Kulyov <kulyov.pavel@gmail.com>, 2016

PROJ = laptasus
VERSION = 0.1
PACKAGE = $(PROJ)-$(VERSION)

# Standard GNU variables
SHELL       ?= /bin/sh
prefix      ?= $(DESTDIR)/usr/local
exec_prefix ?= $(prefix)
bindir      ?= $(exec_prefix)/bin
sysconfdir  ?= $(prefix)/etc

# Specific variables
CONFIG       = $(PROJ)/config
CONFDIR      = $(sysconfdir)/$(PROJ)
PLUGDIR      = $(CONFDIR)/plugins

DISTFILES =      \
	$(PROJ)/     \
	LICENSE      \
	Makefile     \
	README.md

PLUGINFILES = $(shell find $(PROJ)/plugins -name "la-*")


all: $(CONFIG)

$(CONFIG):
	@echo "Generating default $(PROJ) configuration..."
	@cp -uv $(PROJ)/config.in $(CONFIG)
	@sed -i -s "s,%PLUGDIR%,$(PLUGDIR)," $(CONFIG)

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
	@cp -uv $(PROJ)/lactl $(bindir)
	@cp  -v $(CONFIG) $(CONFDIR)
	@cp -uRv $(PLUGINFILES) $(PLUGDIR)

installdirs:
	@mkdir -pv $(bindir) $(PLUGDIR)

uninstall:
	@echo "Uninstalling $(PACKAGE):"
	@rm -fv  $(bindir)/lactl
	@rm -rfv $(CONFDIR)
	@echo "$(PACKAGE) uninstalled."

clean:
	@rm -rfv $(PACKAGE) $(CONFIG)

.PHONY: dist install installdirs uninstall clean
