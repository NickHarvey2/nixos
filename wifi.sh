#!/usr/bin/env sh

set -euo pipefail

selected_network=$(echo "[$(nmcli dev wifi list | tail -n+2 | sed 's/\ \+/,/g' | sed 's/,$//g' | sed 's/^,//g' | cut -d',' -f2 | sed 's/\(.*\)/\"\1\"/' | sed 's/$/,/g' | sed '$ s/.$//')]" | jq -r 'map(select(. != "--")) | unique | .[]' | gum choose --header="Available Wi-Fi Networks:")

nmcli dev wifi connect "$selected_network" password "$(gum input --password --prompt="Password for $selected_network: ")"
