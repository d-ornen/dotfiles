#!/bin/bash

entries="Active Screen Output Area Window"
variants="Copy Save"
mkdir -p ~/Pictures/screenshots/

selected_entry=$(printf '%s\n' $entries | wofi --style=$HOME/.config/wofi/style.widgets.css --conf=$HOME/.config/wofi/config.screenshot | awk '{print tolower($1)}') &&
  selected_variant=$(printf '%s\n' $variants | wofi --style=$HOME/.config/wofi/style.widgets.css --conf=$HOME/.config/wofi/config.screenshot | awk '{print tolower($1)}')
  if [ $selected_variant=save ]; then
    filename=$(zenity --entry --text "Enter file name")
    if [ $filename!="" ]; then
      filepath=~/Pictures/screenshots/$filename
    fi
  fi

 echo "/usr/share/sway/scripts/grimshot --notify $selected_variant $selected_entry $filepath.png"

