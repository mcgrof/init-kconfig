#ifndef _FOO_H
#define _FOO_H

#include <generated/autoconf.h>

#ifdef CONFIG_FOO
void init_foo(void);
#else
static inline void init_foo(void) { };
#endif

#endif /* _FOO_H */
