#!/bin/sh
apk add -U rsync sudo &&
    mkdir /vagrant &&
    chown vagrant: /vagrant &&
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers &&
    sed -i -e 's/wheel:x:10:root/wheel:x:10:root,vagrant/' /etc/group
