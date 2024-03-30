#!/usr/bin/env bash

# Decrypt the ansible vault password file, using the cached GPG key
SCRIPTDIR=$(dirname $(readlink -f "$0"))
gpg --decrypt ${SCRIPTDIR}/../.ansible-vault-password.asc 2> /dev/null
