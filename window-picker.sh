#!/usr/bin/env bash

if [[ -z $ROFI_INFO ]]
then
    hyprctl clients -j | jq -cr '.[] | "\(.title)\u0000info\u001f\(.address)"'
else
    hyprctl dispatch focuswindow "address:$ROFI_INFO" > /dev/null
    exit 0
fi
