#!/bin/sh

# /!\ Completely guessing in the dark about Oxide syntax,
# semantics, privilege requirements, and available packages /!\
ox update # &&
# ox install wget ca-certificates # &&

mkdir -p /home/vagrant/.ssh &&
wget -O /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
chown -R vagrant:vagrant /home/vagrant/.ssh &&
chmod 0700 /home/vagrant/.ssh &&
chmod 0600 /home/vagrant/.ssh/authorized_keys &&

# /!\ Still guessing /!\
ox uninstall ca-certificates
