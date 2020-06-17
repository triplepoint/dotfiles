#!/usr/bin/env bash

# Dump the list of installed vagrant plugins to a cache file,
# so we can speed up the "do we need to reinstall this"
# process.  Note that the file gets written here, in the scripts/global/
# directory.
cache_installed_vagrant_plugins () {
  set +v
  pushd "${BASH_SOURCE%/*}"

  rm -f \
    vagrant_installed_packages.txt

  vagrant plugin list | cut -f1 -d' ' | sort | uniq > vagrant_installed_packages.txt

  popd
  set -v
}

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
