#!/bin/bash

fonts=(
	"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip"
)

# go to the tmp directory
cd /tmp

# make the .fonts dir if it doesn't already exist
mkdir -p $HOME/.fonts

# variable for temp font name; it assumes a zip file is fetched
font_zip="font.zip"

# install fonts
for font in "${fonts[@]}"; do

	# download the font
	#	-f: fail silently
	#	-L: attempt to fetch redirects
	#	-o: download to specified file name
	curl -fLo $font_zip "$font"

	# unzip the contents of the fetch to the .fonts dir
	#	-o: replace the file if it already exists; so it can run unattended
	unzip -o font.zip -d $HOME/.fonts
done

# rebuild font cache
#	-f: force re-generate fonts
#	-v: verbose
fc-cache -fv
