#!/bin/bash

# TODO: add error handling

kale=$HOME/kale
dotfiles=$HOME/.dotfiles

# update the install
sudo apt update
sudo apt upgrade -y

# cd to the home directory
cd $HOME

# clone the git repos
rm -Rf $kale $dotfiles
git clone https://github.com/KirkEasterson/kale.git $kale
git clone https://github.com/KirkEasterson/.dotfiles.git $dotfiles

# install the programs
cd $kale
./program-install.sh

# symlink dotfile
cd $dotfiles
./install.sh

# TODO: Remove this once package that installs gnome dependencies is identified
# disable login managers
systemctl set-default multi-user.target

cd $HOME
mkdir Pictures
cd Pictures
rm -Rf wallpapers
git clone --depth 1 https://github.com/makccr/wallpapers

feh --bg-scale $kale/background.jpg

cd $HOME
