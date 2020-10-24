#!/usr/bin/env bash
set -ev

sudo apt-get install -y zsh

# install ohmyzsh if it isn't already installed
[ -d "${HOME}/.oh-my-zsh" ] || sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
