THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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

run_script () {
    SCRIPT_NAME=$1
    shift

    OSDIR=$(which_os)

    if [ -f "${THIS_DIR}/${OSDIR}/${SCRIPT_NAME}" ]; then
        echo "Executing: ${THIS_DIR}/${OSDIR}/${SCRIPT_NAME} $@"
        ${THIS_DIR}/${OSDIR}/${SCRIPT_NAME} $@
    elif [ -f "${THIS_DIR}/global/${SCRIPT_NAME}" ]; then
        echo "Executing: ${THIS_DIR}/global/${SCRIPT_NAME} $@"
        ${THIS_DIR}/global/${SCRIPT_NAME} $@
    else
        echo "Unknown script ${SCRIPT_NAME}"
        exit 1
    fi
}
