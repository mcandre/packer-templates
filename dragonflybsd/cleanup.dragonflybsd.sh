#!/bin/sh

# Accelerate boot
echo 'autoboot_delay="0"' >>/boot/loader.conf

# Remove non-critical packages and clear cache
pkg remove -y bind-tools cdrtools git &&
    pkg autoremove -y
    pkg clean -y

# Clear LiveCD files
rm -rf /README* /autorun /index.html /dflybsd.ico /etc.hdd /boot.catalog

# Clear source code
rm -rf /usr/src/*

# Clear core dumps
rm -f /*.core

# Clear log files
find /var/log -type f | xargs truncate -s 0

# Clear temporary files
rm -rf /tmp/*

# Shrink swap space

swappart=$(swapctl -l | awk '!/^Device/ { print $1 }') &&
    swapctl -d "$swappart" &&
    dd if=/dev/zero of="$swappart" bs=1M ||
    echo 'Zeroed swap space'

# Shrink root partition and persist disks

dd if=/dev/zero of=/whitespace bs=1M ||
    echo 'Zeroed disk' &&
    rm -f /whitespace &&
    sync
