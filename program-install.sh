#!/bin/bash

ppas=(
	"ppa:neovim-ppa/unstable" # for neovim nightly
	"ppa:regolith-linux/stable" # for i3-gaps
	"ppa:berglh/pulseaudio-a2dp" # TODO: Remove when upgraded to 22.04
	"ppa:aslatter/ppa" # for alacritty
)

# TODO: Figure out which programs are not needed
# TODO: Replace network-manager-gnome to remove gnome dependencies
apt_prgms=(
	"git"
	"curl"
	"tree"
	"make"
	"dialog"
	"compton"
	"xsel"
	"firefox"
	"feh"
	"lxappearance"
	# "libnotify-bin"
	"tmux"
	"neovim"
	"xinit"
	"xorg"
	"i3-gaps"
	"neofetch"
	"golang"
	"python3-pip"
	"imagemagick"
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
	# "papirus-icon-theme"
	"gruvbox-gtk"
	"pulseaudio-modules-bt"
	"libldac"
	"thunar"
	"autorandr"
	"radeontop"
	"alacritty"
	"polybar"
	"xss-lock"
	"brightnessctl"
	"pandoc"
	"zathura"
	"texlive-latex-base"
	"texlive-latex-recommended"
	"texlive-latex-extra"
	"tudu"
	"flameshot"
	"mtpaint"
	"gopls"
	"pavucontrol"
	"tlp"
	"powertop"
	"htop"
	"flatpak"
)

snap_prgms=(
	"chromium"
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
sudo apt install -y ${apt_prgms[@]} --no-install-recommends --no-install-suggests

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


# install starship prompt
curl -sSO https://starship.rs/install.sh
yes | ./install.sh
rm install.sh


# install whatscli
## TODO: either update the URL for a new release or write a function to download the latest zip
curl -sS -o whatscli.zip https://github.com/normen/whatscli/releases/download/v1.0.11/whatscli-v1.0.11-linux.zip
unzip whatscli.zip
sudo mv whatscli /usr/local/bin/whatscli


# install discord
## TODO: same as whatscli
curl -sS -o discord.deb "https://dl.discordapp.net/apps/linux/0.0.17/discord-0.0.17.deb"
sudo apt install -y ./discord.deb
rm discord.deb


# install codium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update && sudo apt install codium


# install 1password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
	curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
	sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
	curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo apt update && sudo apt install 1password


# add flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

cd $cwd
