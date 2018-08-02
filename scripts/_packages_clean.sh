#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

#### DONE ####
# brew cask zap     flux                || true # MacOS added their own feature
# brew uninstall    ansible             || true # handling this with pip instead
# brew cask zap     functionflip        || true # My current keyboards don't need this
# pip uninstall     docker-py           || true # Replaced with 'docker'
# brew cask zap     github-desktop      || true # Never used this
# brew untap homebrew/dupes             || true # migrated back to homebrew/core
# brew cask zap     karabiner           || true # Never really used it
# brew cask zap     openscad            || true # fusion is my jam instead
# brew cask zap     pgadmin4            || true # Replaced with pg-commander
# brew uninstall    openssh             || true # the macos version is modified to support keychains
# brew uninstall ansiweather            || true # this stopped working, and I wasn't using it
# rm ~/.ansiweatherrc                   || true
# brew cask zap     keepassx            || true # replaced with keepassxc
# brew uninstall    htop                || true # Turns out to be incompatible with high sierra.  Removing for now.
# brew cask zap     crashplan           || true # Screw these people
# brew cask zap     adium               || true # Switched out for limechat
# brew uninstall    php71               || true # replacing with php
# brew untap        homebrew/homebrew-php || true # No longer need this tap
# brew uninstall    git-annex           || true # Don't need this, except for work
# pip2 uninstall -y ansible-lint       || true # Starting to require everything be in a pipenv
# pip2 uninstall -y awscli             || true # Starting to require everything be in a pipenv
# pip2 uninstall -y boto               || true # Starting to require everything be in a pipenv
# pip2 uninstall -y boto3              || true # Starting to require everything be in a pipenv
# pip2 uninstall -y botocore           || true # Starting to require everything be in a pipenv
# pip2 uninstall -y click-completion   || true # Starting to require everything be in a pipenv
# pip2 uninstall -y cookiecutter       || true # Starting to require everything be in a pipenv
# pip2 uninstall -y docker             || true # Starting to require everything be in a pipenv
# pip2 uninstall -y flake8             || true # Starting to require everything be in a pipenv
# pip2 uninstall -y jinja2-time        || true # Starting to require everything be in a pipenv
# pip2 uninstall -y molecule           || true # Starting to require everything be in a pipenv
# pip2 uninstall -y s3transfer         || true # Starting to require everything be in a pipenv
# brew uninstall    rust               || true # Moving to native tooling for rust
# brew cask uninstall    limechat      || true # Only available through mac app store now, don't use it anyway
