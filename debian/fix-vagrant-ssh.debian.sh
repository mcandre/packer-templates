#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# Work around vagrant-libvirt packaging issue with host keys
echo "#!/bin/sh\ntest -f /etc/ssh/ssh_host_rsa_key -a -f /etc/ssh/ssh_host_ecdsa_key -a -f /etc/ssh/ssh_host_ed25519_key || dpkg-reconfigure openssh-server" >/usr/sbin/ensure-host-keys &&
    chmod u+x /usr/sbin/ensure-host-keys &&
    echo "[Unit]\nDescription=Prepare sshd host keys\nBefore=ssh.service\n\n[Service]\nType=oneshot\nRemainAfterExit=true\nStandardOutput=journal\nExecStart=/usr/sbin/ensure-host-keys\n\n[Install]\nWantedBy=multi-user.target" >/lib/systemd/system/ensure-host-keys.service &&
    systemctl enable ensure-host-keys &&

    apt-get update &&
    apt-get install -y wget ca-certificates &&
    mkdir -p /home/vagrant/.ssh &&
    wget -O /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    chown -R vagrant:vagrant /home/vagrant/.ssh &&
    chmod 0700 /home/vagrant/.ssh &&
    chmod 0600 /home/vagrant/.ssh/authorized_keys &&
    apt-get purge -y wget ca-certificates
