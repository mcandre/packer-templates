#!/bin/sh
dseditgroup -o edit -a vagrant -t user wheel && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
