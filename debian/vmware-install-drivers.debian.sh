#!/bin/sh

case "$PACKER_BUILDER_TYPE" in
    vmware*)
        ;;
    *)
        exit
        ;;
esac

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
    apt-get purge -y "linux-headers-$(uname -r)" build-essential
