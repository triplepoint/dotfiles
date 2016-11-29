#!/usr/bin/env bash

vagrant box outdated --global 2>/dev/null | grep outdated | tr -d "*'" | cut -d ' ' -f 2 | xargs -I {} vagrant box add --clean {}
