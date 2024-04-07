#!/bin/bash
# TODO: make this script POSIX compliant

set -e

KALE_DIR="$HOME/kale"
SSH_DIR="$HOME/.ssh"

# TODO: bootstrap install ansible
if ! [ -x "$(command -v ansible)" ]; then
	echo "ansible must be installed"
	exit 1
fi

if ! [[ -f "$SSH_DIR/id_rsa" ]]; then
	mkdir -p "$SSH_DIR"
	chmod 700 "$SSH_DIR"

	ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "$USER@$HOSTNAME"
	cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"

	chmod 600 "$SSH_DIR/authorized_keys"
fi


if [[ -f "$KALE_DIR/requirements.yml" ]]; then
	cd "$KALE_DIR"
	ansible-galaxy install -r requirements.yml
fi

cd "$KALE_DIR"

if [[ -f "$KALE_DIR/vault-password.txt" ]]; then
	ansible-playbook --diff --vault-password-file "$KALE_DIR/vault-password.txt" "$KALE_DIR/bootstrap.yml"
else
	ansible-playbook --diff -ask-vault-pass "$KALE_DIR/bootstrap.yml"
fi
