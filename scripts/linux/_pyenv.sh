#!/usr/bin/env bash

set -ev

# Needed for python to build
sudo apt-get install -y \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python-openssl \
    git


[ -d "${HOME}/.pyenv" ] || curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

pyenv update
