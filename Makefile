#!/usr/bin/make -f

RELEASES = precise quantal raring saucy trusty
IMAGES = $(foreach release,$(RELEASES),$(release)-desktop-i386 $(release)-desktop-amd64)
BOXES = $(foreach image,$(IMAGES),$(image).box)

.PHONY: all
all: $(BOXES)

.PHONY: $(BOXES)
$(BOXES): %.box:
	vagrant up $*
	vagrant package $* --output $*.box
	vagrant destroy --force $*

clean:
	vagrant destroy --force
	rm -f *.box
