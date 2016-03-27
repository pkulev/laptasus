# laptasus - ASUS laptop tools (backlight, keyboard backlight and etc.)
# Pavel Kulyov <kulyov.pavel@gmail.com>, 2016

PROJ = laptasus
PREFIX ?= $(HOME)/.local


build:
	echo "building"
	echo $(PREFIX)/$(PROJ)

install:
	echo "installing"

uninstall:
	echo "uninstalling"

clean:
	echo "cleaning"


.PHONY: build install uninstall clean
