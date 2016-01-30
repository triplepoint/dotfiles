#!/usr/bin/env bash

# Don't reinstall Vagrant plugins, if they're already installed
# We can always call `vagrant plugin update` explicitly.
vagrant_plugin_install () {
  set +v
  installed_packages=$(vagrant plugin list | cut -f1 -d' ')
  if ! [[ $installed_packages =~ (^|[[:space:]])"$1"($|[[:space:]]) ]]; then
    vagrant plugin install $1
  else
    echo $'\e[4m''Notice'$'\e[0m'": Vagrant plugin '$1' is already installed.  Use 'vagrant plugin update $1' to force an upgrade."
  fi
  set -v
}

# Stop on any error, print all commands
set -ev
# Install and/or update a collection of useful OSX packages

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
brew cask install font-inconsolata
brew cask install font-inconsolata-dz
brew install      git
brew install      git-annex
brew cask install github-desktop
brew install      htop
brew cask install pgadmin3
brew install      python
brew install      ssh-copy-id
brew cask install sublime-text-dev
brew cask install sourcetree
brew install      tree
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vagrant
vagrant_plugin_install vagrant-vbguest
vagrant_plugin_install vagrant-aws
# vagrant_plugin_install vagrant-berkshelf
vagrant plugin update

### General desktop stuff
brew cask install adium
brew install      bash-completion
brew cask install crashplan
brew cask install deluge
brew cask install dropbox
brew cask install firefox
brew cask install flux
brew cask install functionflip
brew cask install google-chrome
brew install      gnupg
brew cask install iterm2-beta
brew cask install keepassx0
brew cask install karabiner
brew install      nmap
brew cask install shades
brew install      zsh

### "Other stuff"
brew cask install steam
brew cask install spotify
brew cask install xscreensaver


## Clean up package caches and such
brew cask cleanup
brew cleanup
