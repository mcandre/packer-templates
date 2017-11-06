#!/bin/sh

# Authenticate vagrant

apt-get update && \
    apt-get install -y wget && \
    mkdir -p /home/vagrant/.ssh && \
    wget -O /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub && \
    chown -R vagrant:vagrant /home/vagrant/.ssh && \
    chmod 0700 /home/vagrant/.ssh && \
    chmod 0600 /home/vagrant/.ssh/authorized_keys

# Install VirtualBox plugins

VIRTUALBOX_VERSION="$(cat /home/vagrant/.vbox_version)"

apt-get install -y "linux-headers-$(uname -r)" build-essential dkms && \
    mkdir /tmp/VirtualBox && \
    mount -o loop "/home/vagrant/VBoxGuestAdditions_${VIRTUALBOX_VERSION}.iso" /tmp/VirtualBox && \
    yes | sh /tmp/VirtualBox/VBoxLinuxAdditions.run && \
    umount /tmp/VirtualBox && \
    rmdir /tmp/VirtualBox && \
    service vboxadd start && \
    rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.? && \
    rm -rf /usr/src/virtualbox-ose-guest* && \
    rm -rf /usr/src/vboxguest*

# Clean junk files

apt-get -y --purge remove "linux-headers-$(uname -r)" build-essential dkms && \
    apt-get -y --purge autoremove && \
    apt-get -y purge $(dpkg --list | grep '^rc' | awk '{print $2}') && \
    apt-get -y purge $(dpkg --list | egrep 'linux-image-[0-9]' | awk '{print $3,$2}' | sort -nr | tail -n +2 | grep -v $(uname -r) | awk '{ print $2}') && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ensure disk is preserved

sync
