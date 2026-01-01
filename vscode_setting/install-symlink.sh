#!/bin/bash

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# VSCode
mkdir -p ~/.config/Code/User
ln -sf "$SCRIPT_DIR/settings.json" ~/.config/Code/User/settings.json
ln -sf "$SCRIPT_DIR/keybindings.json" ~/.config/Code/User/keybindings.json

# Cursor
mkdir -p ~/.config/Cursor/User
ln -sf "$SCRIPT_DIR/settings.json" ~/.config/Cursor/User/settings.json
ln -sf "$SCRIPT_DIR/keybindings.json" ~/.config/Cursor/User/keybindings.json

echo "Done! Symlinks created for VSCode and Cursor."
