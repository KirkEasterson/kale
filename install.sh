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

KALE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
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
