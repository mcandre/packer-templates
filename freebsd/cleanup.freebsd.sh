#!/bin/sh

# Accelerate boot
echo 'autoboot_delay="0"' >>/boot/loader.conf

# Clear package cache
pkg clean -y

# Clear log files
find /var/log -type f | xargs truncate -s 0

# Clear temporary files
rm -rf /tmp/*
