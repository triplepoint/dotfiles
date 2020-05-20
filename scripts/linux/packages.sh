#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/../global/_functions.sh"
source "${BASH_SOURCE%/*}/_functions.sh"

# Stop on any error, print all commands
set -ev

# Set up some additional package repositories
echo "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu disco main" > /etc/apt/sources.list.d/dropbox.list
echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

apt-get update

### Call the "remove" file, to remove previously installed packages
source "${BASH_SOURCE%/*}/_packages_clean.sh"

apt-get dist-upgrade

# ## Install/Update Packages
# ### General Computer Stuff
# brew_cask_install android-file-transfer
# brew_cask_install homebrew/cask-fonts/font-inconsolata
# brew_cask_install calibre
apt-get install -y   deluge
snap install         discord
apt-get install -y   dropbox
        # brew_cask_install firefox      # already installed by default
snap install         gimp
apt-get install -y   gnome-tweak-tool
# snap install         chromium
snap install         keepassxc
        # apt-get install libreoffice            # sorta already installed, but not as a single package?
snap install         skype --classic
snap install         slack --classic
        # brew_cask_install thunderbird   # already installed by default
# brew_cask_install tor-browser
apt-get install -y   xscreensaver

# ### Recreational Stuff
# brew_cask_install battle-net
apt-get install -y   pianobar
apt-get install -y   steam
# brew_cask_install vlc
        # brew_cask_install vox

# ### Terminals, Shells, and Command Line Utilities
apt-get install -y   curl
apt-get install -y   guake
apt-get install -y   htop
apt-get install -y   iperf3
apt-get install -y   nmap
apt-get install -y   tree
apt-get install -y   tmux
apt-get install -y   vim
apt-get install -y   whois
apt-get install -y   zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ### Languages and Language Tools
# brew_cask_install adoptopenjdk       # Should be installed before JVM languages like scala and groovy
# curl https://pyenv.run | bash   # Like a fool
# apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git  # Needed for python to build
source "${BASH_SOURCE%/*}/../global/python/_packages_python3.sh"
# # source "${BASH_SOURCE%/*}/../global/_packages_rust.sh"


# ### Programming and Ops Stuff
apt-get install -y   awscli
snap install         dbeaver-ce
apt-get install -y   docker.io
        # brew_install      git
        # brew_install      git-lfs
# brew_install      graphviz
# brew_install      kubernetes-helm # kubernetes needs to be enabled in Docker manually
apt-get install -y   mosquitto-clients
# brew_install      postgresql  # python's psycopg2 expects this to be here
        # brew_cask_install sourcetree
# brew_install      terraform
# brew_install      terragrunt
# brew_install      unison
# apt-get install -y  virtualbox
# apt-get install -y  virtualbox-ext-pack
# apt-get install -y  vagrant
# vagrant_plugin_install vagrant-hostmanager
# vagrant_plugin_install vagrant-vbguest
# vagrant plugin update
# brew_install      vault
apt-get install -y  code  # visual-studio-code
code --install-extension shan.code-settings-sync # VS Code plugin, for storing settings in github gists
        # brew_install      watch

# ### Hardware Development Stuff
# brew_cask_install arduino
# brew_install arduino-cli
        # brew_cask_install autodesk-fusion360
# snap install blender --classic
snap install        freecad
apt-get install -y  kicad
# brew_cask_install meshmixer
apt-get install -y  openscad
# apt-get install -y  prusa-slicer  # This was out of date.  Use the .appimage from the https://www.prusa3d.com/drivers/ site instead
