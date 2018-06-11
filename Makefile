ALPINE_LATEST_ROOTFS=http://dl-cdn.alpinelinux.org/alpine/edge/releases/armhf/alpine-uboot-3.8.0_rc1-armhf.tar.gz

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

%.apkovl.tar.gz: build
	name="$@"; \
	make HOST=$${name%.apkovl.tar.gz} default

tmp/alpine-rootfs:
	mkdir -p tmp/alpine-rootfs
	wget -P tmp -c $(ALPINE_LATEST_ROOTFS)
	tar -C tmp/alpine-rootfs -xf tmp/alpine-uboot-3.8.0_rc1-armhf.tar.gz

sdcard.img: installer.apkovl.tar.gz tmp/alpine-rootfs
	dd if=/dev/zero of=sdcard.img bs=1024 count=524288
	utils/run-qemu.sh $$PWD/installer.apkovl.tar.gz

clean:
	rm -rf tmp *.apkovl.tar.gz
