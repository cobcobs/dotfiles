#!/bin/bash


BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

sketchybar -m --set battery\
  icon=\
  label="$(printf "${BATT_PERCENT}%%")"
