#!/bin/sh
pfexec \
    curl -kLo \
    /opt/doobie.sh \
    'https://raw.githubusercontent.com/mcandre/doobie/master/lib/doobie.sh' &&
    digest -a md5 /opt/doobie.sh |
    grep 'f446e12c0a603bbde9fd51324edbf092' >/dev/null &&
    chmod 644 /opt/doobie.sh
