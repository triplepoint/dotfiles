# -*- mode: bash -*-
# vi: set ft=bash :

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the optional dotfiles that may or may not be present
for file in ~/{._bash_prompt,._exports,._local_exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Aliases
alias vi='/usr/local/bin/vim'

# Set up autocompletion (requires bash-completion be installed)
# if which brew > /dev/null && [ -f `brew --prefix`/etc/bash_completion ]; then
#     . `brew --prefix`/etc/bash_completion
# fi
