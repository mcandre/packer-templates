#!/bin/sh

case "$PACKER_BUILDER_TYPE" in
    virtualbox-*)
        ;;
    *)
        exit
esac

pkg update &&
    pkg install -y virtualbox-ose-additions &&
    sysrc vboxnet_enable="YES" &&
    sysrc vboxguest_enable="YES" &&
    sysrc vboxservice_enable="YES"
