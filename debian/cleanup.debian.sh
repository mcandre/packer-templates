#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# Remove non-critical packages and clear cache
apt-mark manual openssh-server &&
apt-get purge -y \
    tasksel \
    tasksel-data \
    task-laptop \
    task-english \
    bsdmainutils \
    pciutils \
    libx11-data \
    xauth \
    libxmuu1 \
    libxcb1 \
    libx11-6 \
    libxext6 \
    man-db \
    nano \
    whereami \
    whiptail \
    perl \
    make-guile \
    kbd \
    keyboard-configuration \
    lvm2 \
    eject \
    discover \
    dmidecode \
    tcpd \
    busybox \
    installation-report \
    wget \
    wireless-tools \
    wpasupplicant &&
    dpkg --list |
    awk '{ print $2 }' |
    grep -- '-dev' |
    xargs apt-get purge -y &&
    dpkg --list |
    egrep 'linux-image-[0-9]' |
    awk '{ print $3,$2 }' |
    sort -nr |
    tail -n +2 |
    grep -v "$(uname -r)" |
    awk '{ print $2 }' |
    xargs apt-get purge -y &&
    apt-get autoremove --purge -y &&
    dpkg --list |
    grep '^rc' |
    awk '{ print $2 }' |
    xargs apt-get purge -y &&
    apt-get autoclean -y &&
    apt-get clean -y &&
    rm -rf /var/lib/apt/lists/* \
        /var/cache/apt/pkgcache.bin \
        /var/cache/apt/srcpkgcache.bin

# Delete leftover documentation
find /usr/share/doc -depth -type f ! -name copyright |
    xargs rm ||
    echo 'Deleted non-copyright documentation' &&
    find /usr/share/doc -empty |
    xargs rmdir ||
    echo 'Delted empty documentation' &&
    rm -rf /usr/share/man/* \
        /usr/share/groff/* \
        /usr/share/info/* \
        /usr/share/lintian/* \
        /usr/share/linda/* \
        /var/cache/man/*

# Clear network cache, help DHCP load, accelerate vagrant ssh, accelerate GRUB
mkdir /etc/udev/rules.d/70-persistent-net.rules &&
    rm -rf /dev/.udev \
        /var/lib/dhcp/* \
        /var/lib/dhcp3/* &&
    echo 'pre-up sleep 2' >>/etc/network/interfaces &&
    echo 'UseDNS no' >>/etc/ssh/sshd_config &&
    sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub &&
    grub-mkconfig -o /boot/grub/grub.cfg

# Clear log files
find /var/log -type f | xargs truncate -s 0

# Clear temporary files
rm -rf /tmp/*

# Shrink rootfs
count="$(df --sync -kP / | tail -n1 | awk -F ' ' '{ print $4 }')" &&
    count="$(($count - 1))" &&
    dd if=/dev/zero of=/tmp/whitespace bs=1024 count="$count" ||
    echo 'Zeroed rootfs' &&
    rm /tmp/whitespace

# Shrink boot partition
count="$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{ print $4 }')" &&
    count="$(($count - 1))" &&
    dd if=/dev/zero of=/boot/whitespace bs=1024 count="$count" ||
    echo 'Zeroed boot partition' &&
    rm /boot/whitespace

# Shrink swap space
swapuuid="$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)" &&
    swappart="$(readlink -f "/dev/disk/by-uuid/${swapuuid}")" &&
    /sbin/swapoff "$swappart" &&
    dd if=/dev/zero of="$swappart" bs=1M ||
    echo 'Zeroed swap space' &&
    /sbin/mkswap -U "$swapuuid" "$swappart"

# Shrink root partition and persist disks
dd if=/dev/zero of=/whitespace bs=1M ||
    echo 'Zeroed disk' &&
    rm -f /whitespace &&
    sync
