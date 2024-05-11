#!/usr/bin/env bash
set -e

# see: https://manpages.ubuntu.com/manpages/focal/man1/xscreensaver.1.html
sudo apt-get remove gnome-screensaver
sudo apt-get install -q -y   xscreensaver xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra xscreensaver-screensaver-bsod xscreensaver-screensaver-dizzy
