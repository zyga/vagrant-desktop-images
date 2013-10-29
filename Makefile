#!/usr/bin/make -f

stamp := $(shell date +%s)

all: precise quantal raring saucy trusty
	@true

%: %-desktop-i386
	@true

%-server-cloudimg-i386-vagrant-disk1.box:
	wget -c http://cloud-images.ubuntu.com/vagrant/$*/current/$*-server-cloudimg-i386-vagrant-disk1.box

%-desktop-i386: %-server-cloudimg-i386-vagrant-disk1.box
	vagrant up $*
	vagrant package $* --output $@
	vagrant box add -f $@ ./$@

clean:
	rm -f *-desktop-i386

launch-%:
	mkdir -p $*-$(stamp)
	sed s/@RELEASE@/$*/ <Vagrantfile.in >$*-$(stamp)/Vagrantfile
	cp -r manifests $*-$(stamp)
	cd $*-$(stamp) && vagrant up

.PRECIOUS: %.box
