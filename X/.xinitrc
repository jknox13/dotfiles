#!/bin/sh

xrdb -merge ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# disable trackpad & touchscreen
xinput disable "Synaptics TM3072-003"
xinput disable "ELAN Touchscreen"

# start some nice programs
xautolock -locker i3lock &
exec i3
