#!/bin/sh

update() {
	WIDTH="dynamic"
	if [ "$SELECTED" = "true" ]; then
		WIDTH="0"
	fi

	FULLSCREEN=$(yabai -m query --windows --window | jq '.["is-native-fullscreen"]')
	bar_height=$(sketchybar --query bar | jq '.height')
	current_offset=$(sketchybar --query bar | jq '.y_offset')

	if [ "$FULLSCREEN" = "true" ]; then
		launchctl load -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist >/dev/null 2>&1 &
	elif [ "$((-current_offset))" != "$bar_height" ]; then
		launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist >/dev/null 2>&1 &
	fi

	sketchybar --animate tanh 20 --set $NAME icon.highlight=$SELECTED label.width=$WIDTH

}

mouse_clicked() {
	if [ "$BUTTON" = "right" ]; then
		yabai -m space --destroy $SID
		sketchybar --trigger space_change
	else
		yabai -m space --focus $SID 2>/dev/null
	fi
}

case "$SENDER" in
"mouse.clicked")
	mouse_clicked
	;;
*)
	update
	;;
esac
