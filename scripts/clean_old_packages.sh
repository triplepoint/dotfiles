#!/usr/bin/env bash
brew uninstall ansiweather              || true # this stopped working, and I wasn't using it
brew cask zap     keepassx              || true # replaced with keepassxc

#### DONE ####
# brew cask zap     flux                || true # MacOS added their own feature
# brew uninstall    ansible             || true # handling this with pip instead
# brew cask zap     functionflip        || true # My current keyboards don't need this
# pip uninstall     docker-py           || true # Replaced with 'docker'
# brew cask zap     github-desktop      || true # Never used this
# brew untap homebrew/dupes             || true # migrated back to homebrew/core
# brew cask zap     karabiner           || true # Never really used it
# brew cask zap     openscad            || true # fusion is my jam instead
# brew cask zap     pgadmin4            || true # Replaced with pg-commander
# brew uninstall    openssh             || true # the macos version is modified to support keychains
