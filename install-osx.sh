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



if [ ! -d ${TARGET_DIR}/.vim ]
then
  echo "create dir .vim in target dir"
  mkdir ${TARGET_DIR}/.vim
fi

if [ ! -d ${TARGET_DIR}/.config ]
then
  echo "create dir .config in target dir"
  mkdir ${TARGET_DIR}/.config
fi

base="$(pwd)"

#link dot file

echo "link dot file..."

ln -sfnh $base/.zshrc ${TARGET_DIR}/
ln -sfnh $base/.zprofile ${TARGET_DIR}/
ln -sfnh $base/.vimrc ${TARGET_DIR}/
ln -sfnh $base/.emacs ${TARGET_DIR}/
ln -sfnh $base/.hgrc ${TARGET_DIR}/
ln -sfnh $base/.bashrc ${TARGET_DIR}/
ln -sfnh $base/.gitconfig ${TARGET_DIR}/
ln -sfnh $base/.tmux.conf ${TARGET_DIR}/

echo "link dir..."

ln -sfnh $base/conf ${TARGET_DIR}/.vim/
ln -sfnh $base/dict  ${TARGET_DIR}/.vim/
ln -sfnh $base/colors   ${TARGET_DIR}/.vim/

ln -sfnh $base/zsh-plugin   ${TARGET_DIR}/

echo "setup vim plug bundle"

curl -fLo ${TARGET_DIR}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "setup neovim config"

ln -sfnh ${TARGET_DIR}/.vim ${TARGET_DIR}/.config/nvim
ln -sfnh ${TARGET_DIR}/.vimrc ${TARGET_DIR}/.vim/init.vim


echo "done!"
