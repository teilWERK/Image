include tasks/generic.mk
include tasks/network-dhcp.mk
include tasks/ntp.mk
include tasks/sshd.mk
#include tasks/pulseaudio.mk
include tasks/raspberrypi.mk

PKGS += ToxBlinkenwall@git pulseaudio git bash v4l-utils util-linux
