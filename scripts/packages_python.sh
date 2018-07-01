#!/usr/bin/env bash

# Run an install with both pip2 and pip3
pip2and3 () {
    set +v
    pip2 "$@"
    pip3 "$@"
    set -v
}

pip2and3 install  pip setuptools wheel virtualenv --upgrade
pip2and3 install  pipenv --upgrade
pip2and3 install  python-language-server --upgrade
pip2and3 install  isort --upgrade
pip2and3 install  ansible --upgrade
pip2and3 install  pre-commit --upgrade
