#!/usr/bin/env bash

# Dump the list of installed packages to a few files,
# so we can speed up the "do we need to reinstall this"
# process.
cache_installed_packages () {
  cache_installed_vagrant_plugins
}
