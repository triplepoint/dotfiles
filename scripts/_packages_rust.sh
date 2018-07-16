#!/usr/bin/env bash

# Stop on any error, print all commands
set -e

# Install rustup, if it isn't already installed
command -v rustup >/dev/null 2>&1 || curl https://sh.rustup.rs -sSf | sh -s -- -y

# Make sure rustup is up to date
rustup self update

# Make sure rust is up to date
rustup update
