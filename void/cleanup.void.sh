#!/bin/sh

# Clear log files
find /var/log -type f | xargs truncate -s 0

# Clear temporary files
rm -rf /tmp/*

# Shrink root partition and persist disks
dd if=/dev/zero of=/whitespace bs=1M ||
    echo 'Zeroed disk' &&
    rm -f /whitespace &&
    sync
