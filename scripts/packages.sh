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
brew tap homebrew/versions
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

### Update known packages
brew update

### Upgrade all installed packages
brew upgrade --all


## Install/Update Packages
### Languages and Language Tools
brew install      go --cross-compile-common
brew install      groovy
brew cask install java
brew install      python
pip install       pip --upgrade
brew install      ruby
brew install      rust
brew install      scala

### General Programming Stuff
brew install      ansible
#brew install      ansible19
brew cask install atom
pip install       awscli --upgrade
pip install       boto3 --upgrade
pip install       docker-py --upgrade
#brew cask install dockertoolbox
brew install      git
brew install      git-annex
brew cask install github-desktop
brew install      homebrew/dupes/grep --with-default-names
brew install      htop
gem install       jekyll
brew cask install pgadmin3
brew install      ssh-copy-id
brew cask install sublime-text3
brew cask install sourcetree
brew install      terraform
brew install      tree
brew install      unison
brew install      vim
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vagrant
vagrant_plugin_install vagrant-vbguest
vagrant_plugin_install vagrant-aws
vagrant plugin update

### Hardware development stuff
brew cask install arduino
brew cask install openscad
brew cask install kicad

### General desktop stuff
brew cask install adium
brew install      bash-completion
brew cask install crashplan
brew cask install deluge
brew cask install dropbox
brew cask install firefox
brew cask install flux
brew cask install font-inconsolata
brew cask install font-inconsolata-dz
brew cask install functionflip
brew cask install google-chrome
brew install      gnupg
brew cask install iterm2-beta
brew cask install keepassx
brew cask install karabiner
brew install      nmap
brew cask install shades
brew cask install slack
brew install      zsh

### "Other stuff"
brew install openssl
brew cask install steam
brew cask install battle-net
brew install      pianobar
brew cask install spotify
brew cask install xscreensaver


## Clean up package caches and such
brew cleanup
brew cask cleanup
