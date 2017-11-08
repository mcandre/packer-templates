#!/bin/sh
su root -c 'echo -ne "\n" | pkgin update && echo -ne "\n" | pkgin install curl'
