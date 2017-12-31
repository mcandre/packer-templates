#!/bin/sh
echo '%wheel ALL=(ALL:ALL) NOPASSWD:ALL' >>/etc/sudoers &&
    chmod 0440 /etc/sudoers