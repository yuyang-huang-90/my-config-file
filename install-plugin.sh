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

# install enhancd replacement for cd
if [ ! -e ~/bin/enhancd ]
then
	git clone https://github.com/b4b4r07/enhancd ~/bin/enhancd
fi

# zsh autocomplete
if [ ! -e ~/bin/enhancd ]
then
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/zsh-plugin/zsh-autosuggestions
fi


if ls / | grep "Applications" > /dev/null # if sys is os x then change sth.
then
  echo "System is Mac..."
  brew install tree
  brew install fd
  brew install nnn
  brew install htop
  brew install mtr
  brew install ncdu
  brew install ag
  brew install ranger
else
  echo "System is Linux..."
  # install CLI tools
  sudo apt install tree
  ## file analyser replacement for ls
  sudo apt install nnn
  ## replacement for top
  sudo apt install htop
  ## replacement for df
  sudo apt install pydf
  ## replacement for traceroute
  sudo apt install mtr
  ## replacement for grep
  sudo apt install silversearcher-ag
  ## replacement for du
  sudo apt install ncdu
  ## fd replacement for find
  sudo apt install fd-musl
  ## ranger for good cd/ls
  sudo apt install ranger
fi

# install tools using cargo
if [ ! -z $(which cargo) ]
then
  cargo install bat
  cargo install exa
fi

echo "full install complete"

