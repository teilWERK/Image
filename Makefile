TRG=tmp/$(HOST)
ETC=$(TRG)/etc

.PHONY: default build

ifdef HOST
default: build
	tar -c -C "$(TRG)" etc | gzip -9n > $(HOST).apkovl.tar.gz

build:
	true

include hosts/$(HOST).mk
endif

ewindow.apkovl.tar.gz: build
	name="$@"; \
	make HOST=$${name%.apkovl.tar.gz} default

sdcard.img: ewindow.apkovl.tar.gz
	dd if=/dev/zero of=sdcard.img bs=1024 count=524288
	utils/run-qemu.sh $$PWD/ewindow.apkovl.tar.gz

clean:
	rm -rf tmp *.apkovl.tar.gz
