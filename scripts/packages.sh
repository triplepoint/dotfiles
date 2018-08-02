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
source "${BASH_SOURCE%/*}/_packages_clean.sh"

### Upgrade all installed packages
brew upgrade


## Install/Update Packages
### General Computer Stuff
brew cask install android-file-transfer
brew cask install caskroom/fonts/font-inconsolata
brew cask install caskroom/fonts/font-inconsolata-dz
brew cask install deluge
brew cask install discord
brew cask install dropbox
brew cask install firefox
brew cask install gimp
brew cask install google-chrome
brew cask install keepassxc
brew install      openssl
brew cask install slack
brew cask install xscreensaver

### Recreational Stuff
brew cask install steam
brew cask install battle-net
brew install      libao --HEAD  # for pianobar
brew install      pianobar
brew cask install spotify
brew cask install vox

### Terminals, Shells, and Command Line Utilities
brew install      bash
brew install      gawk
brew install      gnu-sed --with-default-names
brew install      gnupg2
brew install      grep --with-default-names
brew install      iperf3
brew cask install iterm2
brew install      md5sha1sum
brew install      mtr
brew install      nmap
brew install      rename
brew install      rsync
brew install      ssh-copy-id
brew install      tree
brew install      vim
brew install      whois
brew install      zsh
brew install      zsh-completions

### Languages and Language Tools
brew install      go --cross-compile-common
brew cask install java       # Should be installed before JVM languages like scala and groovy
brew install      groovy
brew install      php
brew install      python     # Installs Python 3
brew install      python@2   # Installs Python 2
brew install      scala
source "${BASH_SOURCE%/*}/python/_packages_python.sh"
brew install      ruby
source "${BASH_SOURCE%/*}/_packages_rust.sh"
brew install      sbt        # Tooling for scala, will source Scala itself

### Programming and Ops Stuff
brew cask install atom
apm install       sync-settings    # Atom plugin, for storing settings in github gists
brew cask install docker
brew install      git
brew install      git-lfs
gem install       jekyll
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
brew cask install meshmixer


## Clean up package caches and such
brew cleanup
brew cask cleanup


## Anything wrong with brew?
brew doctor        || true


## Any pinned brew packages, as a reminder to review them:
brew list --pinned || true


## Outdated cask packages (not super reliable):
brew cask outdated || true
