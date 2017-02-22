#!/usr/bin/env bash

# List all the outdated vagrant boxes, and do an upgrade for each one
vagrant box outdated --global 2>/dev/null | grep outdated | tr -d "*'" | cut -d ' ' -f 2 | xargs -n 1 -P 8 -I {} vagrant box add --clean {}
