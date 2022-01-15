#!/bin/bash

# TODO: add error handling
# TODO: change sizing on dialogs

# Confirm that the user wants to install the script
if ! dialog --stdout --title "Installation" \
	--backtitle "Kirk's Automated Linux Environment (KALE)" \
	--yesno "This will install Kirk's Automated Linux Environment (KALE). \
This script was intended for Ubuntu 20.04. Do you wish to continue?" 0 0
then
    exit 0
fi

kale=$HOME/kale
dotfiles=$HOME/.dotfiles
pictures=$HOME/Pictures
wallpapers=$pictures/wallpapers

# update the install
sudo apt-get update 2>&1 | dialog --progressbox "Updating package information" 30 100
sudo apt-get upgrade -y 2>&1 | dialog --progressbox "Updating packages" 30 100

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
