#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/../global/_functions.sh"
source "${BASH_SOURCE%/*}/_functions.sh"

# Stop on any error, print all commands
set -ev

### Set up some additional package repositories
# A note on keyrings: https://askubuntu.com/a/1307181
#   TL;DR: don't set up universally trusted keys in /etc/apt/trusted.gpg*,
#   instead have a PPA explicitly trust a file in /etc/apt/keyrings/

# Dbeaver
# sudo add-apt-repository -y -n ppa:serge-rider/dbeaver-ce

# Git
sudo add-apt-repository -y -n ppa:git-core/ppa

# Guake - Not needed as of Ubuntu Mantic 23.10
# sudo add-apt-repository -y -n ppa:linuxuprising/guake

# KeepassXC
sudo add-apt-repository -y -n ppa:phoerious/keepassxc

# Mozilla / Firefox (and prioritize over the ubuntu 1st party Snap trojan package)
# download_if_not_exists /etc/apt/keyrings/packages.mozilla.org.asc https://packages.mozilla.org/apt/repo-signing-key.gpg
# write_if_not_exists /etc/apt/sources.list.d/archive_uri-https_packages_mozilla_org_apt-$(lsb_release -cs).list \
#   "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main"
# write_if_not_exists /etc/apt/preferences.d/mozilla-firefox \
# "Package: firefox*
# Pin: release o=Ubuntu*
# Pin-Priority: -1"

# Docker
download_if_not_exists /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
write_if_not_exists /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-$(lsb_release -cs).list \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable"

# Google Chrome
# The first time download and install the deb manually from https://www.google.com/chrome - it'll install its own ppa

# Hashicorp / Terraform, etc
download_if_not_exists_with_gpg_dearmor /etc/apt/keyrings/hashicorp-archive-keyring.gpg https://apt.releases.hashicorp.com/gpg
write_if_not_exists /etc/apt/sources.list.d/archive_uri-https_apt_releases_hashicorp_com-$(lsb_release -cs).list \
  "deb [signed-by=/etc/apt/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
write_if_not_exists /etc/apt/preferences.d/99hashicorp-vagrant \
"Package: vagrant terraform
Pin: origin apt.releases.hashicorp.com
Pin-Priority: 1000"

# # Postgresql
# download_if_not_exists /etc/apt/keyrings/apt.postgresql.org.asc https://www.postgresql.org/media/keys/ACCC4CF8.asc
# write_if_not_exists /etc/apt/sources.list.d/archive_uri-https_apt_postgresql_org_pub_repos_apt-$(lsb_release -cs).list \
#   "deb [signed-by=/etc/apt/keyrings/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main"

# Signal
# download_if_not_exists_with_gpg_dearmor /etc/apt/keyrings/signal-desktop-keyring.gpg https://updates.signal.org/desktop/apt/keys.asc
# write_if_not_exists /etc/apt/sources.list.d/archive_uri-https_updates_signal_org_desktop_apt-$(lsb_release -cs).list \
#   "deb [arch=amd64 signed-by=/etc/apt/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main"

# Syncthing
download_if_not_exists /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
write_if_not_exists /etc/apt/sources.list.d/archive_uri-https_apt_syncthing_net-$(lsb_release -cs).list \
  "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable"

# Microsoft / VSCode
# The first time, download and install the deb manually from https://code.visualstudio.com/ - it'll install its own ppa

sudo apt-get update || true

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/_packages_clean.sh"

sudo apt-get dist-upgrade
# sudo snap set system refresh.retain=2
# sudo snap refresh

# ## Install/Update Packages
# ### General Computer Stuff
sudo apt-get install -q -y   fonts-inconsolata
sudo apt-get install -q -y   deluge
sudo apt-get install -q -y   deja-dup
# sudo apt-get install        discord
sudo apt-get install -q -y   firefox
sudo apt-get install        gimp
sudo apt-get install -q -y   keepassxc
# sudo apt-get install -q -y   signal-desktop

# see: https://slack.com/downloads/instructions/linux?build=deb, see the Try Again link
SLACK_VER=4.38.125
install_deb              https://downloads.slack-edge.com/desktop-releases/linux/x64/${SLACK_VER}/slack-desktop-${SLACK_VER}-amd64.deb slack

sudo apt-get install -q -y   syncthing
systemctl                --user enable syncthing.service
systemctl                --user start syncthing.service
# sudo apt-get install -q -y   thunderbird
# sudo apt-get install -q -y   ubuntu-restricted-extras
sudo apt-get install -q -y   libegl1-mesa libgl1-mesa-glx libxcb-xtest0 libxcb-cursor0 xdg-desktop-portal-gnome # Zoom dependencies
install_deb              https://zoom.us/client/latest/zoom_amd64.deb zoom

# see: https://github.com/TheAssassin/AppImageLauncher/releases, find "amd64.deb"
install_deb              https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb  # AppImage Launcher

# source "${BASH_SOURCE%/*}/_xscreensaver.sh"

# source "${BASH_SOURCE%/*}/_cyberpower.sh"

# ### Recreational Stuff
sudo apt-get install -q -y   pianobar
sudo apt-get install -q -y   steam

# ### Terminals, Shells, and Command Line Utilities
sudo apt-get install -q -y   curl
sudo apt-get install -q -y   guake
sudo apt-get install -q -y   htop
sudo apt-get install -q -y   iperf3
sudo apt-get install -q -y   nfs-common
sudo apt-get install -q -y   nmap
sudo apt-get install -q -y   sshpass
sudo apt-get install -q -y   tree
# sudo apt-get install -q -y   tmux
sudo apt-get install -q -y   vim
sudo apt-get install -q -y   whois
source "${BASH_SOURCE%/*}/_zsh.sh"

# ### Languages and Language Tools
# sudo apt-get install -q -y   openjdk-17-jdk       # Should be installed before JVM languages like scala and groovy
source "${BASH_SOURCE%/*}/_pyenv.sh"
source "${BASH_SOURCE%/*}/../global/python/_packages_python3.sh"
# source "${BASH_SOURCE%/*}/../global/_packages_rust.sh"


# ### Programming and Ops Stuff
sudo apt-get install -q -y   awscli
# sudo apt-get install -q -y   dbeaver-ce
sudo apt-get install -q -y   docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt-get install -q -y   git
sudo apt-get install -q -y   git-lfs
sudo apt-get install -q -y   gitg
# sudo apt-get install        helm  --classic
# sudo apt-get install        kubectl  --classic
sudo apt-get install -q -y   mosquitto-clients
# sudo apt-get install -q -y   postgresql-client
# sudo apt-get install        postman
# sudo apt-get install -q -y   pgadmin4-desktop
sudo apt-get install -q -y   terraform
# sudo apt-get install        terragrunt
sudo apt-get install -q -y   virtualbox virtualbox-ext-pack
sudo apt-get install -q -y   vagrant
# sudo apt-get install -q -y   vault
sudo apt-get install -q -y   code

# see: https://obsidian.md/download
OBSIDIAN_VER=1.6.5
install_app_image        https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VER}/Obsidian-${OBSIDIAN_VER}.AppImage


# see: https://etcher.balena.io/#download-etcher
BALENA_VER=1.19.21
install_app_image        https://github.com/balena-io/etcher/releases/download/v${BALENA_VER}/balenaEtcher-${BALENA_VER}-x64.AppImage

# ### Hardware Development Stuff
# sudo apt-get install        blender --classic
# sudo apt-get install        freecad

# see: https://www.arduino.cc/en/software
ARDUINO_VER=2.3.2
# install_app_image        https://downloads.arduino.cc/arduino-ide/arduino-ide_${ARDUINO_VER}_Linux_64bit.AppImage

# sudo apt-get install -q -y   gnuradio
# sudo apt-get install -q -y   kicad
# sudo apt-get install -q -y   openscad
# sudo apt-get install -q -y   picocom

# see: https://help.prusa3d.com/downloads under MK2.5S
PRUSA_VER=2_7_4
install_app_image        https://cdn.prusa3d.com/downloads/drivers/prusa3d_linux_${PRUSA_VER}.zip

### Let's clean again, just to be sure
source "${BASH_SOURCE%/*}/_packages_clean.sh"
