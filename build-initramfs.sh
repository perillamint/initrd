#!/bin/bash
cd /usr/src/initramfs

for dir in "dev proc sys" do
    if [ -d $dir ]
        mkdir $dir
    fi
done

lddtree --copy-to-tree=initramfs $(cat elflist)
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initrd.img
