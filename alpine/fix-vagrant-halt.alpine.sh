#!/bin/sh
wget -O /bin/shutdown https://raw.githubusercontent.com/mcandre/posix-shutdown-shim/master/lib/shutdown &&
    chmod a+x /bin/shutdown
