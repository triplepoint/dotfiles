#!/usr/bin/env bash

DOTFILES_PATH=$(dirname $0)/..

echo "copying..."

cp $DOTFILES_PATH/home/._bash_prompt ~
cp $DOTFILES_PATH/home/._exports ~
cp $DOTFILES_PATH/home/.bash_profile ~
cp $DOTFILES_PATH/home/.bashrc ~
cp $DOTFILES_PATH/home/.zshrc ~

echo "done."
