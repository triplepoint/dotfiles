#!/usr/bin/env bash

DOTFILES_PATH=$(dirname $0)/..

echo "copying..."

cp -f $DOTFILES_PATH/home/._bash_prompt ~
cp -f $DOTFILES_PATH/home/._exports ~
cp -f $DOTFILES_PATH/home/._functions ~
cp -f $DOTFILES_PATH/home/._aliases ~
cp -f $DOTFILES_PATH/home/.bash_profile ~
cp -f $DOTFILES_PATH/home/.bashrc ~
cp -f $DOTFILES_PATH/home/.zshrc ~

mkdir -p ~/bin
cp -f $DOTFILES_PATH/home/bin/* ~/bin

source ~/.zshrc

echo "done."
