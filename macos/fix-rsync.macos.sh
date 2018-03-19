#!/bin/sh
dseditgroup -o create vagrant &&
    dseditgroup -o edit -a vagrant -t user vagrant
