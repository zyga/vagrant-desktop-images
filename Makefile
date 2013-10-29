#!/usr/bin/make -f

all: precise quantal raring saucy trusty
	@true

# Suffix appended to distro release name.
dsk := -desktop-i386

%:
	rm -f $@$(dsk)
	vagrant up $@
	vagrant package $@ --output $@$(dsk)
	vagrant box add -f $@$(dsk) ./$@$(dsk)
