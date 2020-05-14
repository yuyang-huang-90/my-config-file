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

ln -sfn $base/.zshrc ${TARGET_DIR}/
ln -sf  $base/.zprofile ${TARGET_DIR}/
ln -sfn $base/.vimrc ${TARGET_DIR}/
ln -sfn $base/.emacs ${TARGET_DIR}/
ln -sfn $base/.hgrc ${TARGET_DIR}/
ln -sfn $base/.bashrc ${TARGET_DIR}/
ln -sfn $base/.gitconfig ${TARGET_DIR}/
ln -sfn $base/.tmux.conf ${TARGET_DIR}/

echo "link dir..."

ln -sfn $base/conf ${TARGET_DIR}/.vim/
ln -sfn $base/dict  ${TARGET_DIR}/.vim/
ln -sfn $base/colors   ${TARGET_DIR}/.vim/


ln -sfn $base/zsh-plugin   ${TARGET_DIR}/

echo "setup vim plug bundle"

curl -fLo ${TARGET_DIR}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "setup neovim config"

ln -sfn ${TARGET_DIR}/.vim ${TARGET_DIR}/.config/nvim
ln -sfn ${TARGET_DIR}/.vimrc ${TARGET_DIR}/.vim/init.vim


echo "done!"
