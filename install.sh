#!/bin/bash

set -e

if ! [ -x "$(command -v ansible)" ]; then
	echo "ansible must be installed"
	exit 1
fi

read -r -p "Do you want to upgrade packages first? (y/N) " yn
if [[ "$yn" == "y" ]]; then
	OS=$(uname -s | tr "[:upper:]" "[:lower:]")

	case $OS in
	linux)
		source /etc/os-release
		case $ID in

		debian | ubuntu | mint)
			sudo apt update
			;;

		fedora | rhel | centos)
			sudo yum update
			;;

		arch | manjaro | void)
			if [ -x "$(command -v yay)" ]; then
				yay -Syyu
			else
				sudo pacman -Syyu
			fi
			;;

		*)
			echo -n "unsupported linux distro"
			;;
		esac
		;;

	darwin)
		brew update
		;;

	*)
		echo "unsupported OS"
		exit 1
		;;
	esac
fi

DEFAULT_KALE_DIR="${HOME}/kale"
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

if [ -d "${SCRIPT_DIR}/.git" ]; then
	# assume that it is kale
	KALE_DIR="$SCRIPT_DIR"
else
	if [ ! -d "$DEFAULT_KALE_DIR" ]; then
		git clone --depth 1 https://github.com/KirkEasterson/kale.git "$DEFAULT_KALE_DIR"
	elif [ ! -d "${DEFAULT_KALE_DIR}/.git" ]; then
		echo "Default KALE directory already exists, and it isn't a git repo"
		exit 1
	fi

	KALE_DIR="$DEFAULT_KALE_DIR"
fi

if command -v timeshift >/dev/null 2>&1; then
	sudo timeshift --create --comments "before KALE run"
fi

cd "$KALE_DIR"
if [[ -f "$KALE_DIR/requirements.yml" ]]; then
	ansible-galaxy install -r requirements.yml
fi

if [[ -f "$KALE_DIR/vault-password.txt" ]]; then
	ansible-playbook \
		--diff \
		--ask-become-pass \
		--vault-password-file "$KALE_DIR/vault-password.txt" \
		"$KALE_DIR/bootstrap.yml"
else
	ansible-playbook \
		--diff \
		--ask-become-pass \
		--ask-vault-pass \
		"$KALE_DIR/bootstrap.yml"
fi
