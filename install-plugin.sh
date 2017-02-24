#! /bin/bash
#
# install-plugin.sh
# Copyright (C) 2017 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.

mkdir ~/bin

$CURRENT_DIR=$(pwd)

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/instal

# install enhancd
git clone https://github.com/b4b4r07/enhancd
