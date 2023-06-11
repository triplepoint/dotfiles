#!/usr/bin/env bash
set -e

# sudo apt remove -y git-gui
# sudo apt remove -y gitk
# sudo snap remove   code
# sudo snap remove   skype
# sudo snap remove   git-cola
# sudo snap remove   blender
# sudo snap remove   freecad
sudo snap remove   firefox
sudo snap remove   dbeaver-ce
sudo snap remove   keepassxc
sudo snap remove   slack

sudo apt autoremove
