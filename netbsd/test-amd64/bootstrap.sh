#!/bin/sh
su root -c "PKG_PATH='http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.0/All' pkg_add wget" &&
    su root -c "sed -i -e 's/^vagrant:.*\$/vagrant: :path=\/nonexistent \/usr\/bin \/bin \/usr\/sbin \/sbin \/usr\/X11R7\/bin \/usr\/X11R6\/bin \/usr\/pkg\/bin \/usr\/pkg\/sbin \/usr\/local\/bin:/' /etc/login.conf" &&
    su root -c 'cap_mkdb /etc/login.conf'
