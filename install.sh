#! /bin/sh
#
# install.sh
# Copyright (C) 2014 sigefried <sigefriedhyy@gmail.com>
#
# Distributed under terms of the MIT license.
#


if [ ! -d ~/.vim ]
then
    mkdir ~/.vim
fi

base="$(pwd)"

for dot_file in .*
do
    if [ -f "$dot_file" ]
    then
        ln -sfnh $base/$dot_file ~/
    fi
done

ln -sfnh ~/Dropbox/my-config-file/conf ~/.vim/
ln -sfnh .~/Dropbox/my-config-file/dict  ~/.vim/
ln -sfnh ~/Dropbox/my-config-file/colors   ~/.vim/


echo "done!"
