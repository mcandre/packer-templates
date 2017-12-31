#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

apt-get update &&
    apt-get install -y ca-certificates &&
    mkdir -p /home/vagrant/.ssh &&
    wget -O /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    chown -R vagrant:vagrant /home/vagrant/.ssh &&
    chmod 0700 /home/vagrant/.ssh &&
    chmod 0600 /home/vagrant/.ssh/authorized_keys &&
    apt-get purge -y ca-certificates
