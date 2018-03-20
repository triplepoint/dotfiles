#!/usr/bin/env bash

# Stop on any error, print all commands
set -ev

### Uncomment and edit these lines ###
# git config --global user.name "Your Name"
# git config --global user.email "email@example.com"

git config --global core.editor "atom --new-window --wait"
git config --global core.excludesfile ~/.gitignore_global
git config --global diff.compactionHeuristic true
git config --global diff.ansible-vault.textconv "ansible-vault view"
git config --global rerere.enabled true
