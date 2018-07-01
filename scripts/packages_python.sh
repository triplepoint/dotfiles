#!/usr/bin/env bash

### System level Python package management tools
pip2 install pip setuptools wheel virtualenv pipenv --upgrade
pip3 install pip setuptools wheel virtualenv --upgrade

pushd "${BASH_SOURCE%/*}"

### Generate the package manifests for Python 2 and 3
PIPENV_PIPFILE=Pipfile.py2 pipenv lock --two -r > requirements_py2.txt
pipenv --rm
PIPENV_PIPFILE=Pipfile.py3 pipenv lock --three -r > requirements_py3.txt
pipenv --rm

# ### Install Packages for the Python 2 and 3 environments
pip2 install -r requirements_py2.txt
pip3 install -r requirements_py3.txt

popd
