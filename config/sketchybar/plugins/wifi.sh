#!/bin/sh

SSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F': ' '/ SSID/{print $2}')"

if [ "$SSID" = "" ]; then
  ICON="󰤭"
  LABEL="Off"
else
  ICON="󰤨"
  LABEL="$SSID"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
