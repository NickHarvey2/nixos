#!/usr/bin/env sh

set -euo pipefail

selected_network=$(echo "[$(nmcli dev wifi list | tail -n +2 | cut -c28-48 | sed 's/\s*$//g' | sed 's/\(.*\)/\"\1\"/' | sed 's/$/,/g' | sed '$ s/.$//')]" | jq -r 'map(select(. != "--")) | unique | .[]' | gum choose --header="Available Wi-Fi Networks:")

wifi_password=$(gum input --password --prompt="Password for $selected_network: ")

nmcli dev wifi connect "$selected_network" password "$wifi_password"
