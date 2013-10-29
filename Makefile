#!/usr/bin/make -f

stamp := $(shell date +%s)

all: precise quantal raring saucy trusty
	@true

%: %-desktop-i386
	@true

%-desktop-i386:
	vagrant up $*
	vagrant package $* --output $@
	vagrant box add -f $@ ./$@

clean:
	rm -f *-desktop-i386

launch-%:
	mkdir -p $*-$(stamp)
	sed s/@RELEASE@/$*/ <Vagrantfile.in >$*-$(stamp)/Vagrantfile
	cd $*-$(stamp) && vagrant up
