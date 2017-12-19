#!/bin/sh
apt-get update &&
    apt-get install -y rsync &&
    groupadd vagrant &&
    groupadd wheel &&
    usermod -G vagrant vagrant &&
    usermod -G wheel vagrant &&
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers &&
    mkdir -p /export/home/vagrant/.ssh &&
    curl -Lo /export/home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    chown -R vagrant:staff /export/home/vagrant/.ssh &&
    chmod 0755 /export/home/vagrant/.ssh &&
    chmod 0600 /export/home/vagrant/.ssh/authorized_keys
