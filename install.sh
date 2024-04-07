#!/bin/bash
# TODO: make this script POSIX compliant

set -e

SSH_DIR="$HOME/.ssh"

# TODO: bootstrap install ansible
if ! [ -x "$(command -v ansible)" ]; then
	echo "ansible must be installed"
	exit 1
fi

# TODO: bootstrap install openssh
if ! [ -x "$(command -v ssh-keygen)" ]; then
	echo "ssh-keygen must be installed"
	exit 1
fi

if ! [[ -f "$SSH_DIR/id_rsa" ]]; then
	mkdir -p "$SSH_DIR"
	chmod 700 "$SSH_DIR"

	ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "$USER@$HOSTNAME"
	cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"

	chmod 600 "$SSH_DIR/authorized_keys"
fi


KALE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$KALE_DIR"

if [[ -f "$KALE_DIR/requirements.yml" ]]; then
	ansible-galaxy install -r requirements.yml
fi

if [[ -f "$KALE_DIR/vault-password.txt" ]]; then
	ansible-playbook --diff --ask-become-pass --vault-password-file "$KALE_DIR/vault-password.txt" "$KALE_DIR/bootstrap.yml"
else
	ansible-playbook --diff --ask-become-pass --ask-vault-pass "$KALE_DIR/bootstrap.yml"
fi
