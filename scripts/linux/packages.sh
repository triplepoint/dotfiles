#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/../global/_functions.sh"
source "${BASH_SOURCE%/*}/_functions.sh"

# Stop on any error, print all commands
set -ev

# Set up some additional package repositories
[ -d /etc/apt/keyrings ] || sudo mkdir -p /etc/apt/keyrings

# Dbeaver
sudo add-apt-repository -y -n ppa:serge-rider/dbeaver-ce

# Docker
download_if_not_exists_with_gpg_dearmor /etc/apt/keyrings/docker.gpg https://download.docker.com/linux/ubuntu/gpg
write_if_not_exists /etc/apt/sources.list.d/docker.list "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Git
sudo add-apt-repository -y -n ppa:git-core/ppa

# Guake
sudo add-apt-repository -y -n ppa:linuxuprising/guake

# Hashicorp / Terraform, etc
download_if_not_exists_with_gpg_dearmor /etc/apt/keyrings/hashicorp-archive-keyring.gpg https://apt.releases.hashicorp.com/gpg
write_if_not_exists /etc/apt/sources.list.d/hashicorp.list "deb [signed-by=/etc/apt/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
write_if_not_exists /etc/apt/preferences.d/99hashicorp-vagrant "Package: vagrant terraform
Pin: origin apt.releases.hashicorp.com
Pin-Priority: 900"

# KeepassXC
sudo add-apt-repository -y -n ppa:phoerious/keepassxc

# Mozilla / Firefox
sudo add-apt-repository -y -n ppa:mozillateam/ppa
write_if_not_exists /etc/apt/preferences.d/mozilla-firefox "Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001"

# # Postgresql
# download_if_not_exists_with_gpg_dearmor /etc/apt/keyrings/packages-pgadmin-org.gpg https://www.pgadmin.org/static/packages_pgadmin_org.pub
# write_if_not_exists /etc/apt/sources.list.d/pgadmin.list "deb [signed-by=/etc/apt/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main"

# Signal
download_if_not_exists_with_gpg_dearmor /etc/apt/keyrings/signal-desktop-keyring.gpg https://updates.signal.org/desktop/apt/keys.asc
write_if_not_exists /etc/apt/sources.list.d/signal-xenial.list "deb [arch=amd64 signed-by=/etc/apt/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main"

# Syncthing
download_if_not_exists /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
write_if_not_exists /etc/apt/sources.list.d/syncthing.list "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable"

# Microsoft / VSCode
download_if_not_exists_with_gpg_dearmor /etc/apt/keyrings/packages.microsoft.gpg https://packages.microsoft.com/keys/microsoft.asc
write_if_not_exists /etc/apt/sources.list.d/vscode.list "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main"

sudo apt update

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/_packages_clean.sh"

sudo apt full-upgrade
sudo snap set system refresh.retain=2
sudo snap refresh

# ## Install/Update Packages
# ### General Computer Stuff
# brew_cask_install android-file-transfer
sudo apt install -q -y   fonts-inconsolata
# brew_cask_install calibre
sudo apt install -q -y   deluge
sudo snap install        discord
sudo apt install -q -y   firefox
sudo snap install        gimp
sudo apt install -q -y   keepassxc
sudo apt install -q -y   signal-desktop

# see: https://slack.com/intl/en-in/downloads/instructions/ubuntu, see the Try Again link
SLACK_VER=4.33.84
install_deb              https://downloads.slack-edge.com/releases/linux/${SLACK_VER}/prod/x64/slack-desktop-${SLACK_VER}-amd64.deb slack

sudo apt install -q -y   syncthing
systemctl                --user enable syncthing.service
systemctl                --user start syncthing.service
sudo apt install -q -y   thunderbird
# brew_cask_install tor-browser
sudo apt install -q -y   ubuntu-restricted-extras
sudo apt install -q -y   libegl1-mesa libgl1-mesa-glx libxcb-xtest0 libxcb-cursor0  # Zoom dependencies
install_deb              https://zoom.us/client/latest/zoom_amd64.deb zoom

# see: https://github.com/TheAssassin/AppImageLauncher/releases, find "amd64.deb"
install_deb              https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb  # AppImage Launcher

# source "${BASH_SOURCE%/*}/_xscreensaver.sh"

# source "${BASH_SOURCE%/*}/_cyberpower.sh"

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
sudo apt install -q -y   dbeaver-ce
sudo apt install -q -y   docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt install -q -y   git
sudo apt install -q -y   git-lfs
sudo apt install -q -y   gitg
# brew_install      graphviz
sudo snap install        helm  --classic
sudo snap install        kubectl  --classic
sudo apt install -q -y   mosquitto-clients
# sudo apt install -q -y   postgresql-client
sudo snap install        postman
# sudo apt install -q -y   pgadmin4-desktop
sudo apt install -q -y   terraform
sudo snap install        terragrunt
sudo apt install -q -y   virtualbox
sudo apt install -q -y   virtualbox-ext-pack
sudo apt install -q -y   vagrant
sudo apt install -q -y   vault
sudo apt install -q -y   code

# see: https://obsidian.md/download
OBSIDIAN_VER=1.3.7
install_app_image        https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VER}/Obsidian-${OBSIDIAN_VER}.AppImage


# see: https://etcher.balena.io/#download-etcher
BALENA_VER=1.18.11
install_app_image        https://github.com/balena-io/etcher/releases/download/v${BALENA_VER}/balenaEtcher-${BALENA_VER}-x64.AppImage

# ### Hardware Development Stuff
# sudo snap install        blender --classic
# sudo snap install        freecad

# see: https://www.arduino.cc/en/software
install_app_image        https://downloads.arduino.cc/arduino-ide/arduino-ide_2.1.1_Linux_64bit.AppImage

sudo apt install -q -y   gnuradio
sudo apt install -q -y   kicad
sudo apt install -q -y   openscad
sudo apt install -q -y   picocom
install_app_image        https://cdn.prusa3d.com/downloads/drivers/prusa3d_linux_2_6_0.zip
