# Introduction
A collection of config files I find useful.  Obviously this is an opinionated collection, so be cautious before blanket-applying them in your own environment.

The `brew.sh` script in particular installs utilities and applications I find useful.  Be sure and review it before you run it.

# Usage
Install and/or update installed applications with brew:
``` bash
./scripts/brew.sh
```

Copy the dotfiles to your home directory with:
``` bash
./scripts/copy_dotfiles.sh
```

Choose your shell (as in /bin/bash or /bin/zsh):
``` bash
chsh -s /bin/zsh
```

# Local Environment Variables
Some environment variables such as API keys shouldn't be checked in here.  A `~/._local_exports` file to contain these exports will be loaded, if present.
