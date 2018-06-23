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

# Run an install with both pip2 and pip3
pip2and3 () {
    set +v
    pip2 "$@"
    pip3 "$@"
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
brew cask install discord
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
brew install      python     # Installs Python 3
brew install      python@2   # Installs Python 2
pip2and3 install  pip setuptools wheel virtualenv --upgrade
pip2and3 install  ansible --upgrade
pip2and3 install  pipenv --upgrade
pip2and3 install  python-language-server --upgrade
pip2and3 install  isort --upgrade
brew install      ruby
brew install      rust
brew install      scala
brew install      sbt

### Programming and Ops Stuff
brew cask install atom
apm install       sync-settings
brew cask install docker
brew install      git
# brew install      git-annex
brew install      git-lfs
gem install       jekyll
brew install      postgresql
brew cask install pg-commander
pip2and3 install  pre-commit --upgrade
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
brew cask install meshmixer

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
