#!/bin/sh
/usr/sbin/groupadd vagrant &&
    /usr/sbin/usermod -G vagrant vagrant &&
    yes | pkgin update &&
    yes | pkgin install rsync &&
    echo 'default: :path=/usr/bin /bin /usr/pkg/bin /usr/local/bin /usr/sbin /sbin' >>/etc/login.conf
