#!/usr/bin/env bash

set -euo pipefail

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

enable_touchpad() {
    printf "enabled" > "$STATUS_FILE"
    notify-send -u normal -t 500 "Touchpad enabled"
    hyprctl keyword 'device[dll0945:00-06cb:cde6-touchpad]:enabled' 'true'
    hyprctl keyword 'device[pixa3854:00-093a:0274-touchpad]:enabled' 'true'
}

disable_touchpad() {
    printf "disabled" > "$STATUS_FILE"
    notify-send -u normal -t 500 "Touchpad disabled"
    hyprctl keyword 'device[dll0945:00-06cb:cde6-touchpad]:enabled' 'false'
    hyprctl keyword 'device[pixa3854:00-093a:0274-touchpad]:enabled' 'false'
}

if ! [ -f "$STATUS_FILE" ]; then
  disable_touchpad
else
  if [ $(cat "$STATUS_FILE") = "enabled" ]; then
    disable_touchpad
  elif [ $(cat "$STATUS_FILE") = "disabled" ]; then
    enable_touchpad
  fi
fi
