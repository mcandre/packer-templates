#!/bin/sh
/usr/sbin/groupadd vagrant &&
    /usr/sbin/usermod -G vagrant vagrant &&
    mkdir -p /home/vagrant/.ssh &&
    ftp -o /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    /sbin/chown -R vagrant:staff /home/vagrant/.ssh &&
    chmod 0700 /home/vagrant/.ssh &&
    chmod 0600 /home/vagrant/.ssh/authorized_keys
