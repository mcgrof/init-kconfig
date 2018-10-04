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

# Each subdirectory can have two targets: all and clean
# all: builds all requirements, and if it is a directory dirname and if its
# a requirement to be linked in, it must also build its respective dirname.o
# as dirname/dirname.o will be added to the obj-y linked set for the final
# binary.
PHONY += all
all: example

INCLUDES = -I include/
CFLAGS += $(INCLUDES)

scripts/kconfig/mconf:
	$(MAKE) -C scripts/kconfig/ .mconf-cfg
	$(MAKE) -C scripts/kconfig/ mconf

PHONY += menuconfig
menuconfig: include/config/project.release scripts/kconfig/mconf
	@./scripts/kconfig/mconf Kconfig

-include .config

obj-y = main.o
obj-$(CONFIG_FOO) += foo.o
obj-$(CONFIG_BAR) += bar.o
obj-$(CONFIG_BAZ) += baz.o
obj-$(CONFIG_ALPHA) += alpha/

include scripts/objects.Makefile

subs: $(subdir-y)
	@echo dirs: $(subdir-y)
	@echo obj-y: $(obj-y)
	@echo subdir-y-objs: $(subdir-y-objs)

clean-subs: $(clean-subdirs)
	@echo clean-subs: $(clean-subdirs)

example: $(obj-y)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $(obj-y)

scripts/Kbuild.include: ;
include scripts/Kbuild.include

define filechk_project.release
	echo "$(PROJECTVERSION)$$($(CURDIR)/scripts/setlocalversion $(CURDIR))"
endef

include/config/project.release: $(CURDIR)/Makefile
	@$(call filechk,project.release)

export PROJECT PROJECTVERSION PROJECTRELEASE

PHONY += clean
clean: $(clean-subdirs)
	$(MAKE) -C scripts/kconfig/ clean
	@rm -f *.o example

PHONY += mrproper
mrproper:
	$(MAKE) clean
	@rm -rf $(CURDIR)/include/config/
	@rm -rf $(CURDIR)/include/generated/
	@rm -f .config

version-check: include/config/project.release
	@echo Version: $(PROJECTVERSION)
	@echo Release: $(PROJECTRELEASE)

PHONY += help
help:
	@$(MAKE) -s -C scripts/kconfig help
	@echo "Defaults configs:"					;\
	(cd defconfigs ; for f in $$(ls) ; do				\
		echo "defconfig-$$f"					;\
	done )
	@echo "Debugging"
	@echo "version-check      - demos version release functionality"
	@echo "clean              - cleans all output files"

scripts/kconfig/conf:
	$(MAKE) -C scripts/kconfig conf

# More are supported, however we only list the ones tested on this top
# level Makefile.
simple-targets := allnoconfig allyesconfig alldefconfig randconfig
PHONY += $(simple-targets)

$(simple-targets): scripts/kconfig/conf
	./scripts/kconfig/conf --$@ Kconfig

defconfig-%:: scripts/kconfig/conf
	@./scripts/kconfig/conf --defconfig=defconfigs/$(@:defconfig-%=%) Kconfig

.PHONY: $(PHONY)
