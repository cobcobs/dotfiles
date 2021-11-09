#!/bin/bash


. ~/.cache/wal/colors.sh
BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

sketchybar -m --set battery\
  icon_color=$COLOR \
  icon=\
  label=$(printf "${BATT_PERCENT}%%")
