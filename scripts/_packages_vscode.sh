#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

# Ensure visual studio code is installed
brew cask install visual-studio-code

# Plugins
code --install-extension dhoeric.ansible-vault
code --install-extension mauve.terraform
code --install-extension shan.code-settings-sync
