#!/bin/sh

# Accelerate vagrant ssh

echo 'UseDNS no' >>/usr/pkg/etc/ssh/sshd_config

# Clear package cache

pkgin clean

# Clear log files

find /var/log -type f | xargs truncate -s 0

# Clear temporary files

rm -rf /tmp/*
