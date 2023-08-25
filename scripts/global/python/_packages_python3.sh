#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

### xcode's libraries need to be shown to command-line compilers
### NOTE: this is also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
### NOTE: disabled, seems to be unnecessary for now
# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

### Define the versions of python to use as the global versions (space separated)
# see: https://www.python.org/downloads/
GLOBAL_PY="3.11.5"

### Define the Python that we'll consider the dominant one
PRIMARY_PY=$(echo ${GLOBAL_PY} | cut -d ' ' -f1)

### Ensure python is installed, and set as global
for PY in ${GLOBAL_PY}; do
    pyenv install --skip-existing ${PY}
done
pyenv global ${GLOBAL_PY}

### Enable pyenv
### NOTE: these are also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
set +v
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
set -v

### Python support packages
python3 -m pip install pip setuptools wheel virtualenv pipx --isolated --disable-pip-version-check --upgrade --upgrade-strategy eager --progress-bar off
pyenv rehash
python3 -m pipx ensurepath
pipx upgrade-all

### Install global command-line tools
pipx install ansible-base
pipx install ansible-lint
pipx install black
pipx install isort
pipx install mypy
pipx install pipenv
pipx install poetry
pipx install pre-commit
pipx install pylint
