build: $(TRG)/boot/config.txt

$(TRG)/boot/config.txt:
	mkdir -p $(TRG)/boot
	cp cfg/boot.config.txt $(TRG)/boot/config.txt

PKGS += raspberrypi-bootloader-x linux-rpi2

