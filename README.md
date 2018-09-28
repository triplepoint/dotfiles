# Introduction
A collection of config files I find useful.  Obviously this is an opinionated collection, so be cautious before blanket-applying them in your own environment.

# Inventory
## Scripts
- `scripts/packages.sh` - Installs and maintains a giant corpus of installed utilities, libraries, and applications.  Also maintains an uinstall list.  Be sure and review it before you run it, it's got a lot of opinions.
- `scripts/update_vagrant_boxes.sh` - Does what it says: updates the installed Vagrant boxes, and also prunes out old unused ones.
- `scripts/mod_slack.sh` - Modifies the Slack config file to reskin the UI.  Is idempotent.  Probably requires a restart of the Slack app.
- `scripts/copy_dotfiles.sh` - Installs various configuration files into the user home directory.
- `scripts/configure_git.sh` - Set up the git config for things like editors nd usernames.  Be sure to edit it first, there's some commented out bits that need to be customized.

## Docs
- `docs/useful_commands.md` - just a scratchpad of useful commands I find it convenient to keep at hand.

# Usage
Some of these scripts, especcially `packages.sh` are intended to be re-run at arbitrary times to refresh configuration. But for a brand new, clean machine, a few things need to happen first in the right order:
- `scripts/copy_dotfiles.sh` - safe to do first, since it installs configuration files for things that aren't yet installed
- `scripts/packages.sh` - Set aside some time.
- `chsh -s /bin/zsh` - Probably necessary once.

After that, the other commands and scripts should be fine to run in whatever order is convenient.

# Local Environment Variables
Some environment variables such as API keys shouldn't be checked in here.  A `~/._local_exports` file to contain these exports will be loaded, if present.
