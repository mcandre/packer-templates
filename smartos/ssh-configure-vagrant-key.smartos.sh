#!/bin/sh
mkdir -p /opt/home/vagrant/.ssh &&
    curl -kLo /opt/home/vagrant/.ssh/authorized_keys 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' &&
    digest -a md5 /opt/home/vagrant/.ssh/authorized_keys | grep 'b440b5086dd12c3fd8abb762476b9f40' &&
    chown -R vagrant:staff /opt/home/vagrant/.ssh &&
    chmod 0755 /opt/home/vagrant/.ssh &&
    chmod 0600 /opt/home/vagrant/.ssh/authorized_keys &&
    mkdir -p /usbkey/config.inc
