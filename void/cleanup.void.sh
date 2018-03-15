#!/bin/sh

# Clear log files
find /var/log -type f | xargs truncate -s 0

# Clear temporary files
rm -rf /tmp/*

# Shrink rootfs
count="$(df --sync -kP / | tail -n1 | awk -F ' ' '{ print $4 }')" &&
    count="$(($count - 1))" &&
    dd if=/dev/zero of=/tmp/whitespace bs=1024 count="$count" ||
    echo 'Zeroed rootfs' &&
    rm /tmp/whitespace

# Shrink boot partition
count="$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{ print $4 }')" &&
    count="$(($count - 1))" &&
    dd if=/dev/zero of=/boot/whitespace bs=1024 count="$count" ||
    echo 'Zeroed boot partition' &&
    rm /boot/whitespace

# Shrink swap space
swapuuid="$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)" &&
    swappart="$(readlink -f "/dev/disk/by-uuid/${swapuuid}")" &&
    /sbin/swapoff "$swappart" &&
    dd if=/dev/zero of="$swappart" bs=1M ||
    echo 'Zeroed swap space' &&
    /sbin/mkswap -U "$swapuuid" "$swappart"

# Shrink root partition and persist disks
dd if=/dev/zero of=/whitespace bs=1M ||
    echo 'Zeroed disk' &&
    rm -f /whitespace &&
    sync
