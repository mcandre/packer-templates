#!/bin/sh

# Accelerate boot
echo 'autoboot_delay="0"' >>/boot/loader.conf

# Clear package cache
pkg clean -y

# Clear LiveCD files
rm -f /README* /autorun* /index.html /dflybsd.ico /etc.hdd /boot.catalog

# Clear source code
rm -rf /usr/src/*

# Clear core dumps
rm -f /*.core

# Clear log files
find /var/log -type f | xargs truncate -s 0

# Clear temporary files
rm -rf /tmp/*
