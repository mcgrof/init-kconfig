CFLAGS=-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
LXDIALOG := lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o
MCONF_DEPS := mconf.o zconf.tab.c $(LXDIALOG)

default: mconf

zconf.tab.c: zconf.y
	@bison -ozconf.tab.c -t -l zconf.y
	@flex -ozconf.lex.c -L zconf.l

conf: conf.o zconf.tab.o
	$(CC) -o conf $^

simple-targets := oldconfig allnoconfig allyesconfig allmodconfig \
	alldefconfig randconfig listnewconfig olddefconfig syncconfig
PHONY += $(simple-targets)

$(simple-targets): conf
	@cd $(CURDIR)/../../ &&	./scripts/kconfig/$< $(silent) --$@ Kconfig

mconf_CFLAGS :=  $(shell test -f $(CURDIR)/.mconf-cfg && . $(CURDIR)/.mconf-cfg && echo $$cflags) -DLOCALE
mconf_LDFLAGS := $(shell test -f $(CURDIR)/.mconf-cfg && . $(CURDIR)/.mconf-cfg && echo $$libs)
mconf: CFLAGS += ${mconf_CFLAGS}

mconf: .mconf-cfg mconf.o zconf.tab.c $(LXDIALOG)
	$(CC) -o mconf $(MCONF_DEPS) $(mconf_LDFLAGS)


.PHONY: help
help:
	@echo "menuconfig         - demos the menuconfig functionality"
	@echo "allyesconfig       - enables all bells and whistles"
	@echo "allnoconfig        - disables all bells and whistles"
	@echo "randconfig         - random configuration"

.PHONY: clean
clean:
	@rm -f conf mconf conf *.o lxdialog/*.o *.o zconf.tab.c .mconf-cfg
	@rm -rf *.o.d
