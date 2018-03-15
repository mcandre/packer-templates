#!/bin/sh
xbps-install -uSy rsync &&
    xbps-remove -O
