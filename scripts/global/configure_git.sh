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
git config --global diff.renameLimit 30000                  # Allow rename detection to track very large diffs
git config --global diff.tool meld                          # Use meld for 'git difftoool whatever'

git config --global alias.graph "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
