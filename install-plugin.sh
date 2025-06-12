#! /bin/bash
#
# install-plugin.sh
# Copyright (C) 2017 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.

if [ ! -e ~/bin ]
then
  mkdir ~/bin
fi

CURRENT_DIR=$(pwd)

# install fzf
if [ ! -e ~/.fzf ]
then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

if ls / | grep "Applications" > /dev/null # if sys is os x then change sth.
then
  echo "System is Mac..."
  brew install tree
  brew install fd
  brew install nnn
  brew install btop
  brew install mtr
  brew install ncdu
  brew install ag
  brew install ranger
else
  echo "System is Linux..."
  sudo apt install tree
  sudo apt install nnn
  sudo apt install btop
  sudo apt install pydf
  sudo apt install mtr
  sudo apt install silversearcher-ag
  sudo apt install ncdu
  sudo apt install fd-find
  sudo apt install ranger
fi

echo "full install complete"

