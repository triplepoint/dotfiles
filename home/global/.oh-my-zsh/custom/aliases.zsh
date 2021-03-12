alias git_fetch_submodules="git fetch --all --prune --tags && git submodule status --recursive | cut -c2- | cut -d' ' -f2 | xargs -P8 -I% bash -c 'echo --% && git -C % fetch --all --prune --tags'"
