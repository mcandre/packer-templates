#!/bin/sh
sudo hbsd-update &&
    sudo pkg update &&
    sudo pkg install -y curl
