build: $(ETC)/local.d/installer.start $(ETC)/inittab

$(ETC)/local.d/installer.start: cfg/local.d/installer.start
	mkdir -p $(ETC)/local.d
	cp cfg/local.d/installer.start $(ETC)/local.d
#	ln -sf /etc/init.d/local $(ETC)/runlevels/default

$(ETC)/inittab:
	echo "ttyAMA0::respawn:/etc/local.d/installer.start" > $(ETC)/inittab

