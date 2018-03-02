#!/bin/sh
mkdir -p /usbkey/config.inc &&
    curl -kLo /usbkey/config.inc/authorized_keys 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' &&
    digest -a md5 /usbkey/config.inc/authorized_keys | grep 'b440b5086dd12c3fd8abb762476b9f40' &&
    echo 'root_authorized_keys_file=authorized_keys' >>/usbkey/config &&
    mkdir /opt/home/vagrant/.ssh &&
    cp /usbkey/config.inc/authorized_keys /opt/home/vagrant/.ssh/authorized_keys &&
    chown -R vagrant:staff /opt/home/vagrant/.ssh &&
    chmod 0755 /opt/home/vagrant/.ssh &&
    chmod 0600 /opt/home/vagrant/.ssh/authorized_keys
