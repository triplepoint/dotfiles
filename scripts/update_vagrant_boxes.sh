#!/usr/bin/env bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${THIS_DIR}/global/_functions.sh
run_script $(basename $0) $@
