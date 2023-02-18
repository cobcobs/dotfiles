#!/bin/sh

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

sketchybar --add event brew_update \
	--add item brew right \
	--set brew script="$PLUGIN_DIR/brew.sh" \
	icon=􀐛 \
	label=? \
	padding_right=10 \
	update_freq=3600 \
	--subscribe brew brew_update
