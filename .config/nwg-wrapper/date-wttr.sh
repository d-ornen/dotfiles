#!/usr/bin/env bash

time=$(LC_ALL=C TZ='Europe/Warsaw' date +'%A, %d. %B')
wttr=$(curl https://wttr.in/?format=1)
echo '<span size="35000" face="monospace"  foreground="#544d4a">'$time'</span><span size="30000" foreground="#a79f85">'
echo $wttr'</span>'
