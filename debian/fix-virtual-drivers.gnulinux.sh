#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

case "$PACKER_BUILDER_TYPE" in
    virtualbox*)
        # Install VirtualBox drivers
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
        ;;
    vmware*)
        # Install VMware drivers
        apt-get update &&
            apt-get install -y "linux-headers-$(uname -r)" build-essential &&
            mkdir /tmp/VMware &&
            mount -o loop /home/vagrant/linux.iso /tmp/VMware &&
            cp /tmp/VMware/VMwareTools-*.tar.gz / &&
            tar xzvf /VMwareTools-*.tar.gz &&
            perl vmware-tools-distrib/vmware-install.pl -d &&
            rm -rf vmware-tools-distrib &&
            umount /tmp/VMware &&
            rmdir /tmp/VMware &&
            rm /home/vagrant/linux.iso &&
            apt-get purge -y "linux-headers-$(uname -r)" build-essential
        ;;
    qemu)
        # Apply legacy network adapter naming scheme
        sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet net.ifnames=0 biosdevname=0"/' /etc/default/grub &&
            update-grub &&
            echo "auto eth0\niface eth0 inet dhcp" >> /etc/network/interfaces.d/eth0
        ;;
esac
