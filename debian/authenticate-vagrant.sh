#!/bin/sh
apt-get update &&
    apt-get install -y wget &&
    mkdir -p /home/vagrant/.ssh &&
    wget -O /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    chown -R vagrant:vagrant /home/vagrant/.ssh &&
    chmod 0700 /home/vagrant/.ssh &&
    chmod 0600 /home/vagrant/.ssh/authorized_keys &&
    apt-get remove --purge -y wget
