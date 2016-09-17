Configs for an xmonad setup on Ubuntu. 

## Install 

xmonad: a beautiful tiling window manager that stays out of your way
xmobar: a simple status bar
trayer: a system tray you can put things in
redshift-gtk: colour temperature adjuster
autocutset: keep the X clipboard and the cutbuffer in sync

## Put configs at:

/usr/share/xsessions/xmonad.desktop
~/startxmonad
~/.xmonad/xmonad.hs
~/.xmobarrc
~/.config/redshift.conf
~/.bashrc
~/.vimrc
~/.Xresources  

## Descriptions

/usr/share/xsessions/xmonad.desktop adds an option to the login dropdown.
There'll probably already be a file called that; replace it or call this
one something else. It runs startxmonad, a little script to start things
in the right order.

That starts trayer, which displays icons for color temperature
(redshift-gtk), wifi (nm-applet) and sound (gnome-sound-applet).

redshift-gtk uses .config/redshift.conf and changes the colour temperature to be
redder at night. It's the  -gtk version so that it displays an icon.

autocutsel synchronises clipboards, so you're usually pasting what you expect.
