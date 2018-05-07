#!/bin/sh
pkg update &&
    mkdir -p /home/vagrant/.ssh &&
    fetch -o /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    chown -R vagrant:vagrant /home/vagrant/.ssh &&
    chmod 0700 /home/vagrant/.ssh &&
    chmod 0600 /home/vagrant/.ssh/authorized_keys &&
