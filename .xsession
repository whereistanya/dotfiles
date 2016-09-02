#!/bin/bash

if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

GNOME_VOLUME_MANAGER="$(which gnome-volume-manager 2> /dev/null)"
GNOME_POWER_MANAGER="$(which gnome-power-manager 2> /dev/null)"
GNOME_SETTINGS_DAEMON="$(which gnome-settings-daemon 2> /dev/null)"
GNOME_PANEL="$(which gnome-panel 2> /dev/null)"
GNOME_SESSION="$(which gnome-session 2> /dev/null)"
NM_APPLET="$(which nm-applet 2> /dev/null)"
TRAYER="$(which trayer 2> /dev/null)"
XMONAD="$(which xmonad 2> /dev/null)"
XSET="$(which xset 2> /dev/null)"
XMODMAP="$(which xmodmap 2> /dev/null)"

# No beeps.
if [ -x "$XSET" ]; then
  "$XSET" b off
fi

# Custom keybindings
if [ -x "$XMODMAP" -a -f "$HOME/.xmodmaprc" ]; then
  "$XMODMAP" "$HOME/.xmodmaprc"
fi

xsetroot -solid black

# Start some useful stuff
if [ -x "$GNOME_SETTINGS_DAEMON" ]; then
  "$GNOME_SETTINGS_DAEMON" &
fi
if [ -x "$GNOME_POWER_MANAGER" ]; then
  "$GNOME_POWER_MANAGER" &
fi
if [ -x "$NM_APPLET" ]; then
  "$NM_APPLET" &
fi

$TRAYER  --edge top --align right --SetDockType true \
         --SetPartialStrut true --expand true --width 10 \
         --transparent true --tint 0x191970 --height 12 &

#if [ -x "$GNOME_PANEL" ]; then
# "$GNOME_PANEL" &
#fi

xscreensaver -no-splash &

feh --bg-scale ~/.xmonad/Xmbindings.png

# Sync all of the clipboards
/usr/bin/autocutsel -fork & /usr/bin/autocutsel -selection PRIMARY -fork &
# Use xmonad if available
if [ -x "$XMONAD" ]; then
  "$XMONAD"
elif [ -x "$GNOME_SESSION" ]; then
  "$GNOME_SESSION"
else
  twm
fi

