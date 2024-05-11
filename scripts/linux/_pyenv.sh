#!/usr/bin/env bash
set -ev

# Needed for python to build
# see: https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt-get install -q -y --no-install-recommends \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

[ -d "${HOME}/.pyenv" ] || curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

pyenv update
