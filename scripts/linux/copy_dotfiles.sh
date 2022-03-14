#!/usr/bin/env bash
set -ev

# Copy standard dotfiles from this repo into the user's environment

## Setup
### Determine where the home files are in this repository
GLOBAL_DF_HOME_PATH=$(dirname $0)/../../home/global
OS_DF_HOME_PATH=$(dirname $0)/../../home/linux

## Copy Over Standard Environment Files
cp -fp $GLOBAL_DF_HOME_PATH/.gitignore_global ${HOME}
cp -fp $GLOBAL_DF_HOME_PATH/.vimrc ${HOME}
cp -fp $OS_DF_HOME_PATH/.zshrc ${HOME}
cp -fp $OS_DF_HOME_PATH/.zprofile ${HOME}
cp -fp $OS_DF_HOME_PATH/.profile ${HOME}

mkdir -p ${HOME}/.oh-my-zsh/custom
cp -fp $GLOBAL_DF_HOME_PATH/.oh-my-zsh/custom/* ${HOME}/.oh-my-zsh/custom/

mkdir -p ${HOME}/.vagrant.d
cp -fp $GLOBAL_DF_HOME_PATH/.vagrant.d/Vagrantfile ${HOME}/.vagrant.d/

## Execution Path
### Useful command-line utilities (if present)
mkdir -p ${HOME}/bin
cp -fp $GLOBAL_DF_HOME_PATH/bin/* ${HOME}/bin || true
cp -fp $OS_DF_HOME_PATH/bin/* ${HOME}/bin || true
