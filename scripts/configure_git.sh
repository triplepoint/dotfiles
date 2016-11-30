#!/usr/bin/env bash

# Stop on any error, print all commands
set -ev

git config --global user.name "Your Name"
git config --global user.email "email@example.com"

git config --global core.editor "subl -n -w"
git config --global diff.compactionHeuristic true
git config --global rerere.enabled true
