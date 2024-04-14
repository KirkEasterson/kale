#!/bin/bash
set -e

# TODO: bootstrap install ansible
if ! [ -x "$(command -v ansible)" ]; then
	echo "ansible must be installed"
	exit 1
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
