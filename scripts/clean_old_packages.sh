#!/usr/bin/env bash

# Stop on any error, print all commands
set -ev

brew cask zap     flux    # MacOS added their own feature
brew uninstall    ansible # handling this with pip instead
brew cask zap     functionflip  # My current keyboards don't need this
pip uninstall     docker-py  # Replaced with 'docker'
brew cask zap     github-desktop  # Never used this
