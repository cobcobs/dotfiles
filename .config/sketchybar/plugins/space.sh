#!/usr/bin/env bash


WIN=$(yabai -m query --spaces --space "$SID" | jq '.windows[0]')
WIDTH=$(sketchybar --query space.1 | jq '.icon.width')

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" icon.drawing=true
  sketchybar -m --animate tanh 10 --set "$NAME" icon.width="$WIDTH"
  sketchybar -m --animate tanh 10 --set "$NAME" icon.highlight=off icon.highlight=on
elif [ "$WIN" = "null" ]; then
  sketchybar -m --animate tanh 10 --set "$NAME" icon.width=0
  sleep 0.2
  sketchybar --set "$NAME" icon.drawing=false
elif [ "$WIN" != "null" ]; then
  sketchybar --set "$NAME" icon.drawing=true icon.highlight=off
  sketchybar -m --animate tanh 10 --set "$NAME" icon.width="$WIDTH"
else
  sketchybar -m --animate tanh 10 --set "$NAME" icon.highlight=on icon.highlight=off
fi
