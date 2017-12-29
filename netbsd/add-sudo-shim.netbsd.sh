#!/bin/sh
ftp -o master.zip https://github.com/mcandre/posix-sudo-shim/archive/master.zip &&
    unzip master.zip &&
    su root -c 'cp "$(pwd)/posix-sudo-shim-master/lib/sudo" /bin/sudo' &&
    rm -rf posix-sudo-shim-master \
        master.zip
