#!/usr/bin/env bash

# Dump the list of installed packages to a few files,
# so we can speed up the "do we need to reinstall this"
# process.
cache_installed_packages () {
  set +v
  pushd "${BASH_SOURCE%/*}"

  rm -f \
    brew_installed_packages.txt \
    brew_cask_installed_packages.txt \
    vagrant_installed_packages.txt

  brew list | tr " " "\n" | sort | uniq > brew_installed_packages.txt
  brew cask list | tr " " "\n" | sort | uniq > brew_cask_installed_packages.txt
  vagrant plugin list | cut -f1 -d' ' | sort | uniq > vagrant_installed_packages.txt

  popd
  set -v
}

brew_install () {
  set +v
  package_fullname=$1
  if grep --quiet "${package_fullname##*/}" "${BASH_SOURCE%/*}/brew_installed_packages.txt"; then
    echo $'    \e[4m''Notice'$'\e[0m'": brew package '$1' is already installed."
  else
    brew install $1
  fi
  set -v
}

brew_cask_install () {
  set +v
  package_fullname=$1
  if grep --quiet "${package_fullname##*/}" "${BASH_SOURCE%/*}/brew_cask_installed_packages.txt"; then
    echo $'    \e[4m''Notice'$'\e[0m'": brew cask package '$1' is already installed."
  else
    brew cask install $1
  fi
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
