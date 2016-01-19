#!/usr/bin/env bash
set -ev

# Install and/or update a collection of useful OSX applications

## Repository management
### Install brew taps
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

### Update known packages
brew update

### Upgrade all installed packages
brew upgrade --all


## Install/Update Packages
### Development stuff
brew install      ansible
brew cask install dockertoolbox
brew install      git
brew install      git-annex
brew install      htop
brew cask install font-inconsolata
brew cask install font-inconsolata-dz
brew cask install pgadmin3
brew install      python
brew install      ssh-copy-id
brew cask install sublime-text-dev
brew cask install sourcetree
brew install      tree
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vagrant

### General desktop stuff
brew cask install adium
brew install      bash-completion
brew cask install deluge
brew cask install dropbox
brew cask install crashplan
brew cask install firefox
brew cask install flux
brew cask install google-chrome
brew install      gnupg
brew cask install iterm2-beta
brew cask install keepassx0
brew cask install karabiner
brew install      nmap
brew install      zsh
brew cask install functionflip
brew cask install shades

### "Other stuff"
brew cask install steam
brew cask install spotify
brew cask install pandora
brew cask install github-desktop
brew cask install xscreensaver


## Clean up package caches and such
brew cask cleanup
brew cleanup
