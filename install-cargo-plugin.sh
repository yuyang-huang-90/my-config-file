#! /bin/bash
#
# install-plugin.sh
# Copyright (C) 2017 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.


# install tools using cargo
if [ ! -z $(which cargo) ]
then
  cargo install bat
  cargo install exa
  cargo install tokei
  cargo install sn
  cargo install procs
  cargo install ripgrep
fi

