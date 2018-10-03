PROJECT=init-kconfig
VERSION=2.0

export PROJECT VERSION

.PHONY: default
default: menuconfig

scripts/kconfig/.mconf-cfg: scripts/kconfig/mconf-cfg.sh
	@./scripts/kconfig/mconf-cfg.sh > $@

.PHONY: menuconfig
default: menuconfig

menuconfig: scripts/kconfig/.mconf-cfg
	@$(MAKE) -C scripts/kconfig mconf
	@./scripts/kconfig/mconf Kconfig

.PHONY: clean

clean:
	$(MAKE) -C scripts/kconfig/ clean
