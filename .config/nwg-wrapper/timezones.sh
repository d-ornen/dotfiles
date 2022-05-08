#!/usr/bin/env bash

# Some countries below have more than one time zone,
# and it makes sense to use cities instead of countries.
# Use tzselect to find their time zones.

time=$(TZ='Europe/Warsaw' date +'%H:%M:%S')
echo '<span size="25000" foreground="#544d4a" face="monospace" weight="bold">Wroclaw '$time'</span>'

echo '<span size="large" face="monospace" foreground="#a79f85">'
time=$(TZ='Europe/Minsk' date +"%H:%M")
echo 'Minsk	<b>'$time'</b>'
echo '</span>'
