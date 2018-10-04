#ifndef _BAR_H
#define _BAR_H

#include <generated/autoconf.h>

#ifdef CONFIG_BAR
void init_bar(void);
#else
static inline void init_bar(void) { };
#endif

#endif /* _BAR_H */
