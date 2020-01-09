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

# Install homebrew, if it isn't already installed
command -v brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Turn off homebrew analytics gathering
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


## Install/Update Packages
### General Computer Stuff
brew cask install android-file-transfer
brew cask install homebrew/cask-fonts/font-inconsolata
brew cask install deluge
brew cask install discord
brew cask install dropbox
brew cask install firefox
brew cask install gimp
brew cask install google-chrome
brew cask install keepassxc
brew cask install libreoffice
brew install      openssl
brew cask install slack
brew install      tcl-tk
brew cask install thunderbird
brew cask install tor-browser
brew cask install xscreensaver

### Recreational Stuff
brew cask install battle-net
brew install      libao --HEAD  # for pianobar
brew install      pianobar
brew cask install steam
brew cask install vlc
brew cask install vox

### Terminals, Shells, and Command Line Utilities
brew install      automake
brew install      bash
brew install      binutils
brew install      coreutils
brew install      gawk
brew install      gnu-sed
brew install      gnupg
ln -s /usr/local/bin/gpg /usr/local/bin/gpg2   || true
brew install      grep
brew install      htop
brew install      iperf3
brew cask install iterm2
brew install      mtr
brew install      nmap
brew install      rename
brew install      rsync
brew install      ssh-copy-id
brew install      tree
brew install      vim
brew install      wget
brew install      whois
brew install      zsh

### Languages and Language Tools
brew cask install adoptopenjdk       # Should be installed before JVM languages like scala and groovy
source "${BASH_SOURCE%/*}/python/_packages_python3.sh"
# source "${BASH_SOURCE%/*}/python/_packages_python2.sh"  # Be sure to run this after the python3 setup above, since it sets up pyenv globals for both languages
# source "${BASH_SOURCE%/*}/_packages_rust.sh"


### Programming and Ops Stuff
brew install      awscli
brew cask install dbeaver-community
brew cask install docker
brew install      git
brew install      git-lfs
brew install      graphviz
brew install      kubernetes-helm # kubernetes needs to be enabled in Docker manually
brew install      mosquitto
brew install      postgresql  # python's psycopg2 expects this to be here
brew cask install sourcetree
brew install      terraform
brew install      terragrunt
brew install      unison
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vagrant
vagrant_plugin_install vagrant-hostmanager
vagrant_plugin_install vagrant-vbguest
vagrant plugin update
brew install      vault
brew cask install visual-studio-code
code --install-extension shan.code-settings-sync # VS Code plugin, for storing settings in github gists
brew install      watch
brew cask install wireshark

### Hardware Development Stuff
brew cask install arduino
brew install arduino-cli
brew cask install autodesk-fusion360
brew cask install blender
brew cask install freecad
brew cask install kicad
brew cask install meshmixer
brew cask install openscad
brew cask install prusaslicer


## Clean up package caches and such
brew cleanup


## Anything wrong with brew?
brew doctor        || true


## Any pinned brew packages, as a reminder to review them:
brew list --pinned || true


## Outdated cask packages (not super reliable):
brew cask outdated || true
