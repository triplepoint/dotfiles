#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

### xcode's libraries need to be shown to command-line compilers
### NOTE: this is also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
### NOTE: disabled, seems to be unnecessary for now
# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

### Define the versions of python to use as the global 2 and 3 versions
GLOBAL_PY2="2.7.16"
GLOBAL_PY3="3.7.4"

### Ensure python 2 and 3 are installed, and set as global
brew install pyenv

pyenv install -s ${GLOBAL_PY2}

pyenv install -s ${GLOBAL_PY3}

pyenv global ${GLOBAL_PY3} ${GLOBAL_PY2}

### Enable pyenv
### NOTE: these are also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
set +v
export PATH="$HOME/.pyenv:$PATH"
eval "$(pyenv init -)"
set -v

### System level Python package management tools
#### Python3 support packages
pip3 install pip setuptools wheel virtualenv pipenv --upgrade

#### Python2 support packages
pip2 install pip setuptools wheel virtualenv --upgrade

pushd "${BASH_SOURCE%/*}"

### Generate the complete package manifests for Python 3 and 2
#### Generate Python 3 intermediate requirements.txt file
rm -f Pipfile.py3.lock
PIPENV_PIPFILE=Pipfile.py3 pipenv lock --python ${GLOBAL_PY3} -r > requirements_py3.txt

#### Generate Python 2 intermediate requirements.txt file
rm -f Pipfile.py2.lock
PIPENV_PIPFILE=Pipfile.py2 pipenv lock --python ${GLOBAL_PY2} -r > requirements_py2.txt

### Install Packages for the Python 3 and 2 environments
#### Install Python 3 packages
pip3 install -r requirements_py3.txt

#### Install Python 2 packages
pip2 install -r requirements_py2.txt

pyenv rehash

popd
