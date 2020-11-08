#!/usr/bin/env bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPTS_ROOTDIR=$(dirname ${THIS_DIR})

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

# Determine which OS we're on, and return a string that's a decent shorthand description of that OS
# We'll use this string as the directory name of the OS-specific scripts in this repo.
which_os () {
    UNAME_RESULT="$(uname -s)"
    case "${UNAME_RESULT}" in
        Linux*)     OS_GUESS=linux;;
        Darwin*)    OS_GUESS=macos;;
        CYGWIN*)    OS_GUESS=cygwin;;
        MINGW*)     OS_GUESS=mingw;;
        *)          OS_GUESS="UNKNOWN:${UNAME_RESULT}"
    esac
    echo ${OS_GUESS}
}

# Given a script name and any parameters for that script, attempt to find it in either the os-specific
# directory, or the global directory, and then run it.
run_script () {
    SCRIPT_NAME=$1
    shift

    OSDIR=$(which_os)

    if [ -f "${SCRIPTS_ROOTDIR}/${OSDIR}/${SCRIPT_NAME}" ]; then
        echo "Executing: ${SCRIPTS_ROOTDIR}/${OSDIR}/${SCRIPT_NAME} $@"
        ${SCRIPTS_ROOTDIR}/${OSDIR}/${SCRIPT_NAME} $@
    elif [ -f "${SCRIPTS_ROOTDIR}/global/${SCRIPT_NAME}" ]; then
        echo "Executing: ${SCRIPTS_ROOTDIR}/global/${SCRIPT_NAME} $@"
        ${SCRIPTS_ROOTDIR}/global/${SCRIPT_NAME} $@
    else
        echo "Unknown script ${SCRIPT_NAME}"
        exit 1
    fi
}
