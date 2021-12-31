#!/bin/bash


# TODO: Figure out which programs are not needed
# TODO: Figure out which program is installing gnome dependencies
apt_prgms=(
	"git"
	"vim"
	"curl"
	"tree"
	"fonts-ubuntu-font-family-console"
	"rxvt-unicode-256color"
	"pop-gtk-theme"
	"pop-icon-theme"
	"compton"
	"xsel"
	"ranger"
	"firefox"
	"feh"
	"lxappearance"
	"libnotify-bin"
	"alsa-base"
	"alsamixergui"
	"volumeicon-alsa"
	"network-manager-gnome"
	"tmux"
	"neovim"
	"xinit"
	"xorg"
	"i3"
	"neofetch"
	"golang"
	"python3-pip
)

snap_prgrms=(
	"code -- classic"
	"chromium"
	"1password"
	"postman"
	"whatsdesk"
	"caprine"
)

sudo apt install -y ${apt_prgms[@]}
sudo apt autoremove

for entry in "${snap_prgrms[@]}"
do
	sudo snap install $entry
done
