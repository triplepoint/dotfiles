#!/usr/bin/env bash

# Stop on any error, print all commands
set -ev

# List all the outdated vagrant boxes, and do an upgrade for each one
vagrant box outdated --global 2>/dev/null | grep outdated | tr -d "*'" | cut -d ' ' -f 2 | xargs -I {} vagrant box add --clean --force {}

# Prune out any old versions
vagrant box prune
