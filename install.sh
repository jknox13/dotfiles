#!/bin/sh

# WIP script for installing dotfiles to new machine.

# ==============     zsh      ==============
# antigen (currently tracked by git)
# curl -L git.io/antigen > "$XDG_DATA_HOME/zsh/antigen.zsh"
stow zsh

# ==============     tmux     ==============
# tmux-yank
# dnf install xsel
stow zsh

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

# ==============    hosts    ==============
# block ads, malware & porn
# curl -L https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts /etc/hosts

# =============    moonlander/ergodox keyboard ============
# https://github.com/zsa/wally/wiki/Linux-install

# install deps
# yum install gtk3 webkit2gtk3 libusb

# set udev rules
# cp system/50-wally.rules /etc/udev/rules.d

# add to groups
# groupadd plugdev
# usermod -aG plugdev $USER

# get latest binary
# curl -L https://configure.ergodox-ez.com/wally/linux > "/usr/local/bin"
# cmod +x /usr/local/bin/wally

# =============  Gnome   =============
stow gtk

# remove overloaded shell bindings (use meta-based bindings from gtk)
# todo: look into fully custom bindings https://blog.programster.org/using-the-cli-to-set-custom-keyboard-shortcuts
gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
gsettings set org.gnome.shell.keybindings toggle-application-view "[]"
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>m']"
