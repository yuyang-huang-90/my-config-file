#! /bin/bash
#
# install-plugin.sh
# Copyright (C) 2017 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.

set -e

# Check if cargo is available, install Rust if not
if ! command -v cargo &> /dev/null; then
  echo "Rust is not installed. Installing via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  # Source environment (use correct location depending on shell)
  source "$HOME/.cargo/env"
fi

cargo install bat
cargo install exa
cargo install tokei
cargo install procs
cargo install ripgrep
cargo install zoxide

