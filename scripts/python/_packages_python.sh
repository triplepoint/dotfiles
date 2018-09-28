#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

### xcode's libraries need to be shown to command-line compilers
### Note that this is also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

### Ensure python 2 and 3 are installed, and set as global
brew install pyenv
pyenv install -s 2.7.15
pyenv install -s 3.7.0
pyenv global 3.7.0 2.7.15

### Enable pyenv
### Note that these are also done in the .zshrc file, but are here in case that
### file hasn't yet been installed
export PATH="$HOME/.pyenv:$PATH"
eval "$(pyenv init -)"

### System level Python package management tools
pip3 install pip setuptools wheel virtualenv pipenv --upgrade
pip2 install pip setuptools wheel virtualenv --upgrade

pushd "${BASH_SOURCE%/*}"

### Generate the complete package manifests for Python 3 and 2
rm -f Pipfile.py*.lock
PIPENV_PIPFILE=Pipfile.py3 pipenv lock --three -r > requirements_py3.txt
PIPENV_PIPFILE=Pipfile.py2 pipenv lock --two -r > requirements_py2.txt

# ### Install Packages for the Python 3 and 2 environments
pip3 install -r requirements_py3.txt
pip2 install -r requirements_py2.txt

popd
