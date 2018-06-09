build: $(ETC)/local.d/installer.start

$(ETC)/local.d/installer.start: cfg/local.d/installer.start
	mkdir -p $(ETC)/local.d
	cp cfg/local.d/installer.start $(ETC)/local.d
	ln -sf /etc/init.d/local $(ETC)/runlevels/default
