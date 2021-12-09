#!/bin/bash


sketchybar -m --set $NAME drawing=on

WINDOW_TITLE=$(yabai -m query --windows --window | jq -r '.title')

if [[ $WINDOW_TITLE = "" ]]; then
  WINDOW_TITLE=$(yabai -m query --windows --window | jq -r '.app')
fi

if [[ ${#WINDOW_TITLE} -gt 50 ]]; then
  WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -c 1-50)
  sketchybar -m --set $NAME label="$WINDOW_TITLE"…
  exit 0
fi

sketchybar -m --set $NAME label="$WINDOW_TITLE"

if [[ -z "$WINDOW_TITLE" ]]; then
  sketchybar -m --set $NAME drawing=off
fi

