#!/bin/bash

entries="Logout Suspend Hibernate Reboot Shutdown Sway_Reload"

selected=$(printf '%s\n' $entries | wofi --conf=$HOME/.config/wofi/config.power --style=$HOME/.config/wofi/style.widgets.css | awk '{print tolower($1)}')

case $selected in
  logout)
    swaymsg exit;;
  hibernate)
      exec systemctl hibernate;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
  sway_reload)
      exec swaymsg reload;;
esac
