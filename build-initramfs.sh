#!/bin/bash
FIRMWARE_DIR=/lib/firmware
cd /usr/src/initrd/initramfs

for dir in dev proc sys mnt mnt/root usr usr/sbin usr/bin usr/lib
do
    if [ ! -d $dir ]
    then
        mkdir $dir
    fi
done

cd ..

rm -rfv initramfs/lib
mkdir -p initramfs/lib/firmware

for i in $(cat firmware-list)
do
    cp -r $FIRMWARE_DIR/$i initramfs/lib/firmware/
done

lddtree --copy-to-tree=initramfs $(cat elflist)

cd initramfs

find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initrd.img
