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
brew tap caskroom/fonts
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# Development stuff
brew install      ansible
brew cask install dockertoolbox
brew install      git
brew cask install font-inconsolata
brew cask install font-inconsolata-dz
brew cask install pgadmin3
brew install      python
#brew cask install pycharm-ce
brew install      ssh-copy-id
brew cask install sublime-text3
brew cask install sourcetree
brew install      tree
brew cask install vagrant  # Also installs Virtualbox
brew cask install totalterminal


# General desktop stuff
brew cask install adium
brew install      bash-completion
brew cask install deluge
brew cask install dropbox
brew cask install crashplan
brew cask install firefox
brew cask install flux
brew cask install google-chrome
brew install      gnupg
brew cask install keepassx0
brew cask install karabiner
brew install      nmap
brew install      zsh


# Other stuff
brew cask install steam
brew cask install spotify
brew cask install github-desktop


# Clean up caches and such
brew cask cleanup
brew cleanup
