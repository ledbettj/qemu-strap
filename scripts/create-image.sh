#!/usr/bin/env bash
#set -e

if [ $# -ne 2 ]; then
  echo "usage: $0 <image-name> <image-size>"
  exit 1
fi

TARGET="$1"
SIZE="$2"

if [ -f "$TARGET" ]; then
  echo "target $TARGET already exists"
  exit 1
fi

TEMP=$(mktemp -d)

dd if=/dev/zero of="$TARGET" bs=1M count="$SIZE"

losetup   /dev/loop0 "$TARGET"
mkfs.ext2 /dev/loop0
mount     /dev/loop0 "$TEMP"

pacstrap -c -d "$TEMP" base
sed -ri 's/root:[^:]+/root:/' "$TEMP/etc/shadow" # remove root password
mkdir "$TEMP/mnt/shared"

echo -e "/dev/sda\t/\text2\tdefaults,noatime\t0\t1" >> "$TEMP/etc/fstab"
echo -e "/mnt/shared\t9p\ttrans=virtio,nofail\t0\t0" >> "$TEMP/etc/fstab"
umount     /dev/loop0
losetup -d /dev/loop0
