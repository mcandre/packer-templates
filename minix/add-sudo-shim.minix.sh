#!/bin/sh
yes | pkgin install git mozilla-rootcerts-openssl &&
    git clone https://github.com/mcandre/posix-sudo-shim.git &&
    su root -c 'cp "$(pwd)/posix-sudo-shim/lib/sudo" /bin/sudo' &&
    yes | pkgin remove git mozilla-rootcerts-openssl &&
    rm -rf posix-sudo-shim
