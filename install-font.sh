#! /bin/bash
#
# install-plugin.sh
# Copyright (C) 2025 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.

set -e

FONT_NAME="JetBrainsMono"
FONT_VERSION="3.0.2"
ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v$FONT_VERSION/$FONT_NAME.zip"
TMP_DIR="/tmp/$FONT_NAME-font"
FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

echo "Downloading $FONT_NAME Nerd Font..."
curl -LO "$ZIP_URL"

echo "Unzipping font archive..."
unzip -q "$FONT_NAME.zip" -d "$TMP_DIR"

echo "Installing fonts to $FONT_DIR..."
mkdir -p "$FONT_DIR"
find . -name "*.ttf" -exec cp {} "$FONT_DIR/" \;

echo "Refreshing font cache..."
fc-cache -f -v > /dev/null

echo "$FONT_NAME Nerd Font installed successfully."

rm -rf "$TMP_DIR"
