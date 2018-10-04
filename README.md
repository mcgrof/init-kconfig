Adapting Linux kernel kconfig
=============================

The Linux kernel uses kconfig to allow you to configure the kernel. kconfig
implements a variability modeling language. You can adapt kconfig to enable you
configure other software projects. Over time, Linux kconfig has become one of
the leading industrial variability modeling languages
([Formal Semantics of the Kconfig Language](http://www.eng.uwaterloo.ca/~shshe/kconfig_semantics.pdf),
[A Study of Variability Models and Languages in the Systems Software Domain](https://gsd.uwaterloo.ca/sites/default/files/vm-2013-berger.pdf))

What is often difficult to do though is to start off using kconfig though and
integration into a project. Or updating / syncing to the latest kconfig from
upstream Linux. This project is a passive fork of Linux kconfig which aims to
keep in sync with the Linux kernel's latest kconfig to allow projects to easily
adapt and embrace Linux kconfig for their own project.

The goal is *not* to fork kconfig and evolve it separately. The goal is to keep
this fork in sync with the evolution of kconfig on Linux to make it easier for
projects to use kconfig and also update their own kconfig when needed.

# License

Since we take code from Linux we respect its license and embrace the GPLv2 for
this project as well. We copy / embrace the SPDX license conventions as well.
If you decide to use other licenses, for other files in your own project be
sure to copy the respective licenses from upstream Linux.

# Contributing

We embraced and use the Linux DCO, be sure to Sign-off-by your patches.
For details refer to the [CONTRIBUTING](./CONTRIBUTING) file.

# Sending patches

You can send patches to help make adjustments / keep things in sync.
Additionally since kconfig could use more documentation, I would accept patches
to help start documenting different components not yet documented with the
intentions of eventually getting this upstream.

# Versioning

It is not a requirement to follow a versioning scheme as used in the Linux
kernel to be able to use kconfig. However this project embraces it to help
projects also pick such practice up if so desired. The main version if kept
as variables on the top level Makefile and an extra appended version string is
supplied if the tree is dirty, this is implemented with scripts/setlocalversion.

# Tracking linux-next

This documentation tracks linux-next, as such go clone it if you want to
embrace kconfig.

## linux-next version used

The latest sync happened using linux-next tag:

```
next-20181002
```

# Documentation for kconfig

Documentation for kconfig is upstream on Linux, so use and refer to that, be
sure to read this and the current limitations noted there in.

  * [Linux kconfig docs](https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt)

# Notes

If you run `make menuconfig` once, it will save the results into the files:

  * .config
  * include/generated/autoconf.h

If you run `make menuconfig` a second time, only `.config` will be updated.
This could either be a bug or a feature upstream. In any case, if you want
to regenerate include/generated/autoconf.h based on new results you should
be sure to run `make mrproper` prior to running `make menuconfig`.
