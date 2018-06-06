#!/bin/sh
sed -i -E -e 's/%sudo[[:space:]]+ALL=\(ALL:ALL\)[[:space:]]+ALL/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
