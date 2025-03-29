<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
<h3 align="center">Kirk's Automated Linux Environment (KALE)</h3>

  <p align="center">
    An ansible playbook designed to automate install of my (Kirk's) linux environment in Ubuntu.
  </p>
</div>

## About The Project

This repository originally a series of bash scripts to be used on an installation of Ubuntu server 21.10.
But the scripts were fragile and had to be manually tested to ensure correctness.
Ansible is the sensible alternative to this approach, so the scripts were rewritten for Ansible.

## Getting Started

As stated above, this repository is intended to be used on an installation of Ubuntu server 21.10.
It will likely work for other versions of Ubuntu, and other Debian based distributions.
But there is no guarantee that it will work.

This repository was designed to be used with `ansible-pull`, and has not been tested with any other Ansible commands.

### Prerequisites

The only prerequisite is Ansible.

```sh
# debian
sudo apt install ansible
```

```sh
# arch
sudo pacman -Sy ansible
```

```sh
# macos
brew install ansible
```

### Installation

Clone the repo, check out the `main` branch, and run the install script.

```sh
./install.sh
```

## Usage

There are future plans to add a detailed guide on how to use the environment post-installation.
The only advice I have now is to read the configs and figure it out yourself.

## Troubleshooting

- Cannot authorize key with github

  - The github access token likely expired. Generate a new one with 'read and write' permissions for SSH keys _and_ GPG keys. This playbook doesn't add GPG keys, but the permission is necessary to interact with the `https://api.github.com/user/keys` endpoint

## Roadmap

- [ ] Bootstrap necessary installations in `install.sh`
  - [ ] brew (if on mac)
  - [ ] ansible (package manager independent)
- [ ] Add support for multiple linux distributions
  - [ ] Fedora
  - [ ] openSuse
  - [x] Debian
- [x] Add support for macos
- [ ] Implement molecule for testing the bootstrap playbook
- [ ] Add flags for enabling features (for personal and testing usages)
