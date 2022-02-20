#!/bin/sh

# WIP script for installing dotfiles to new machine.

# ==============     nvim     ==============
# npm for lsp
# dnf install npm
# npm install -g bash-language-server
# pip install --user "python-lsp-server[all]"

stow nvim
# check if installed
# install plugins
nvim -E +PlugInstall +qall

# ==============    kmonad    ==============
# download latest binary
# TODO: add logic to get latest binary
curl -o /usr/bin/kmonad https://github.com/kmonad/kmonad/releases/tag/0.4.1

# user need uinput permissions
# groupadd uinput & usermod -aG input $(whoami) & usermod -aG uinput $(whoami)
# cp system/40-uinput.rules /etc/udev/rules.d

stow kmonad

# enable kmonad service
# systemctl --user enable kmonad.service

# TODO check keyboard is correct
