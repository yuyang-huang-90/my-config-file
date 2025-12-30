#! /bin/bash
#
# install-plugin.sh
# Copyright (C) 2017 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.

set -e

mkdir -p ~/bin

# Determine if sudo is needed
SUDO=""
if [ "$EUID" -ne 0 ]; then
  SUDO="sudo"
fi

if [[ "$(uname)" == "Darwin" ]]; then
  echo "System is Mac..."
  if ! command -v brew &> /dev/null; then
      echo "Homebrew not found. Installing..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install curl git
else
  echo "System is Linux..."
  # Update package list and install essential tools
  if command -v apt-get &> /dev/null; then
    $SUDO apt-get update
    $SUDO apt-get install -y curl git build-essential
  fi
}

# install fzf
if [ ! -e ~/.fzf ]
then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
else
  echo "fzf already installed."
fi

# Check if cargo is available, install Rust if not
if ! command -v cargo &> /dev/null; then
  echo "Rust is not installed. Installing via rustup..."
  if curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
    # Source environment (use correct location depending on shell)
    source "$HOME/.cargo/env"
  else
    echo "Error: Rust installation failed."
    exit 1
  fi
else
  # Ensure cargo is in PATH if already installed
  if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
  fi
fi

echo "Installing cargo plugins..."

# Function to install cargo packages only if binary is missing
install_cargo_component() {
  local package=$1
  local binary=${2:-$1} # Default binary name is same as package

  if ! command -v "$binary" &> /dev/null; then
    echo "Installing $package..."
    cargo install "$package"
  else
    echo "$package ($binary) is already installed. Skipping."
  fi
}

install_cargo_component bat
install_cargo_component eza
install_cargo_component tokei
install_cargo_component procs
install_cargo_component ripgrep rg
install_cargo_component zoxide
install_cargo_component bottom btm
install_cargo_component fd-find fd
install_cargo_component du-dust dust
install_cargo_component yazi-fm yazi
install_cargo_component trippy trip
install_cargo_component dfrs

echo "full install complete"