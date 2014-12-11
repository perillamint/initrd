#!/bin/bash
cd /usr/src/initramfs
lddtree --copy-to-tree=initramfs $(cat elflist)
cd initramfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initrd.img
