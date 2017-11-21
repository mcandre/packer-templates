#!/bin/sh
curl -o wget-1.18-0.pkg https://raw.githubusercontent.com/rudix-mac/packages/master/10.12/wget-1.18-0.pkg && \
    sudo installer -pkg wget-1.18-0.pkg -target / && \
    rm wget-1.18-0.pkg
