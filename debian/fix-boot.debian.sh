#!/bin/sh
sed -i 's/RESUME=.*/RESUME=none/' /etc/initramfs-tools/conf.d/resume
update-initramfs -u
