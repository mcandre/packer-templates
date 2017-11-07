#!/bin/sh
VIRTUALBOX_VERSION="$(cat /home/vagrant/.vbox_version)"

export DEBIAN_FRONTEND=noninteractive

apt-get update &&
    apt-get install -y "linux-headers-$(uname -r)" build-essential &&
    mkdir /tmp/VirtualBox &&
    mount -o loop "/home/vagrant/VBoxGuestAdditions_${VIRTUALBOX_VERSION}.iso" /tmp/VirtualBox &&
    yes | sh /tmp/VirtualBox/VBoxLinuxAdditions.run &&
    umount /tmp/VirtualBox &&
    rmdir /tmp/VirtualBox &&
    service vboxadd start &&
    rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.? &&
    rm -rf /usr/src/virtualbox-ose-guest* &&
    rm -rf /usr/src/vboxguest* &&
    apt-get remove --purge -y "linux-headers-$(uname -r)" build-essential
