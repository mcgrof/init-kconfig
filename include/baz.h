#ifndef _BAZ_H
#define _BAZ_H

#include <generated/autoconf.h>

#ifdef CONFIG_BAZ
void init_baz(void);
#else
static inline void init_baz(void) { };
#endif

#endif /* _BAz_H */
