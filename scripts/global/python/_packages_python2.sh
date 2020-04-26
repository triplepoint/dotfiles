#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

### xcode's libraries need to be shown to command-line compilers
### NOTE: this is also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
### NOTE: disabled, seems to be unnecessary for now
# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

### Define the version of python to use as the global version
GLOBAL_PY2="2.7.17"

### Ensure python is installed, and set as global
pyenv install --skip-existing ${GLOBAL_PY2}
pyenv global ${GLOBAL_PY3} ${GLOBAL_PY2}

### Enable pyenv
### NOTE: these are also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
set +v
export PATH="$HOME/.pyenv:$PATH"
eval "$(pyenv init -)"
set -v

### Python support packages
pip2 install pip setuptools wheel virtualenv --upgrade --progress-bar off

pushd "${BASH_SOURCE%/*}"

### Generate intermediate requirements.txt file
PIPENV_PIPFILE=Pipfile.py2 pipenv --rm || true
rm -f Pipfile.py2.lock
PIPENV_PIPFILE=Pipfile.py2 pipenv lock --python ${GLOBAL_PY2} -r > requirements_py2.txt

### Install packages
pip2 install -r requirements_py2.txt --no-deps --progress-bar off

pyenv rehash

popd
