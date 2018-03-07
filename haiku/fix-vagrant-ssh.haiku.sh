#!/bin/sh
mkdir -p /boot/vagrant/.ssh &&
    curl -Lo /boot/vagrant/.ssh/authorized_keys 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' &&
    chmod 0600 /boot/vagrant/.ssh/authorized_keys &&
    chmod 0700 /boot/vagrant/.ssh &&
    mkdir -p /boot/vagrant/config/settings &&
    ln -s /boot/vagrant/.ssh /boot/vagrant/config/settings/ssh &&
    chown -R vagrant: /boot/vagrant
