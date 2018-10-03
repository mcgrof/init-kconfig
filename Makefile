# SPDX-License-Identifier: GPL-2.0
PROJECT=init-kconfig
VERSION = 4
PATCHLEVEL = 19
SUBLEVEL = 0
EXTRAVERSION = -rc6

PROJECTVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
# Picks up the project version and appends it with any dirty information in
# case were have modified our tree.
PROJECTRELEASE = $(shell test -f $(CURDIR)/include/config/project.release && cat $(CURDIR)/include/config/project.release 2> /dev/null)

.PHONY: default
default: menuconfig

# We need some generic definitions (do not try to remake the file).
scripts/Kbuild.include: ;
include scripts/Kbuild.include

define filechk_project.release
	echo "$(PROJECTVERSION)$$($(CURDIR)/scripts/setlocalversion $(CURDIR))"
endef

include/config/project.release: $(CURDIR)/Makefile
	@$(call filechk,project.release)

export PROJECT PROJECTVERSION PROJECTRELEASE

scripts/kconfig/.mconf-cfg: scripts/kconfig/mconf-cfg.sh
	@./scripts/kconfig/mconf-cfg.sh > $@

.PHONY: menuconfig
default: menuconfig

menuconfig: include/config/project.release scripts/kconfig/.mconf-cfg
	@$(MAKE) -C scripts/kconfig mconf
	@./scripts/kconfig/mconf Kconfig

.PHONY: clean

clean:
	$(MAKE) -C scripts/kconfig/ clean
	@rm -f $(CURDIR)/include/config/project.release

version-check: include/config/project.release
	@echo Version: $(PROJECTVERSION)
	@echo Release: $(PROJECTRELEASE)

.PHONY: help
help:
	@$(MAKE) -s -C scripts/kconfig help
	@echo "defconfig-foo      - Use the defconfigs/foo file for our configuration"
	@echo "version-check      - demos version release functionality"
	@echo "clean              - cleans all output files"

scripts/kconfig/conf:
	$(MAKE) -C scripts/kconfig conf

# More are supported, however we only list the ones tested on this top
# level Makefile.
simple-targets := allnoconfig allyesconfig alldefconfig randconfig
PHONY += $(simple-targets)

$(simple-targets):
	$(MAKE) -C scripts/kconfig $@

defconfig-%:: scripts/kconfig/conf
	@./scripts/kconfig/conf --defconfig=defconfigs/$(@:defconfig-%=%) Kconfig
