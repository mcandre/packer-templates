#!/bin/sh
sudo printf "deb http://deb.debian.org/debian/ unstable main\ndeb-src http://deb.debian.org/debian/ unstable main\n" >/etc/apt/sources.list &&
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade \
        -q \
        -y \
        -u \
        -o Dpkg::Options::="--force-confdef" &&
    sudo apt-get -y --purge autoremove
