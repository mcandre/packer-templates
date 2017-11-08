#!/bin/sh

# Clear temporary files

rm -rf /tmp/*

# # Shrink home partition
#
# dd if=/dev/zero of=/home/whitespace bs=1M ||
#     echo 'Zeroed home partition' &&
#     rm -f /home/whitespace
#
# # Shrink root partition and persist disks
#
# dd if=/dev/zero of=/whitespace bs=1M ||
#     echo 'Zeroed disk' &&
#     rm -f /whitespace &&
#     sync
