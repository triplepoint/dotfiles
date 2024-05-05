#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/../global/_functions.sh"
source "${BASH_SOURCE%/*}/_functions.sh"

# Stop on any error, print all commands
set -ev

# Set up some additional package repositories
# Dbeaver
# sudo add-apt-repository -y -n ppa:serge-rider/dbeaver-ce

# Git
sudo add-apt-repository -y -n ppa:git-core/ppa

# Guake - Not needed as of Ubuntu Mantic 23.10
# sudo add-apt-repository -y -n ppa:linuxuprising/guake

# KeepassXC
sudo add-apt-repository -y -n ppa:phoerious/keepassxc

# Mozilla / Firefox (and prioritize over the ubuntu 1st party Snap trojan package)
# download_if_not_exists_with_gpg_dearmor /usr/share/keyrings/mozilla.gpg https://packages.mozilla.org/apt/repo-signing-key.gpg
# sudo add-apt-repository -y -n deb https://packages.mozilla.org/apt mozilla main
# sudo sed -i 's/deb h/deb [signed-by=\/usr\/share\/keyrings\/mozilla.gpg] h/g' /etc/apt/sources.list.d/archive_uri-https_packages_mozilla_org_apt-$(lsb_release -cs).list
# write_if_not_exists /etc/apt/preferences.d/mozilla-firefox "Package: *
# Pin: origin packages.mozilla.org
# Pin-Priority: 1000"

# Docker
download_if_not_exists_with_gpg_dearmor /usr/share/keyrings/docker.gpg https://download.docker.com/linux/ubuntu/gpg
sudo add-apt-repository -y -n -U https://download.docker.com/linux/ubuntu -c stable
sudo sed -i 's/deb h/deb [signed-by=\/usr\/share\/keyrings\/docker.gpg] h/g' /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-$(lsb_release -cs).list

# # Google Chrome
# download_if_not_exists_with_gpg_dearmor /usr/share/keyrings/google-chrome.gpg https://dl.google.com/linux/linux_signing_key.pub
# sudo add-apt-repository -y -n deb http://dl.google.com/linux/chrome/deb stable main
# sudo sed -i 's/deb h/deb [arch=amd64 signed-by=\/usr\/share\/keyrings\/google-chrome.gpg] h/g' /etc/apt/sources.list.d/archive_uri-http_dl_google_com_linux_chrome_deb-$(lsb_release -cs).list

# Hashicorp / Terraform, etc
download_if_not_exists_with_gpg_dearmor /usr/share/keyrings/hashicorp-archive-keyring.gpg https://apt.releases.hashicorp.com/gpg
sudo add-apt-repository -y -n -U https://apt.releases.hashicorp.com -c main
sudo sed -i 's/deb h/deb [signed-by=\/usr\/share\/keyrings\/hashicorp-archive-keyring.gpg] h/g' /etc/apt/sources.list.d/archive_uri-https_apt_releases_hashicorp_com-$(lsb_release -cs).list
write_if_not_exists /etc/apt/preferences.d/99hashicorp-vagrant "Package: vagrant terraform
Pin: origin apt.releases.hashicorp.com
Pin-Priority: 1000"

# # Postgresql
# download_if_not_exists_with_gpg_dearmor /usr/share/keyrings/packages-pgadmin-org.gpg https://www.pgadmin.org/static/packages_pgadmin_org.pub
# sudo add-apt-repository -y -n deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main
# sudo sed -i 's/deb h/deb [signed-by=\/usr\/share\/keyrings\/packages-pgadmin-org.gpg] h/g' /etc/apt/sources.list.d/archive_uri-https_apt_postgresql_org_pub_repos_apt-$(lsb_release -cs).list

# Signal
# download_if_not_exists_with_gpg_dearmor /usr/share/keyrings/signal-desktop-keyring.gpg https://updates.signal.org/desktop/apt/keys.asc
# sudo add-apt-repository -y -n deb https://updates.signal.org/desktop/apt xenial main
# sudo sed -i 's/deb h/deb [signed-by=\/usr\/share\/keyrings\/signal-desktop-keyring.gpg] h/g' /etc/apt/sources.list.d/archive_uri-https_updates_signal_org_desktop_apt-$(lsb_release -cs).list

# Syncthing
download_if_not_exists /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
sudo add-apt-repository -y -n deb https://apt.syncthing.net syncthing stable
sudo sed -i 's/deb h/deb [signed-by=\/usr\/share\/keyrings\/syncthing-archive-keyring.gpg] h/g' /etc/apt/sources.list.d/archive_uri-https_apt_syncthing_net-$(lsb_release -cs).list

# Microsoft / VSCode
# The first time, download and install the deb manually from https://code.visualstudio.com/ - it'll install its own ppa
# download_if_not_exists_with_gpg_dearmor /usr/share/keyrings/packages.microsoft.gpg https://packages.microsoft.com/keys/microsoft.asc
# sudo add-apt-repository -y -n deb https://packages.microsoft.com/repos/code stable main
# sudo sed -i 's/deb h/deb [signed-by=\/usr\/share\/keyrings\/packages.microsoft.gpg] h/g' /etc/apt/sources.list.d/archive_uri-https_packages_microsoft_com_repos_code-$(lsb_release -cs).list

sudo apt update || true

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/_packages_clean.sh"

sudo apt full-upgrade
# sudo snap set system refresh.retain=2
# sudo snap refresh

# ## Install/Update Packages
# ### General Computer Stuff
sudo apt install -q -y   fonts-inconsolata
sudo apt install -q -y   deluge
# sudo apt install        discord
sudo apt install -q -y   firefox
sudo apt install        gimp
sudo apt install -q -y   keepassxc
# sudo apt install -q -y   signal-desktop

# see: https://slack.com/intl/en-in/downloads/instructions/ubuntu, see the Try Again link
SLACK_VER=4.37.101
install_deb              https://downloads.slack-edge.com/releases/linux/${SLACK_VER}/prod/x64/slack-desktop-${SLACK_VER}-amd64.deb slack

sudo apt install -q -y   syncthing
systemctl                --user enable syncthing.service
systemctl                --user start syncthing.service
# sudo apt install -q -y   thunderbird
# sudo apt install -q -y   ubuntu-restricted-extras
sudo apt install -q -y   libegl1-mesa libgl1-mesa-glx libxcb-xtest0 libxcb-cursor0 xdg-desktop-portal-gnome # Zoom dependencies
install_deb              https://zoom.us/client/latest/zoom_amd64.deb zoom

# see: https://github.com/TheAssassin/AppImageLauncher/releases, find "amd64.deb"
# install_deb              https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb  # AppImage Launcher

# source "${BASH_SOURCE%/*}/_xscreensaver.sh"

# source "${BASH_SOURCE%/*}/_cyberpower.sh"

# ### Recreational Stuff
sudo apt install -q -y   pianobar
sudo apt install -q -y   steam

# ### Terminals, Shells, and Command Line Utilities
sudo apt install -q -y   curl
# sudo apt install -q -y   guake
sudo apt install -q -y   htop
sudo apt install -q -y   iperf3
sudo apt install -q -y   nfs-common
sudo apt install -q -y   nmap
sudo apt install -q -y   sshpass
sudo apt install -q -y   tree
# sudo apt install -q -y   tmux
sudo apt install -q -y   vim
sudo apt install -q -y   whois
source "${BASH_SOURCE%/*}/_zsh.sh"

# ### Languages and Language Tools
# sudo apt install -q -y   openjdk-17-jdk       # Should be installed before JVM languages like scala and groovy
source "${BASH_SOURCE%/*}/_pyenv.sh"
source "${BASH_SOURCE%/*}/../global/python/_packages_python3.sh"
# source "${BASH_SOURCE%/*}/../global/_packages_rust.sh"


# ### Programming and Ops Stuff
sudo apt install -q -y   awscli
# sudo apt install -q -y   dbeaver-ce
sudo apt install -q -y   docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt install -q -y   git
sudo apt install -q -y   git-lfs
# sudo apt install -q -y   gitg
# sudo apt install        helm  --classic
# sudo apt install        kubectl  --classic
sudo apt install -q -y   mosquitto-clients
# sudo apt install -q -y   postgresql-client
# sudo apt install        postman
# sudo apt install -q -y   pgadmin4-desktop
sudo apt install -q -y   terraform
# sudo apt install        terragrunt
sudo apt install -q -y   virtualbox
sudo apt install -q -y   virtualbox-ext-pack
sudo apt install -q -y   vagrant
# sudo apt install -q -y   vault
sudo apt install -q -y   code

# see: https://obsidian.md/download
OBSIDIAN_VER=1.5.12
install_app_image        https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VER}/Obsidian-${OBSIDIAN_VER}.AppImage


# see: https://etcher.balena.io/#download-etcher
BALENA_VER=1.18.11
install_app_image        https://github.com/balena-io/etcher/releases/download/v${BALENA_VER}/balenaEtcher-${BALENA_VER}-x64.AppImage

# ### Hardware Development Stuff
# sudo apt install        blender --classic
# sudo apt install        freecad

# see: https://www.arduino.cc/en/software
ARDUINO_VER=2.3.2
# install_app_image        https://downloads.arduino.cc/arduino-ide/arduino-ide_${ARDUINO_VER}_Linux_64bit.AppImage

# sudo apt install -q -y   gnuradio
# sudo apt install -q -y   kicad
# sudo apt install -q -y   openscad
# sudo apt install -q -y   picocom

# see: https://help.prusa3d.com/downloads under MK2.5S
PRUSA_VER=2_7_4
install_app_image        https://cdn.prusa3d.com/downloads/drivers/prusa3d_linux_${PRUSA_VER}.zip

### Let's clean again, just to be sure
source "${BASH_SOURCE%/*}/_packages_clean.sh"
