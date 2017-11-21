#!/bin/sh
SSH_DIR='/Users/vagrant/.ssh' &&
    mkdir -p "$SSH_DIR" &&
    curl -o "${SSH_DIR}/authorized_keys" https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub &&
    chown -R vagrant:staff "$SSH_DIR" &&
    chmod 0700 "$SSH_DIR" &&
    chmod 0600 "${SSH_DIR}/authorized_keys" &&
    sed -i '' 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
