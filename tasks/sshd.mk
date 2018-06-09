PKGS += openssh mosh

build: $(ETC)/runlevels/default/sshd \
	$(ETC)/ssh/sshd_config

$(ETC)/ssh/sshd_config: $(ETC)/ssh/ca.pub
	( cat cfg/ssh/sshd_config; echo "TrustedUserCAKeys /etc/ssh/ca.pub" ) > $(ETC)/ssh/sshd_config

$(ETC)/ssh/ca.pub: cfg/ca.pub
	mkdir -p $(ETC)/ssh
	cp cfg/ca.pub $@

$(ETC)/ssh/ssh_host_%_key:
	t=$@; t=$${t##*host_}; t=$${t%_key}; \
	ssh-keygen -q -N "" -t $$t -f $@
	pass ssh/host-ca | ssh-keygen -s /dev/stdin -h \
		-h -n "$(HOST)" \
		-V "+$(SSH_CERT_VALIDITY)" \
		-z "$(shell date +%s)" \
		-I "$(HOST)" $@.pub
