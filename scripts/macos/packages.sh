#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/../global/_functions.sh"
source "${BASH_SOURCE%/*}/_functions.sh"

# Stop on any error, print all commands
set -ev

# Install x-code command-line developer tools, if they aren't already installed
xcode-select --install || true

# Install the SDK header files if they're not already installed (needed for building Python)
# This is currently set up for Catalina, but it doesn't actually work.  Without formatting a new Mac and trying
# to get to the bottom of the Right Way to do this, I don't see a way to properly test building Python and
# determining which dependency headers need to be in place.  For now, I'll just disable this, and I'll fix it
# if and when I have trouble with another fresh Mac install.
# if ! pkgutil --pkgs | grep -q 'com.apple.pkg.CLTools_Executables'; then
#     sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.15.pkg -target /
# fi

# Run a MacOS software update
softwareupdate --install --all

# Install Homebrew, if it isn't already installed
command -v brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Turn off Homebrew analytics gathering
brew analytics off

# Install and/or update a collection of useful OSX packages
## Repository management
### Install brew taps
brew tap homebrew/cask

### Update known packages
brew update

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/_packages_clean.sh"

### Upgrade all installed packages
brew upgrade
brew upgrade --cask

### Snapshot the names of installed packages in the various packaging tools
cache_installed_packages

## Install/Update Packages
### General Computer Stuff
brew_cask_install android-file-transfer
brew_cask_install homebrew/cask-fonts/font-inconsolata
brew_cask_install calibre
brew_cask_install deluge
brew_cask_install discord
brew_cask_install dropbox
brew_cask_install firefox
brew_cask_install gimp
brew_cask_install google-chrome
brew_cask_install keepassxc
brew_cask_install libreoffice
brew_install      openssl
brew_cask_install rectangle
brew_cask_install signal
brew_cask_install skype
brew_cask_install slack
brew_cask_install syncthing
brew_install      tcl-tk
brew_cask_install thunderbird
brew_cask_install tor-browser
brew_cask_install xscreensaver

### Recreational Stuff
brew_cask_install battle-net
brew_install      libao --HEAD  # for pianobar
brew_install      pianobar
brew_cask_install steam
brew_cask_install vlc
brew_cask_install vox

### Terminals, Shells, and Command Line Utilities
brew_install      automake
brew_install      bash
brew_install      binutils
brew_install      coreutils
brew_install      gawk
brew_install      gnu-sed
brew_install      gnupg
ln -s /usr/local/bin/gpg /usr/local/bin/gpg2   || true
brew_install      grep
brew_install      htop
brew_install      iperf3
brew_cask_install iterm2
brew_install      mtr
brew_install      netcat
brew_install      nmap
brew_install      rename
brew_install      rsync
brew_install      ssh-copy-id
brew_install      telnet
brew_install      tree
brew_install      tmux
brew_install      vim
brew_install      wget
brew_install      whois
brew_install      wireguard-tools
brew_install      zsh

### Languages and Language Tools
brew_cask_install adoptopenjdk       # Should be installed before JVM languages like scala and groovy
brew_install pyenv
source "${BASH_SOURCE%/*}/../global/python/_packages_python3.sh"
# source "${BASH_SOURCE%/*}/../global/python/_packages_python2.sh"  # Be sure to run this after the python3 setup above, since it sets up pyenv globals for both languages
# source "${BASH_SOURCE%/*}/../global/_packages_rust.sh"


### Programming and Ops Stuff
brew_install      awscli
brew_cask_install balenaetcher
brew_cask_install dbeaver-community
brew_cask_install docker
brew_install      git
brew_install      git-lfs
brew_install      graphviz
brew_install      kubernetes-helm  # kubernetes needs to be enabled in Docker manually
brew_install      mosquitto
brew_install      postgresql  # python's psycopg2 expects this to be here
brew_cask_install sourcetree
brew_install      terraform
brew_install      terragrunt
brew_cask_install virtualbox
brew_cask_install virtualbox-extension-pack
brew_cask_install vagrant
brew_install      vault
brew_cask_install visual-studio-code
brew_install      watch

### Hardware Development Stuff
brew_cask_install arduino
brew_install arduino-cli
brew_cask_install autodesk-fusion360
brew_cask_install blender
brew_cask_install freecad
brew_cask_install kicad
brew_cask_install meshmixer
brew_cask_install openscad
brew_cask_install prusaslicer


## Clean up package caches and such
brew cleanup


## Anything wrong with brew?
brew doctor        || true


## Any pinned brew packages, as a reminder to review them:
brew list --pinned || true


## Outdated cask packages (not super reliable):
brew outdated --cask || true
