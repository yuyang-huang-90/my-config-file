#! /bin/bash
#
# install.sh
# Copyright (C) 2014 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.
#

if [ $# -ge 2 ]; then
  echo "Usage: $0 [WORKDIR]"
  exit 1
fi

TARGET_DIR=~

if [ $# -eq 1 ]; then
  TARGET_DIR=${1%"/"}
  echo "target dir is ${TARGET_DIR}"
fi

if ls / | grep "Applications" > /dev/null # if sys is os x then change sth.
then
  echo "System is Mac..."
else
  echo "System is Linux..."
  sudo apt install curl
  sudo apt install cmake
  sudo apt install git
fi

# setup oh-my-zsh
if  [ ! -e ${TARGET_DIR}/.oh-my-zsh ]
then
  echo "install oh my zsh"
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
  mkdir ~/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
else
  echo "oh my zsh already installed"
fi

if [ ! -d ${TARGET_DIR}/.config ]
then
  echo "create dir .config in target dir"
  mkdir ${TARGET_DIR}/.config
fi

base="$(pwd)"


LN_OPT="-sfn"
if ls / | grep "Applications" > /dev/null # if sys is os x then change sth.
then
  LN_OPT="-sfnh"
fi

#link dot file
echo "link dot file..."
ln ${LN_OPT} $base/.zshrc ${TARGET_DIR}/
ln ${LN_OPT}  $base/.zprofile ${TARGET_DIR}/
ln ${LN_OPT}  $base/.zsh_aliases ${TARGET_DIR}/
ln ${LN_OPT} $base/.emacs ${TARGET_DIR}/
ln ${LN_OPT} $base/.hgrc ${TARGET_DIR}/
#ln ${LN_OPT} $base/.bashrc ${TARGET_DIR}/
ln ${LN_OPT} $base/.gitconfig ${TARGET_DIR}/
ln ${LN_OPT} $base/.tmux.conf ${TARGET_DIR}/
ln ${LN_OPT} $base/.wezterm.lua ${TARGET_DIR}/

echo "link dir..."
ln ${LN_OPT} $base/zsh-plugin   ${TARGET_DIR}/

echo "setup neovim config"

if [ ! -d ${TARGET_DIR}/.config/nvim ]
then
  echo "create dir ~/.confg/nvim in target dir"
  mkdir -p ${TARGET_DIR}/.config/nvim
fi

ln -sfn $base/init.lua ${TARGET_DIR}/.config/nvim/init.lua
#ln ${LN_OPT} $base/conf ${TARGET_DIR}/.config/nvim
#ln ${LN_OPT} $base/dict  ${TARGET_DIR}/.config/nvim
#ln ${LN_OPT} $base/colors   ${TARGET_DIR}/.config/nvim

# echo "setup vim config"
# if [ ! -d ${TARGET_DIR}/.vim ]
# then
#   echo "create dir .vim in target dir"
#   mkdir ${TARGET_DIR}/.vim
#ln ${LN_OPT} $base/conf ${TARGET_DIR}/.vim/
#ln ${LN_OPT} $base/dict  ${TARGET_DIR}/.vim/
#ln ${LN_OPT} $base/colors   ${TARGET_DIR}/.vim/
#ln ${LN_OPT} $base/.vimrc ${TARGET_DIR}/
# vim plug
# if  [ ! -f ${TARGET_DIR}/.vim/autoload/plug.vim ]
# then
#   echo "install vimplug"
#   curl -fLo ${TARGET_DIR}/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#   mkdir -p ${TARGET_DIR}/.vim/plugged
# else
#   echo "vimplug installed"
# fi
# fi


echo "done!"
