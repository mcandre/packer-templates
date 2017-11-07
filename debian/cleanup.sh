#!/bin/sh

# Empty apt cache

apt-get remove --purge -y \
    libx11-data \
    xauth \
    libxmuu1 \
    libxcb1 \
    libx11-6 \
    libxext6 \
    installation-report \
    wireless-tools \
    wpasupplicant &&
    dpkg --list |
    awk '{ print $2 }' |
    grep -- '-dev$' |
    xargs apt-get -y purge &&
    dpkg --list |
    egrep 'linux-image-[0-9]' |
    awk '{ print $3,$2 }' |
    sort -nr |
    tail -n +2 |
    grep -v "$(uname -r)" |
    awk '{ print $2 }' |
    xargs apt-get -y purge &&
    apt-get --purge -y autoremove &&
    dpkg --list |
    grep '^rc' |
    awk '{ print $2 }' |
    xargs apt-get -y purge &&
    apt-get autoclean -y &&
    apt-get clean &&
    rm -rf /var/lib/apt/lists/*

# Delete legacy junk

rm -rf /usr/share/groff/* \
    /usr/share/info/* \
    /usr/share/lintian/* \
    /usr/share/linda/*

# Delete Vagrant junk

rm /home/vagrant/.vbox_version

# Clear network cache, help DHCP load, accelerate vagrant ssh, accelerate GRUB

mkdir /etc/udev/rules.d/70-persistent-net.rules &&
    rm -rf /dev/.udev \
        /var/lib/dhcp/* \
        /var/lib/dhcp3/* &&
    echo 'pre-up sleep 2' >>/etc/network/interfaces &&
    sed -i 's/#UseDNS no/UseDNS no/' /etc/ssh/sshd_config &&
    sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub &&
    grub-mkconfig -o /boot/grub/grub.cfg

# Clear logs

find /var/log -type f |
    while read f; do echo -ne '' >"$f"; done

# Clear temporary files

rm -rf /tmp/*

# Wipe rootfs

count="$(df --sync -kP / | tail -n1 | awk -F ' ' '{ print $4 }')" &&
    count="$(($count-1))" &&
    dd if=/dev/zero of=/tmp/whitespace bs=1024 count="$count" &&
    rm /tmp/whitespace

# Wipe boot partition

count="$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{ print $4 }')" &&
    count="$(($count-1))" &&
    dd if=/dev/zero of=/boot/whitespace bs=1024 count="$count" &&
    rm /boot/whitespace

# Wipe swap space

swapuuid="$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)" &&
    swappart="$(readlink -f "/dev/disk/by-uuid/${swapuuid}")" &&
    /sbin/swapoff "$swappart" &&
    dd if=/dev/zero of="$swappart" bs=1M ||
    echo 'Zeroed swap space' &&
    /sbin/mkswap -U "$swapuuid" "$swappart"

# Shrink and preserve disk

dd if=/dev/zero of=/EMPTY bs=1M ||
    echo 'Zeroed disk' &&
    rm -f /EMPTY &&
    sync
