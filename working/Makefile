#!/usr/bin/make -f

stamp := $(shell date +%s)

%:
	mkdir -p $@-$(stamp)
	sed s/@RELEASE@/$@/ <Vagrantfile.in >$@-$(stamp)/Vagrantfile
	cd $@-$(stamp) && vagrant up
