#!/bin/bash

ppas=(
	"ppa:neovim-ppa/unstable"
	"ppa:regolith-linux/stable"
	"ppa:berglh/pulseaudio-a2dp" # TODO: Remove when upgraded to 22.04
)

# TODO: Figure out which programs are not needed
# TODO: Replace network-manager-gnome to remove gnome dependencies
apt_prgms=(
	"git"
	"vim"
	"curl"
	"tree"
	"make"
	"dialog"
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
	"tmux"
	"neovim"
	"xinit"
	"xorg"
	"i3-gaps"
	"neofetch"
	"golang"
	"python3-pip"
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
	"python-is-python3"
	"papirus-icon-theme"
	"gruvbox-gtk"
	"pulseaudio-modules-bt"
	"libldac"
)

snap_prgms=(
	"code --classic"
	"chromium"
	"1password"
	"postman"
	"whatsdesk"
	"caprine"
)

py_prgms=(
	"pywal"
	"ueberzug"
)

sudo_py_prgms=(
	"ueberzug"
)

# add ppas
for ppa in "${ppas[@]}"; do
	sudo add-apt-repository -y $ppa
done

# update for new ppas
sudo apt update

# install apt packages
for prg in "${apt_prgms[@]}"; do
	sudo apt install -y $prg
done

# install snap packages
for snap in "${snap_prgms[@]}"; do
	sudo snap install $snap
done

# install python packages
pip3 install --user ${py_prgms[@]}

# install python packages
sudo pip3 install ${sudo_py_prgms[@]}


## MANUAL INSTALLS
cwd=$(pwd)
cd /tmp/

# install lf
wget https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz
tar -xf lf-linux-amd64.tar.gz
sudo mv lf /usr/bin/
rm lf-linux-amd64.tar.gz

# install lfrun
git clone https://github.com/cirala/lfimg.git
cd lfimg
make install
cd ..
rm -Rf lfimg

cd $cwd
