# SPDX-License-Identifier: GPL-2.0
PROJECT=init-kconfig
VERSION = 4
PATCHLEVEL = 19
SUBLEVEL = 0
EXTRAVERSION = -rc6

PHONY += all
all: example

include scripts/kconfig.Makefile

INCLUDES = -I include/
CFLAGS += $(INCLUDES)

obj-y = main.o
obj-$(CONFIG_FOO) += foo.o
obj-$(CONFIG_BAR) += bar.o
obj-$(CONFIG_BAZ) += baz.o
obj-$(CONFIG_ALPHA) += alpha/

include scripts/objects.Makefile

example: $(obj-y)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^

PHONY += clean
clean:
	$(MAKE) -f scripts/build.Makefile $@
	@rm -f example

PHONY += mrproper
mrproper:
	$(MAKE) -f scripts/build.Makefile clean
	$(MAKE) -f scripts/build.Makefile $@

PHONY += help
help:
	$(MAKE) -f scripts/build.Makefile $@

.PHONY: $(PHONY)
