#!/bin/sh

echo 'sshd=YES' >>/etc/rc.conf &&
    mkdir -p /etc/rc.d &&
    cp /usr/pkg/etc/rc.d/sshd /etc/rc.d/
