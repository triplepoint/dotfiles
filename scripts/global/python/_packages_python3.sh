#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

### xcode's libraries need to be shown to command-line compilers
### NOTE: this is also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
### NOTE: disabled, seems to be unnecessary for now
# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

### Define the version of python to use as the global version
GLOBAL_PY3="3.9.5"

### Ensure python is installed, and set as global
pyenv install --skip-existing ${GLOBAL_PY3}
pyenv global ${GLOBAL_PY3}

### Enable pyenv
### NOTE: these are also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
set +v
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
set -v

### Python support packages
python3 -m pip install pip setuptools wheel virtualenv pipenv --upgrade --progress-bar off

pushd "${BASH_SOURCE%/*}"

### Generate intermediate requirements.txt file
PIPENV_PIPFILE=Pipfile.py3 pipenv --rm || true
rm -f Pipfile.py3.lock
PIPENV_PIPFILE=Pipfile.py3 pipenv lock --python ${GLOBAL_PY3} -r > requirements_py3.txt

### Install packages
python3 -m pip install -r requirements_py3.txt --no-deps --progress-bar off

pyenv rehash

popd
