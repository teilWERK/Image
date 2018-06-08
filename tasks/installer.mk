build: $(ETC)/local.d/installer

$(ETC)/network/interfaces: $(ETC)/runlevels/default/local
	mkdir -p $(ETC)/local.d
	cp cfg/local.d/installer.start $(ETC)/local.d
