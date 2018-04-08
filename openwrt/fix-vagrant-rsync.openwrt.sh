#!/bin/sh
opkg install rsync &&
    mkdir /vagrant &&
    chown vagrant: /vagrant
