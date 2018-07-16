#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

### System level Python package management tools
pip2 install pip setuptools wheel virtualenv pipenv --upgrade
pip3 install pip setuptools wheel virtualenv --upgrade

pushd "${BASH_SOURCE%/*}"

### Generate the complete package manifests for Python 2 and 3
rm -f Pipfile.py*.lock
PIPENV_PIPFILE=Pipfile.py2 pipenv lock --two -r > requirements_py2.txt
PIPENV_PIPFILE=Pipfile.py3 pipenv lock --three -r > requirements_py3.txt

# ### Install Packages for the Python 2 and 3 environments
pip2 install -r requirements_py2.txt
pip3 install -r requirements_py3.txt

popd
