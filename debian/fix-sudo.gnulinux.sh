#!/bin/sh
printf "%%wheel ALL=(ALL:ALL) NOPASSWD:ALL\nDefaults !requiretty\n" >>/etc/sudoers &&
    chmod 0440 /etc/sudoers