#!/usr/bin/env bash
brew uninstall ansiweather              || true # this stopped working, and I wasn't using it
rm ~/.ansiweatherrc                     || true
brew cask zap     keepassx              || true # replaced with keepassxc
brew uninstall    htop                  || true # Turns out to be incompatible with high sierra.  Removing for now.
brew cask zap     crashplan             || true # Screw these people

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
