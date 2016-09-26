Configs for an xmonad setup on Ubuntu. 

## Install 

* xmonad: a beautiful tiling window manager that stays out of your way  
* xmobar: a simple status bar  
* trayer: a system tray you can put things in  
* redshift-gtk: colour temperature adjuster. Mine s configurenf) (.config/redshift.conf) to make the screen red in the evening, New York time.  
* autocutset: keep the X clipboard and the cutbuffer in sync  
* xbacklight: to map to the brightness buttons to change screen brightness  
* acpi: to check the battery percentage

Also grab pulsevolume.sh from https://github.com/bchurchill/xmonad-pulsevolume for making the audio buttons work.

## Put configs in place:

/usr/share/xsessions/xmonad.desktop  
~/startxmonad  
~/battery-alert.sh
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

## When stuff doesn't work
xmonad --recompile and xmonad --restart restarts the xmonad config in place.

http://www.linuxandlife.com/2011/11/how-to-configure-xmonad-arch-linux.html#xmonad-laptop-keys is useful for figuring out what keys are called. There's other good stuff on that page too.  
