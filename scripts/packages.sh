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

### Update known packages
brew update

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/clean_old_packages.sh"

### Upgrade all installed packages
brew upgrade


## Install/Update Packages
### General Computer Stuff
brew cask install android-file-transfer
brew install      awk
brew install      bash
brew cask install deluge
brew cask install dropbox
brew cask install firefox
brew cask install caskroom/fonts/font-inconsolata
brew cask install caskroom/fonts/font-inconsolata-dz
brew cask install gimp
brew cask install google-chrome
brew install      gnupg2
brew install      gnu-sed --with-default-names
brew install      grep --with-default-names
# brew install      htop  Temporarily disabled due to high sierra incompatiblity
brew cask install iterm2
brew install      iperf3
brew cask install limechat
brew cask install keepassxc
brew install      mtr
brew install      md5sha1sum
brew install      nmap
brew install      openssl
brew install      rsync
brew cask install slack
brew install      ssh-copy-id
brew install      tree
brew install      vim
brew install      whois
brew install      zsh
brew install      zsh-completions

### Languages and Language Tools
brew install      go --cross-compile-common
brew install      groovy
brew cask install java
brew install      php
brew install      python@2
brew install      python3
pip2 install      pip setuptools wheel --upgrade
pip2 install      pipenv --upgrade
pip2 install      python-language-server --upgrade
pip2 install      isort --upgrade
brew install      ruby
brew install      rust
brew install      scala
brew install      sbt

### Programming and Ops Stuff
pip2 install      ansible --upgrade
brew cask install atom
apm install       sync-settings
pip2 install      awscli --upgrade
pip2 install      boto --upgrade
pip2 install      boto3 --upgrade
pip2 install      docker --upgrade
brew cask install docker
brew install      git
brew install      git-annex
brew install      git-lfs
gem install       jekyll
pip2 install      molecule --upgrade
brew install      postgresql
brew cask install pg-commander
brew cask install sourcetree
brew install      terraform
brew install      unison
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vagrant
vagrant_plugin_install vagrant-vbguest
vagrant_plugin_install vagrant-aws
vagrant plugin update
brew install      vault
brew install      watch

### Hardware Development Stuff
brew cask install arduino
brew cask install kicad

### Recreational Stuff
brew cask install steam
brew cask install battle-net
brew install      libao --HEAD  # for pianobar
brew install      pianobar
brew cask install spotify
brew cask install vox
brew cask install xscreensaver

## Clean up package caches and such
brew cleanup
brew cask cleanup

## Debug print some information
brew list --pinned
brew doctor
echo "Outdated cask packages (not super reliable):"
brew cask outdated
