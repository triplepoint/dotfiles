#!/usr/bin/env bash

# Don't reinstall Vagrant plugins, if they're already installed
# We can always call `vagrant plugin update` explicitly.
vagrant_plugin_install () {
  set +v
  if grep --quiet "$1" "${BASH_SOURCE%/*}/vagrant_installed_packages.txt"; then
    echo $'    \e[4m''Notice'$'\e[0m'": Vagrant plugin '$1' is already installed.  Use 'vagrant plugin update $1' to force an upgrade."
  else
    vagrant plugin install $1
  fi
  set -v
}
