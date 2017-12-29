#!/bin/sh

case "$PACKER_BUILDER_TYPE" in
    virtualbox-*)
        ;;
    *)
        exit
        ;;
esac

export DEBIAN_FRONTEND=noninteractive

apt-get update &&
    apt-get install -y "linux-headers-$(uname -r)" build-essential &&
    mkdir /tmp/VirtualBox &&
    mount -o loop /home/vagrant/VBoxGuestAdditions.iso /tmp/VirtualBox &&
    yes | sh /tmp/VirtualBox/VBoxLinuxAdditions.run &&
    umount /tmp/VirtualBox &&
    rmdir /tmp/VirtualBox &&
    service vboxadd start &&
    rm -rf /home/vagrant/VBoxGuestAdditions.iso \
        /usr/src/virtualbox-ose-guest* \
        /usr/src/vboxguest* &&
    apt-get purge -y "linux-headers-$(uname -r)" build-essential
