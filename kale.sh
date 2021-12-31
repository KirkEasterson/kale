#!/bin/bash

# TODO: add error handling

kale=$HOME/kale
dotfiles=$HOME/.dotfiles

# cd to the home directory
cd $HOME

# clone the git repos
git clone https://github.com/KirkEasterson/kale.git $kale
git clone https://github.com/KirkEasterson/.dotfiles.git $dotfiles

# install the programs
cd $kale
./program-install.sh

# symlink dotfile
cd $dotfiles
./install.sh
