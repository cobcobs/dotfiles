#!/bin/sh


case $NAME in
  space_indicator) sketchybar --set "$NAME" label="$(yabai -m query --spaces --space | jq -r '.index')";;
  *) sketchybar --animate tanh 20 --set "$NAME" icon.highlight="$SELECTED";;
esac
