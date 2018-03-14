#!/bin/sh
apk add -U curl ca-certificates &&
    mkdir -p /home/vagrant/.ssh &&
    curl -Lo /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    chown -R vagrant:vagrant /home/vagrant/.ssh &&
    chmod 0700 /home/vagrant/.ssh &&
    chmod 0600 /home/vagrant/.ssh/authorized_keys &&
    apk del curl
