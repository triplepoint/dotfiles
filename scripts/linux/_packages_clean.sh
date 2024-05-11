#!/usr/bin/env bash
set -e

# sudo apt-get remove -y git-gui
# sudo apt-get remove -y gitk
# sudo snap remove   code
# sudo snap remove   skype
# sudo snap remove   git-cola
# sudo snap remove   blender
# sudo snap remove   freecad

## If snaps exist, these should be removed
#sudo snap remove   firefox
#sudo snap remove   dbeaver-ce
#sudo snap remove   keepassxc
#sudo snap remove   slack

sudo apt-get remove -y docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc  # Old docker packages

sudo apt-get autoremove
sudo apt-get autoclean
