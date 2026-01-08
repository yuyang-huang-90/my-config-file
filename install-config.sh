#! /bin/bash
#
# install-config.sh
# Copyright (C) 2025 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.
#

if [ $# -ge 3 ]; then
  echo "Usage: $0 [TARGET_DIR] [SOURCE_DIR]"
  exit 1
fi

TARGET_DIR=~
if [ $# -ge 1 ]; then
  TARGET_DIR=${1%"/"}
  echo "Target directory is ${TARGET_DIR}"
fi

SOURCE_DIR="$(pwd)"
if [ $# -ge 2 ]; then
  SOURCE_DIR=${2%"/"}
  echo "Source directory is ${SOURCE_DIR}"
fi

# Ensure base tools for bootstrapping
if [[ "$(uname)" == "Darwin" ]]; then
  echo "System is Mac..."
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Please install Homebrew first."
    exit 1
  fi
  brew install curl git icdiff cmake jq tree tmux htop unzip wget vim zsh
else
  echo "System is Linux..."
  sudo apt update
  sudo apt install -y curl git build-essential icdiff cmake jq tree tmux htop unzip wget vim zsh \
    pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
fi

# Setup zinit
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

base="$SOURCE_DIR"
LN_OPT="-sfn"
if [[ "$(uname)" == "Darwin" ]]; then
  LN_OPT="-sfnh"
fi

# Link dotfiles
echo "Linking dotfiles..."
for file in .zshrc .zprofile .zsh_aliases .emacs .hgrc .gitconfig .tmux.conf .wezterm.lua; do
  if [ -e "$base/$file" ]; then
    ln ${LN_OPT} "$base/$file" "${TARGET_DIR}/"
  fi
done

echo "Linking directories..."
if [ -e "$base/zsh-plugin" ]; then
  ln ${LN_OPT} "$base/zsh-plugin" "${TARGET_DIR}/"
fi

# Setup SSH config
echo "Setting up SSH configuration..."
if [ ! -d "${TARGET_DIR}/.ssh" ]; then
  mkdir -p "${TARGET_DIR}/.ssh"
  chmod 700 "${TARGET_DIR}/.ssh"
fi
if [ -e "$base/.ssh/config" ]; then
  ln ${LN_OPT} "$base/.ssh/config" "${TARGET_DIR}/.ssh/config"
  chmod 640 "${TARGET_DIR}/.ssh/config"
fi

# Setup Neovim config
echo "Setting up Neovim configuration..."
if [ ! -d "${TARGET_DIR}/.config/nvim" ]; then
  mkdir -p "${TARGET_DIR}/.config/nvim"
fi
if [ -e "$base/init.lua" ]; then
  ln ${LN_OPT} "$base/init.lua" "${TARGET_DIR}/.config/nvim/init.lua"
fi

# Setup Alacritty config
echo "Setting up Alacritty configuration..."
if [ ! -d "${TARGET_DIR}/.config/alacritty" ]; then
  mkdir -p "${TARGET_DIR}/.config/alacritty"
fi
if [ -e "$base/alacritty.toml" ]; then
  ln ${LN_OPT} "$base/alacritty.toml" "${TARGET_DIR}/.config/alacritty/alacritty.toml"
fi

# Setup Starship config
echo "Setting up Starship configuration..."
if [ -e "$base/starship.toml" ]; then
  ln ${LN_OPT} "$base/starship.toml" "${TARGET_DIR}/.config/starship.toml"
fi

echo "Configuration setup done!"
echo "Note: Run ./install-plugin.sh to install additional tools and plugins."
