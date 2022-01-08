#!/bin/bash


# TODO: Figure out which programs are not needed
# TODO: Figure out which program is installing gnome dependencies
apt_prgms=(
	"git"
	"vim"
	"curl"
	"tree"
	"fonts-ubuntu-font-family-console"
	"xfce4-terminal"
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
	"python3-pip"
	"blueman"
)

snap_prgrms=(
	"code -- classic"
	"chromium"
	"1password"
	"postman"
	"whatsdesk"
	"caprine"
)

# install apt packages
sudo apt install -y ${apt_prgms[@]}

# install snap packages
for entry in "${snap_prgrms[@]}"
do
	sudo snap install $entry
done
