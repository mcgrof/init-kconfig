#include <stdio.h>

#include <generated/autoconf.h>

#include <foo.h>
#include <bar.h>
#include <baz.h>
#include <alpha.h>

static int init_subsys(void)
{
	init_foo();
	init_bar();
	init_baz();
}

static int init_order_subsys(void)
{
	init_alpha();
}

int main(void)
{
	printf("init-kconfig demo\n");
	init_subsys();
	init_order_subsys();
	printf("Done!\n");
	return 0;
}
