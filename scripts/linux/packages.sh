#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/../global/_functions.sh"
source "${BASH_SOURCE%/*}/_functions.sh"

# Stop on any error, print all commands
set -ev

# Set up some additional package repositories
apt-key list|grep "1C61 A265 6FB5 7B7E 4DE0  F4C1 FC91 8B33 5044 912E" || curl -fsSL https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
apt-key list|grep "E8A0 32E0 94D8 EB4E A189  D270 DA41 8C88 A321 9F7B" || curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list
echo "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu disco main" | sudo tee /etc/apt/sources.list.d/dropbox.list
echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/_packages_clean.sh"

sudo apt-get dist-upgrade
sudo snap refresh

### Snapshot the names of installed packages in the various packaging tools
cache_installed_packages

# ## Install/Update Packages
# ### General Computer Stuff
# brew_cask_install android-file-transfer
sudo apt-get install -y   fonts-inconsolata
# brew_cask_install calibre
sudo apt-get install -y   deluge
sudo snap install         discord
sudo apt-get install -y   dropbox
sudo apt-get install -y   firefox
sudo snap install         gimp
sudo apt-get install -y   gnome-tweak-tool
sudo snap install         keepassxc
sudo apt-get install signal-desktop
sudo snap install         skype --classic
sudo snap install         slack --classic
sudo apt-get install -y   thunderbird
# brew_cask_install tor-browser
sudo apt-get install -y   ubuntu-restricted-extras

# ### Recreational Stuff
# brew_cask_install battle-net
sudo apt-get install -y   pianobar
sudo apt-get install -y   steam
# brew_cask_install vlc
        # brew_cask_install vox

# ### Terminals, Shells, and Command Line Utilities
sudo apt-get install -y   curl
sudo apt-get install -y   guake
sudo apt-get install -y   htop
sudo apt-get install -y   iperf3
sudo apt-get install -y   nfs-common
sudo apt-get install -y   nmap
sudo apt-get install -y   tree
sudo apt-get install -y   tmux
sudo apt-get install -y   vim
sudo apt-get install -y   whois
source "${BASH_SOURCE%/*}/_zsh.sh"

# ### Languages and Language Tools
sudo apt-get install -y   openjdk-14-jdk       # Should be installed before JVM languages like scala and groovy
source "${BASH_SOURCE%/*}/_pyenv.sh"
source "${BASH_SOURCE%/*}/../global/python/_packages_python3.sh"
# source "${BASH_SOURCE%/*}/../global/_packages_rust.sh"


# ### Programming and Ops Stuff
sudo apt-get install -y   awscli
sudo snap install         dbeaver-ce
sudo apt-get install -y   docker.io
sudo apt-get install -y   docker-compose
sudo apt-get install -y   git
sudo apt-get install -y   git-lfs
# brew_install      graphviz
# brew_install      kubernetes-helm # kubernetes needs to be enabled in Docker manually
sudo apt-get install -y   mosquitto-clients
# sudo apt-get install -u   postgresql-client
sudo apt-get install -y   gitg
sudo apt-get install -y   terraform
sudo snap install         terragrunt
# brew_install      unison
sudo apt-get install -y   virtualbox
sudo apt-get install -y   virtualbox-ext-pack
sudo apt-get install -y   vagrant
vagrant_plugin_install    vagrant-hostmanager
vagrant_plugin_install    vagrant-vbguest
vagrant plugin update
# brew_install      vault
sudo snap install         code --classic  # visual-studio-code
code --install-extension  shan.code-settings-sync # VS Code plugin, for storing settings in github gists
        # brew_install      watch

# ### Hardware Development Stuff
# brew_cask_install arduino
# brew_install arduino-cli
        # brew_cask_install autodesk-fusion360
# sudo snap install blender --classic
sudo snap install         freecad
sudo apt-get install -y   kicad
# brew_cask_install meshmixer
sudo apt-get install -y   openscad
# sudo apt-get install -y   prusa-slicer  # This was out of date in the apt repos.  Use the .appimage from the https://www.prusa3d.com/drivers/ site instead
