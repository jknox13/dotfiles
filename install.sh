#!/bin/sh

# WIP script for installing dotfiles to new machine.

# ==============     nvim     ==============
stow nvim
# check if installed
# install plugins
nvim -E +PlugInstall +qall
