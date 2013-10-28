#!/usr/bin/make -f

all: precise quantal raring saucy trusty
	@true

%:
	vagrant up $@
	vagrant package $@ --output $@-desktop-i386
