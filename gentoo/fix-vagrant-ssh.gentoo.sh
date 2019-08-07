#!/bin/sh
emerge -uDU --keep-going --with-bdeps=y @world &&
    emerge wget ca-certificates &&
    mkdir -p /home/vagrant/.ssh &&
    wget -O /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    chown -R vagrant:vagrant /home/vagrant/.ssh &&
    chmod 0700 /home/vagrant/.ssh &&
    chmod 0600 /home/vagrant/.ssh/authorized_keys &&
    emerge -cav wget ca-certificates &&
    emerge -av --depclean
