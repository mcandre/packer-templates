#!/bin/sh
installoptionalpackage -a rsync &&
    mkdir /boot/vagrant-src &&
    chown vagrant: /boot/vagrant-src
