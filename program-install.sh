#!/bin/bash

ppas=(
	"ppa:neovim-ppa/stable"
	"ppa:regolith-linux/stable"
)

# TODO: Figure out which programs are not needed
# TODO: Replace network-manager-gnome to remove gnome dependencies
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
	"i3-gaps"
	"neofetch"
	"golang"
	"python3-pip"
	"python"
	"blueman"
	"redshift"
	"redshift-gtk"
	"imagemagick"
	"tmux"
	"xclip"
	"arandr"
	"libxext-dev"
	"ffmpegthumbnailer"
	"epub-utils"
	"wkhtmltopdf"
	"bat"
	"chafa"
	"unzip"
	"p7zip"
	"unrar"
	"catdoc"
	"docx2txt"
	"odt2txt"
	"gnumeric"
	"exiftool"
	"libcdio-utils"
	"transmission"
)

snap_prgrms=(
	"code -- classic"
	"chromium"
	"1password"
	"postman"
	"whatsdesk"
	"caprine"
)

py_prgrms=(
	"pywal"
)

sudo_py_prgrms=(
	"ueberzug"
)

# add ppas
#sudo add-apt-repository -y ${ppas[@]}

for ppa in "${ppas[@]}"; do
	sudo add-apt-repository -y $ppa
done

# update for new ppas
sudo apt update

# install apt packages
sudo apt install -y ${apt_prgms[@]}

# install snap packages
for snap in "${snap_prgrms[@]}"; do
	sudo snap install $snap
done

# install python packages
pip3 install --user ${py_prgrms[@]}

# install python packages
sudo pip3 install --user ${sudo_py_prgrms[@]}

# install lf
cd /tmp/
wget https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz
tar -xf lf-linux-amd64.tar.gz
sudo mv lf /usr/bin/
rm lf-linux-amd64.tar.gz
cd -
