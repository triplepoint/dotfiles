#!/usr/bin/env bash

source "${BASH_SOURCE%/*}../global/_functions.sh"
source "${BASH_SOURCE%/*}/_functions.sh"

# Stop on any error, print all commands
set -ev

# Set up some additional package repositories
echo "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu disco main" | sudo tee /etc/apt/sources.list.d/dropbox.list
echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt-get update

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/_packages_clean.sh"

sudo apt-get dist-upgrade

# ## Install/Update Packages
# ### General Computer Stuff
# brew_cask_install android-file-transfer
# brew_cask_install homebrew/cask-fonts/font-inconsolata
# brew_cask_install calibre
sudo apt-get install -y   deluge
sudo snap install         discord
sudo apt-get install -y   dropbox
        # brew_cask_install firefox
sudo snap install         gimp
# brew_cask_install google-chrome
sudo snap install         keepassxc
# apt-get install libreoffice            # sorta already installed, but not as a single package?
# brew_cask_install skype
sudo snap install         slack --classic
        # brew_cask_install thunderbird
# brew_cask_install tor-browser
sudo apt-get install -y   xscreensaver

# ### Recreational Stuff
# brew_cask_install battle-net
sudo apt-get install -y   pianobar
sudo apt-get install -y   steam
# brew_cask_install vlc
        # brew_cask_install vox

# ### Terminals, Shells, and Command Line Utilities
sudo apt-get install -y   curl
sudo apt-get install -y   htop
sudo apt-get install -y   iperf3
sudo apt-get install -y   nmap
sudo apt-get install -y   tree
sudo apt-get install -y   tmux
sudo apt-get install -y   vim
sudo apt-get install -y   whois
sudo apt-get install -y   zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ### Languages and Language Tools
# brew_cask_install adoptopenjdk       # Should be installed before JVM languages like scala and groovy
# brew_install pyenv
# source "${BASH_SOURCE%/*}/../global/python/_packages_python3.sh"
# # source "${BASH_SOURCE%/*}/../global/python/_packages_python2.sh"  # Be sure to run this after the python3 setup above, since it sets up pyenv globals for both languages
# # source "${BASH_SOURCE%/*}/../global/_packages_rust.sh"


# ### Programming and Ops Stuff
# brew_install      awscli
sudo snap install         dbeaver-ce
sudo snap install         docker
        # brew_install      git
        # brew_install      git-lfs
# brew_install      graphviz
# brew_install      kubernetes-helm # kubernetes needs to be enabled in Docker manually
# brew_install      mosquitto
# brew_install      postgresql  # python's psycopg2 expects this to be here
# brew_cask_install sourcetree
# brew_install      terraform
# brew_install      terragrunt
# brew_install      unison
# brew_cask_install virtualbox
# brew_cask_install virtualbox-extension-pack
# brew_cask_install vagrant
# vagrant_plugin_install vagrant-hostmanager
# vagrant_plugin_install vagrant-vbguest
# vagrant plugin update
# brew_install      vault
sudo snap install        code  # visual-studio-code
code --install-extension shan.code-settings-sync # VS Code plugin, for storing settings in github gists
        # brew_install      watch

# ### Hardware Development Stuff
# brew_cask_install arduino
# brew_install arduino-cli
# brew_cask_install autodesk-fusion360
# brew_cask_install blender
# brew_cask_install freecad
sudo apt-get install -y  kicad
# brew_cask_install meshmixer
sudo apt-get install -y  openscad
sudo apt-get install -y  prusa-slicer
