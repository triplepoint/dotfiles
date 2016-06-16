#!/usr/bin/env bash

# Stop on any error, print all commands
set -ev

git config --global user.name "Jonathan Hanson"
git config --global user.email "jonathan@jonathan-hanson.org"

git config --global core.editor "subl -n -w"
git config --global diff.compactionHeuristic true


