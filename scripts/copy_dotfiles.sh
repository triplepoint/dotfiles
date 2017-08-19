#!/usr/bin/env bash

# Stop on any error, print all commands
set -ev
# Copy standard dotfiles from this repo into the user's environment

## Setup
### Determine where the dot files are in this repository
DOTFILES_PATH=$(dirname $0)/..


## Copy Over Standard Environment Files
### Bash prompt definition
cp -fp $DOTFILES_PATH/home/._bash_prompt ~

### Not-security-concerned environment variables
cp -fp $DOTFILES_PATH/home/._exports ~

### Collection of useful shell functions
cp -fp $DOTFILES_PATH/home/._functions ~

### Command aliases (if present)
cp -fp $DOTFILES_PATH/home/._aliases ~ || true

### Bash environment initialization
cp -fp $DOTFILES_PATH/home/.bash_profile ~

### A shim bashrc that simply includes .bashprofile, for OSX terminal squirreliness
cp -fp $DOTFILES_PATH/home/.bashrc ~

### ZSH environment initialization
cp -fp $DOTFILES_PATH/home/.zshrc ~

cp -fp $DOTFILES_PATH/home/.ansiweatherrc ~

### TODO - maybe this should just copy all of home to ~


## Execution Path
### Useful command-line utilities (if present)
mkdir -p ~/bin
cp -fp $DOTFILES_PATH/home/bin/* ~/bin || true


## ZSH Profile Refresh
set +v
source ~/.zshrc
set -v
