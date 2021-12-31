#!/usr/bin/env bash


if [ "$SELECTED" = "true" ]; then
  sketchybar -m --set $NAME icon.highlight=on
else
  sketchybar -m --set $NAME icon.highlight=off
fi

