#!/bin/sh
branch=edge
arch=armhf
repo=http://dl-cdn.alpinelinux.org/alpine/${branch}/main
flavor=vanilla
overlay="$1"
device="$2"

# TODO: getopt here

kernel=$(mktemp)
initrd=$(mktemp)

wget -O "$kernel" http://dl-cdn.alpinelinux.org/alpine/edge/releases/armhf/netboot-3.8.0_rc3/vmlinuz-vanilla
wget -O "$initrd" http://dl-cdn.alpinelinux.org/alpine/edge/releases/armhf/netboot-3.8.0_rc3/initramfs-vanilla

[ -n "$overlay" ] && (
  cd "${overlay%/*}"
  echo "${overlay##*/}" | cpio -H newc -o
) | gzip >> "$initrd"

modloop=http://dl-cdn.alpinelinux.org/alpine/edge/releases/armhf/netboot-3.8.0_rc3/modloop-vanilla

quiet=
console=ttyAMA0
modules="loop,squashfs,virtio_net,vfat,nls_utf8,nls_cp437,crc32c,ext4"
append="console=${console},115200 alpine_repo=${repo} modules=${modules} modloop=${modloop} $quiet"

if [ -n "$overlay" ]; then
  append="$append apkovl=/${overlay##*/}"
fi

qemu-system-arm -m 512 -boot n 						\
	-machine virt -nographic -serial mon:stdio      		\
	-device virtio-net-device,netdev=net0 -netdev user,id=net0      \
	-kernel "$kernel"						\
	-initrd "$initrd"						\
	-append "$append"						\
	-drive if=none,file=${device},id=sdcard,format=raw		\
	-device virtio-blk-device,drive=sdcard				\

rm "$kernel" "$initrd"
