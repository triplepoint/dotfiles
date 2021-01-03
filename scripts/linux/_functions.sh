#!/usr/bin/env bash

# Dump the list of installed packages to a few files,
# so we can speed up the "do we need to reinstall this"
# process.
cache_installed_packages () {
  cache_installed_vagrant_plugins
}

# If a file path doesn't exist, download it and install it
download_if_not_exists () {
  FILEPATH=$1
  URL=$2
  if [ ! -f "${FILEPATH}" ]; then
    sudo curl -fsSL ${URL} --output ${FILEPATH}
  fi
}

# Write the given string to the given file, if the file doesn't already exist
write_if_not_exists () {
  FILEPATH=$1
  CONTENT=$2
  if [ ! -f "${FILEPATH}" ]; then
    echo ${CONTENT} | sudo tee ${FILEPATH}
  fi
}

# Add a pgp key by ID, defaulting to the assorted keyring, and the sks-keyservers.net keyserver
add_pgp_key () {
  KEY_ID=$1
  KEYSERVER=$2
  if [[ "${KEYSERVER}" == "" ]]; then
    KEYSERVER="pool.sks-keyservers.net"
  fi
  KEYRING_PATH="/etc/apt/trusted.gpg.d/assorted.gpg"
  sudo gpg --no-default-keyring --keyring gnupg-ring:${KEYRING_PATH} --keyserver ${KEYSERVER} --recv-keys ${KEY_ID}
}
