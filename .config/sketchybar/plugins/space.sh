#!/usr/bin/env bash


WIN=$(yabai -m query --spaces --space "$SID" | jq '.windows[0]')
HAS_WINDOWS_OR_IS_SELECTED="true"
if [ "$WIN" = "null" ] && [ "$SELECTED" = "false" ];then
  HAS_WINDOWS_OR_IS_SELECTED="false"
fi
sketchybar -m --set "$NAME" icon.drawing="$HAS_WINDOWS_OR_IS_SELECTED"

if [ "$SELECTED" = "true" ]; then
  sketchybar -m --set "$NAME" icon.highlight=on
else
  sketchybar -m --set "$NAME" icon.highlight=off
fi
