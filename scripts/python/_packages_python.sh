#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

### xcode's libraries need to be shown to command-line compilers
### NOTE: this is also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
### NOTE: disabled, seems to be unnecessary for now
# export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

### Define the versions of python to use as the global 2 and 3 versions
GLOBAL_PY2="2.7.15"
GLOBAL_PY3="3.7.0"

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
pip3 install pip setuptools wheel virtualenv pipenv --upgrade
pip2 install pip setuptools wheel virtualenv --upgrade

pushd "${BASH_SOURCE%/*}"

### Generate the complete package manifests for Python 3 and 2
rm -f Pipfile.py*.lock
PIPENV_PIPFILE=Pipfile.py3 pipenv lock --python ${GLOBAL_PY3} -r > requirements_py3.txt
PIPENV_PIPFILE=Pipfile.py2 pipenv lock --python ${GLOBAL_PY2} -r > requirements_py2.txt

### Install Packages for the Python 3 and 2 environments
pip3 install -r requirements_py3.txt
pip2 install -r requirements_py2.txt

popd
