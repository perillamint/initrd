#!/bin/bash
cd /usr/src/initrd/initramfs

for dir in dev proc sys mnt mnt/root usr usr/sbin usr/bin usr/lib do
    if [ ! -d $dir ]
        mkdir $dir
    fi
done

cd ..

lddtree --copy-to-tree=initramfs $(cat elflist)

cd initramfs

find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initrd.img
