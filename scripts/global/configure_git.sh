#!/usr/bin/env bash
set -ev

### Uncomment and edit these lines ###
git config --global user.name "Jonathan Hanson"
git config --global user.email "jonathan@jonathan-hanson.org"


git config --global core.editor vim                         # Use VIM to handle commit messages
git config --global core.excludesfile ~/.gitignore_global   # Set up the global gitignore file
git config --global diff.algorithm histogram                # Use the histogram diff algorithm
git config --global diff.indentHeuristic true               # Make patches with indents easier to read
git config --global diff.submodule log                      # Print summaries of differences in submodules
git config --global pull.rebase false                       # Do a merge on git pull
git config --global init.defaultBranch main                 # Make 'main' the default branch name on new repositories
