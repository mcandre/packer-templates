#!/bin/sh
useradd -m -g staff -G wheel vagrant &&
    PASSWORD_HASHED="$(echo 'vagrant' | pwhash)" &&
    usermod -p "$PASSWORD_HASHED" vagrant &&
    sed -i \
        -e 's/^#UseDNS no/UseDNS no/' \
        -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' \
        -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
        /etc/ssh/sshd_config &&
    printf "dhcpcd=YES\nntpdate=YES\nsshd=YES\n" >>/etc/rc.conf &&
    sh /etc/rc.d/sshd onestart
