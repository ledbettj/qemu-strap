# qemu-strap

A simple project to quickly get started building and booting a custom
linux kernel with [QEMU](http://qemu.org) on arch linux.

## usage

You will need `arch-install-scripts` installed on your host system.

First compile the linux kernel.  Hopefully you know how to do this already.
Then:

    make setup # build our guest system disk image
    make run   # boot our guest system with the kernel we just build

Login to your guest system with the `root` user and no password.
