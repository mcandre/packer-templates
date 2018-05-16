#!/bin/sh
sed -i -e 's/^tmpfs \/tmp tmpfs defaults,nosuid,nodev 0 0$/tmpfs \/tmp tmpfs defaults,nosuid,nodev,size=2G 0 0/' /etc/fstab &&
    mount -o remount /tmp
