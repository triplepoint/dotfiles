#!/usr/bin/env bash

# Stop on any error, print all commands
set -ev

### Uncomment and edit these lines ###
# git config --global user.name "Your Name"
# git config --global user.email "email@example.com"

git config --global core.editor vim

git config --global core.excludesfile ~/.gitignore_global

git config --global diff.algorithm histogram
git config --global diff.indentHeuristic true

git config --global rerere.enabled true

# Make 'main' the default branch name on new repositories
git config --global init.defaultBranch main
