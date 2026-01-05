#!/bin/bash
#
# install-minimal.sh
# Minimal configuration setup for resource-constrained environments (VPS, Raspberry Pi, etc.)
# Copyright (C) 2025 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.
#

set -e

if [ $# -ge 2 ]; then
  echo "Usage: $0 [WORKDIR]"
  exit 1
fi

TARGET_DIR=~
if [ $# -eq 1 ]; then
  TARGET_DIR=${1%"/"}
  echo "Target directory is ${TARGET_DIR}"
fi

# Only support Linux/apt for minimal installation
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Error: Minimal installation is for Linux only. Use install-config.sh for Mac."
  exit 1
fi

echo "Starting minimal installation for resource-constrained environment..."

# Install essential base tools via apt (avoid compilation)
echo "Installing essential packages via apt..."
sudo apt update
sudo apt install -y \
  curl \
  git \
  vim \
  zsh \
  tmux \
  htop \
  unzip \
  wget \
  tree \
  jq

# Install modern CLI tools that have apt packages or pre-built binaries
echo "Installing modern CLI tools..."

# ripgrep - fast grep alternative (available in apt)
if ! command -v rg &> /dev/null; then
  echo "Installing ripgrep..."
  sudo apt install -y ripgrep
else
  echo "ripgrep already installed."
fi

# fd-find - fast find alternative (available in apt)
if ! command -v fd &> /dev/null && ! command -v fdfind &> /dev/null; then
  echo "Installing fd-find..."
  sudo apt install -y fd-find
  # Create symlink if fdfind is installed (Ubuntu/Debian naming)
  if command -v fdfind &> /dev/null && [ ! -e "${TARGET_DIR}/bin/fd" ]; then
    mkdir -p "${TARGET_DIR}/bin"
    ln -sf "$(which fdfind)" "${TARGET_DIR}/bin/fd"
  fi
else
  echo "fd-find already installed."
fi

# bat - cat with syntax highlighting (available in apt)
if ! command -v bat &> /dev/null && ! command -v batcat &> /dev/null; then
  echo "Installing bat..."
  sudo apt install -y bat
  # Create symlink if batcat is installed (Ubuntu/Debian naming)
  if command -v batcat &> /dev/null && [ ! -e "${TARGET_DIR}/bin/bat" ]; then
    mkdir -p "${TARGET_DIR}/bin"
    ln -sf "$(which batcat)" "${TARGET_DIR}/bin/bat"
  fi
else
  echo "bat already installed."
fi

# eza - modern replacement for ls (available in apt)
if ! command -v eza &> /dev/null; then
  echo "Installing eza..."
  sudo apt install -y eza
else
  echo "eza already installed."
fi

# zoxide - smarter cd command (using official install script for pre-built binary)
if ! command -v zoxide &> /dev/null; then
  echo "Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "zoxide already installed."
fi

# starship - cross-shell prompt (using official install script for pre-built binary)
if ! command -v starship &> /dev/null; then
  echo "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh
else
  echo "starship already installed."
fi

# fnm - Fast Node Manager (using official install script)
if ! command -v fnm &> /dev/null; then
  echo "Installing fnm..."
  curl -o- https://fnm.vercel.app/install | bash
else
  echo "fnm already installed."
fi

# Ensure fnm is in PATH for current session
if [ -f "$HOME/.local/share/fnm/fnm" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
fi

# Configure fnm environment and install Node.js LTS if not present
if command -v fnm &> /dev/null; then
  # Load fnm environment
  eval "$(fnm env --use-on-cd)"

  # Check if node is installed
  if ! command -v node &> /dev/null; then
    echo "Installing Node.js LTS via fnm..."
    fnm install --lts
  else
    echo "Node.js is already installed. Skipping."
  fi
fi

# Setup zinit for zsh plugin management
if [ ! -e "${TARGET_DIR}/.zinit" ]; then
  echo "Installing zinit..."
  mkdir -p "${TARGET_DIR}/.zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${TARGET_DIR}/.zinit/bin"
else
  echo "zinit already installed."
fi

# Create .config directory
if [ ! -d "${TARGET_DIR}/.config" ]; then
  echo "Creating ~/.config directory..."
  mkdir -p "${TARGET_DIR}/.config"
fi

base="$(pwd)"
LN_OPT="-sfn"

# Link essential dotfiles (skip GUI-specific configs)
echo "Linking dotfiles..."
for file in .zshrc .zprofile .zsh_aliases .gitconfig .tmux.conf; do
  if [ -e "$base/$file" ]; then
    ln ${LN_OPT} "$base/$file" "${TARGET_DIR}/"
  fi
done

echo "Linking directories..."
ln ${LN_OPT} "$base/zsh-plugin" "${TARGET_DIR}/"

# Setup Neovim config (vim/neovim is useful even on minimal systems)
echo "Setting up Neovim configuration..."
if [ ! -d "${TARGET_DIR}/.config/nvim" ]; then
  mkdir -p "${TARGET_DIR}/.config/nvim"
fi
if [ -e "$base/init.lua" ]; then
  ln ${LN_OPT} "$base/init.lua" "${TARGET_DIR}/.config/nvim/init.lua"
fi

# Setup Starship config
echo "Setting up Starship configuration..."
if [ -e "$base/starship.toml" ]; then
  ln ${LN_OPT} "$base/starship.toml" "${TARGET_DIR}/.config/starship.toml"
fi

# Install fzf (lightweight, doesn't require cargo)
if [ ! -e "${TARGET_DIR}/.fzf" ]; then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git "${TARGET_DIR}/.fzf"
  "${TARGET_DIR}/.fzf/install" --all
else
  echo "fzf already installed."
fi

echo ""
echo "=========================================="
echo "Minimal installation completed!"
echo "=========================================="
