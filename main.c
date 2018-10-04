#include <stdio.h>

#include <generated/autoconf.h>

#include <foo.h>
#include <bar.h>
#include <baz.h>

static int init_subsys(void)
{
	init_foo();
	init_bar();
	init_baz();
}

int main(void)
{
	printf("init-kconfig demo\n");
	init_subsys();
	printf("Done!\n");
	return 0;
}
