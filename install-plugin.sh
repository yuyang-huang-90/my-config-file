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

# install fzf
if [ ! -e ~/.fzf ]
then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
else
  echo "fzf already installed."
fi

# install nvm (Node Version Manager)
if [ ! -e ~/.nvm ]
then
  echo "Installing nvm..."
  if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash; then
    # Source nvm to make it available immediately
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
      \. "$NVM_DIR/nvm.sh"

      # Install latest LTS version of Node.js
      echo "Installing Node.js LTS..."
      nvm install --lts
      nvm use --lts
      nvm alias default 'lts/*'
    else
      echo "Error: nvm installation incomplete. Please check manually."
    fi
  else
    echo "Error: Failed to download nvm installer."
  fi
else
  echo "nvm already installed."
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

# bat: A cat(1) clone with syntax highlighting and Git integration. Example: bat <file>
install_cargo_component bat
# eza: A modern, feature-rich replacement for 'ls'. Example: eza -la
install_cargo_component eza
# tokei: A program that displays statistics about your code. Example: tokei .
install_cargo_component tokei
# procs: A modern replacement for 'ps'. Example: procs <process_name>
install_cargo_component procs
# ripgrep (rg): An extremely fast line-oriented search tool. Example: rg <pattern>
install_cargo_component ripgrep rg
# zoxide: A smarter 'cd' command that learns your habits. Example: z <directory>
install_cargo_component zoxide
# bottom (btm): A customizable system monitor. Example: btm
install_cargo_component bottom btm
# fd: A simple, fast alternative to 'find'. Example: fd <pattern>
install_cargo_component fd-find fd
# dust: A more intuitive version of 'du'. Example: dust
install_cargo_component du-dust dust
# trippy: A network diagnostic tool. Example: trip google.com
install_cargo_component trippy trip
# dfrs: A modern replacement for 'df'. Example: dfrs
install_cargo_component dfrs
# tealdeer: A fast implementation of tldr, providing simplified man pages. Example: tldr tar
install_cargo_component tealdeer tldr

echo "full install complete"
