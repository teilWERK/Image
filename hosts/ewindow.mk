include tasks/generic.mk
include tasks/network-dhcp.mk
include tasks/pulseaudio.mk

include tasks/installer.mk

PKGS += ToxBlinkenwall pulseaudio

PKGS += raspberrypi-bootloader-x linux-rpi2
