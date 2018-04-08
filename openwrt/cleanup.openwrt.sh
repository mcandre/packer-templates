#!/bin/sh

# Clear log files
find /var/log -type f -print |
    while read f; do
        dd if=/dev/null of="$f"
    done

# Clear temporary files
rm -rf /tmp/*

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
