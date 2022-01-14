#!/bin/bash

# TODO: add error handling

kale=$HOME/kale
dotfiles=$HOME/.dotfiles
pictures=$HOME/Pictures
wallpapers=$pictures/wallpapers

# update the install
sudo apt update
sudo apt upgrade -y

# cd to the home directory
cd $HOME

# clone the git repos
rm -Rf $kale $dotfiles
git clone https://github.com/KirkEasterson/kale.git $kale
git clone https://github.com/KirkEasterson/.dotfiles.git $dotfiles
git clone https://github.com/KirkEasterson/scripts.git

# symlink dotfile
cd $dotfiles
./install.sh

# install the programs
cd $kale
./program-install.sh
./font-install.sh

# TODO: Remove this once package that installs gnome dependencies is identified
# disable login managers
systemctl set-default multi-user.target

cd $HOME
mkdir -p $pictures/screenshots

# if wallpapers/ doesn't exist, clone the directory
if [ ! -d "$wallpapers" ]; then
	git clone --depth 1 https://github.com/makccr/wallpapers $wallpapers
fi

sudo reboot now
