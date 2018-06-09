include tasks/generic.mk
include tasks/installer.mk

PKGS += e2fsprogs

build: ewindow.apkovl.tar.gz
	cp ewindow.apkovl.tar.gz $(ETC)/installee.apkovl.tar.gz
