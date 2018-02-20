#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

case "$PACKER_BUILDER_TYPE" in
    qemu)
        # Apply legacy network adapter naming scheme
        sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet net.ifnames=0 biosdevname=0"/' /etc/default/grub &&
            update-grub &&
            echo "auto eth0\niface eth0 inet dhcp" >> /etc/network/interfaces.d/eth0
        ;;
esac
