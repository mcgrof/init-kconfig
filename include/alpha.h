#ifndef _ALPHA_H
#define _ALPHA_H

#include <generated/autoconf.h>

#ifdef CONFIG_ALPHA
void init_alpha(void);
#else
static inline void init_alpha(void) { };
#endif

#endif /* _ALPHA_H */
