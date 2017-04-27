#!/usr/bin/env bash

# brew cask zap     flux              || true # MacOS added their own feature
# brew uninstall    ansible           || true # handling this with pip instead
# brew cask zap     functionflip      || true # My current keyboards don't need this
# pip uninstall     docker-py         || true # Replaced with 'docker'
# brew cask zap     github-desktop    || true # Never used this

brew untap homebrew/dupes             || true # migrated back to homebrew/core
