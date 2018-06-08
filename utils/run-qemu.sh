#!/bin/sh
branch=latest-stable
arch=armhf
repo=http://dl-cdn.alpinelinux.org/alpine/${branch}/main
flavor=vanilla
overlay="$1"

# TODO: getopt here

kernel=$(mktemp)
initrd=$(mktemp)

bootdir=/var/lib/lxc/alpine-armhf/rootfs/boot/
#bootdir=armroot/boot/

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
append="console=ttyAMA0,115200 alpine_repo=${repo} modules=loop,squashfs,virtio_net"
#append="console=ttyAMA0,115200 modules=loop,squashfs,virtio_net modloop=${modloop}"

if [ -n "$overlay" ]; then
  append="$append apkovl=/${overlay##*/}"
fi

qemu-system-arm -m 512 -boot n \
	-machine virt -nographic -serial mon:stdio	\
	-device virtio-net-device,netdev=net0 -netdev user,id=net0	\
	-sd sdcard.img	\
  -kernel "$kernel" \
  -initrd "$initrd" \
  -append "$append"

rm "$kernel" "$initrd"
