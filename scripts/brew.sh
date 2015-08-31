#!/usr/bin/env bash

###
# Install and/or update a collection of useful OSX applications
###

# Update known packages
brew update

# Upgrade all installed packages
brew upgrade --all

# Install cask (to manage OS X application installs)
brew install brew-cask
brew tap caskroom/versions
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Development stuff
brew install ansible
brew cask install dockertoolbox
brew install git
brew install python
brew install ssh-copy-id
brew cask install sublime-text3
brew install tree
brew cask install vagrant


# General desktop-y stuff
brew cask install adium
brew install bash-completion
brew cask install deluge
#brew cask install dropbox # haven't tested, but should work
brew cask install google-chrome
brew install gnupg
brew cask install keepassx

# Clean up caches and such
brew cask cleanup
brew cleanup
