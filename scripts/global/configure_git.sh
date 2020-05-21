#!/usr/bin/env bash

# Stop on any error, print all commands
set -ev

### Uncomment and edit these lines ###
git config --global user.name "Jonathan Hanson"
git config --global user.email "jonathan@jonathan-hanson.com"

git config --global core.editor vim
git config --global core.excludesfile ~/.gitignore_global
git config --global diff.indentHeuristic true
git config --global rerere.enabled true
