#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export EDITOR=vim
# export EDITOR=gedit
# setxkbmap -layout it
/usr/bin/VBoxClient-all &

# decomment next line if you want to use
# US keyboard layout and you want to be able
# to use (italian) accented letter
# setxkbmap us -variant intl

numlockx &

# choose one of the following WM:

# starts XFCE windows manager
# exec startxfce4

# starts awesome windows manager
exec awesome
