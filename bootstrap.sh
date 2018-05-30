#!/usr/bin/env bash

function summary() {
	# https://stackoverflow.com/a/2924755/2909897
	bold=$(tput bold)
	normal=$(tput sgr0)

	cat <<-DESCRIPTION >&2
	This script is used to bootstrap a workstation running macOS.
	It checks for Homebrew the Package Manager and Ansible the Configuration Manager.
	If they ${bold}are${normal} installed then it does nothing.
	If they ${bold}are not${normal} installed then it installs them.
	DESCRIPTION
}

function install_homebrew() {
	echo >&2 'Installing Homebrew...'
	yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_ansible() {
	echo >&2 'Installing Ansible...'
	brew install ansible
}

summary
command -v brew	   > /dev/null || install_homebrew
command -v ansible > /dev/null || install_ansible