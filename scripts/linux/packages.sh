#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/../global/_functions.sh"
source "${BASH_SOURCE%/*}/_functions.sh"

# Stop on any error, print all commands
set -ev

# Set up some additional package repositories
# add_pgp_key FC918B335044912E
# write_if_not_exists /etc/apt/sources.list.d/dropbox.list "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu disco main"

download_if_not_exists /etc/apt/trusted.gpg.d/hashicorp.asc https://apt.releases.hashicorp.com/gpg
write_if_not_exists /etc/apt/sources.list.d/hashicorp.list "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

download_if_not_exists /etc/apt/trusted.gpg.d/signal-desktop.asc https://updates.signal.org/desktop/apt/keys.asc
write_if_not_exists /etc/apt/sources.list.d/signal-xenial.list "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main"

download_if_not_exists /etc/apt/trusted.gpg.d/syncthing.asc https://syncthing.net/release-key.txt
write_if_not_exists /etc/apt/sources.list.d/syncthing.list "deb https://apt.syncthing.net/ syncthing stable"

sudo apt update

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/_packages_clean.sh"

sudo apt full-upgrade
sudo snap set system refresh.retain=2
sudo snap refresh

### Snapshot the names of installed packages in the various packaging tools
cache_installed_packages

# ## Install/Update Packages
# ### General Computer Stuff
# brew_cask_install android-file-transfer
sudo apt install -q -y   fonts-inconsolata
# brew_cask_install calibre
sudo apt install -q -y   deluge
sudo snap install         discord
# sudo apt install -q -y   dropbox
sudo apt install -q -y   firefox
sudo snap install         gimp
sudo snap install         keepassxc
sudo apt install -q -y   signal-desktop
sudo snap install         slack --classic
sudo apt install -q -y   syncthing
sudo apt install -q -y   thunderbird
# brew_cask_install tor-browser
sudo apt install -q -y   ubuntu-restricted-extras
sudo apt install -q -y   libegl1-mesa libgl1-mesa-glx libxcb-xtest0  # Zoom dependencies
install_deb              https://zoom.us/client/latest/zoom_amd64.deb zoom
install_deb              https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb


# ### Recreational Stuff
# brew_cask_install battle-net
sudo apt install -q -y   pianobar
sudo apt install -q -y   steam
# brew_cask_install vlc
        # brew_cask_install vox

# ### Terminals, Shells, and Command Line Utilities
sudo apt install -q -y   curl
sudo apt install -q -y   guake
sudo apt install -q -y   htop
sudo apt install -q -y   iperf3
sudo apt install -q -y   nfs-common
sudo apt install -q -y   nmap
sudo apt install -q -y   sshpass
sudo apt install -q -y   tree
sudo apt install -q -y   tmux
sudo apt install -q -y   vim
sudo apt install -q -y   whois
source "${BASH_SOURCE%/*}/_zsh.sh"

# ### Languages and Language Tools
sudo apt install -q -y   openjdk-17-jdk       # Should be installed before JVM languages like scala and groovy
source "${BASH_SOURCE%/*}/_pyenv.sh"
source "${BASH_SOURCE%/*}/../global/python/_packages_python3.sh"
# source "${BASH_SOURCE%/*}/../global/_packages_rust.sh"


# ### Programming and Ops Stuff
sudo apt install -q -y   awscli
sudo snap install         dbeaver-ce
sudo apt install -q -y   docker.io
sudo apt install -q -y   docker-compose
sudo apt install -q -y   git
sudo apt install -q -y   git-lfs
sudo apt install -q -y   gitg
sudo apt install -q -y   git-gui
# brew_install      graphviz
sudo snap install helm  --classic
sudo snap install kubectl  --classic
sudo apt install -q -y   mosquitto-clients
# sudo apt install -q -y   postgresql-client
sudo apt install -q -y   gitg
sudo apt install -q -y   terraform
sudo snap install         terragrunt
sudo apt install -q -y   virtualbox
sudo apt install -q -y   virtualbox-ext-pack
sudo apt install -q -y   vagrant
sudo apt install -q -y   vault
install_deb              https://go.microsoft.com/fwlink/?LinkID=760868 code
install_app_image        https://github.com/logseq/logseq/releases/download/0.6.1/Logseq-linux-x64-0.6.1.AppImage

# ### Hardware Development Stuff
# brew_cask_install arduino
# brew_install arduino-cli
        # brew_cask_install autodesk-fusion360
# sudo snap install blender --classic
sudo snap install         freecad
sudo apt install -q -y   gnuradio
sudo apt install -q -y   kicad
# brew_cask_install meshmixer
sudo apt install -q -y   openscad
install_app_image        https://www.prusa3d.com/downloads/drivers/prusa3d_linux_2_4_0.zip
