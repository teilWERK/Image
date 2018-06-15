build: $(ETC)/installer.sh $(ETC)/inittab

$(ETC)/installer.sh: cfg/installer.sh
	mkdir -p $(ETC)/local.d
	cp cfg/installer.sh $(ETC)/

$(ETC)/inittab:
	echo "ttyAMA0::once:/etc/installer.sh" >> $(ETC)/inittab
	echo "::sysinit:/sbin/openrc sysinit" >> $(ETC)/inittab
	echo "::sysinit:/sbin/openrc boot" >> $(ETC)/inittab
	echo "::wait:/sbin/openrc default" >> $(ETC)/inittab
