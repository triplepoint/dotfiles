#!/usr/bin/env bash

###
# Install and/or update a collection of useful OSX applications
###

# Update known packages
brew update

# Upgrade all installed packages
brew upgrade --all

# Install cask (to manage OS X application installs)
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# Development stuff
brew install      ansible
brew cask install dockertoolbox
brew install      git
brew install      python
brew install      ssh-copy-id
brew cask install sublime-text3
brew cask install sourcetree
brew install      tree
brew cask install vagrant # Also installs Virtualbox
brew cask install totalterminal


# General desktop stuff
brew cask install adium
brew install      bash-completion
brew cask install deluge
#brew cask install dropbox # test
#brew cask install firefox # test
#brew cask install flux #test
brew cask install google-chrome
brew install      gnupg
brew cask install keepassx
brew cask install karabiner
brew install      nmap
brew install      zsh


# Clean up caches and such
brew cask cleanup
brew cleanup
