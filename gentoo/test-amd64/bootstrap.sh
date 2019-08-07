#!/bin/sh
emerge -uDU --keep-going --with-bdeps=y @world &&
    emerge curl
