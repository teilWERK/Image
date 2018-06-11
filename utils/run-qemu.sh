#!/bin/sh
branch=latest-stable
arch=armhf
flavor=vanilla
overlay="$1"

# TODO: getopt here

kernel=$(mktemp)
initrd=$(mktemp)

bootdir=tmp/alpine-rootfs/boot/

#modloop="http://boot.alpinelinux.org/images/${branch}/${arch}/modloop-${flavor}"

#wget -O "$kernel" "http://boot.alpinelinux.org/images/${branch}/${arch}/vmlinuz-${flavor}"
#wget -O "$initrd" "http://boot.alpinelinux.org/images/${branch}/${arch}/initramfs-${flavor}"

cp "$bootdir"/vmlinuz-vanilla $kernel
cp "$bootdir"/initramfs-vanilla $initrd

[ -n "$overlay" ] && (
  cd "${overlay%/*}"
  echo "${overlay##*/}" | cpio -H newc -o
) | gzip >> "$initrd"

#append="console=ttyS0,115200 alpine_repo=${repo} modules=loop,squashfs,virtio_net modloop=${modloop} quiet"
#append="console=ttyAMA0,115200 alpine_repo=${repo} modules=loop,squashfs,virtio_net modloop=${modloop} quiet"
append="console=ttyAMA0,115200 alpine_repo=${repo} modules=loop,squashfs,virtio_net,vfat,nls_utf8,nls_cp437,crc32c,ext4"
#append="console=ttyAMA0,115200 modules=loop,squashfs,virtio_net modules=virtio_net,virtio_blk modloop=${modloop}"

if [ -n "$overlay" ]; then
  append="$append apkovl=/${overlay##*/}"
fi

qemu-system-arm -m 512 -boot n \
	-machine virt -nographic -serial mon:stdio	\
	-device virtio-net-device,netdev=net0 -netdev user,id=net0	\
  -kernel "$kernel" \
  -initrd "$initrd" \
  -append "$append" \
  -drive if=none,file=sdcard.img,id=sdcard \
  -device virtio-blk-device,drive=sdcard \
#  -device virtio-blk-scsi,drive=sd \
#	-sd sdcard.img	\


rm "$kernel" "$initrd"
