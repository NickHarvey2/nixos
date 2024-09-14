#!/usr/bin/env sh

set -eo pipefail

ntwk=$(nmcli connection show | tail -n+2 | sed 's/\ \+/,/g' | sed 's/,$//g' | jq -rRc 'split(",") | {"name":.[0], "UUID":.[1], "type":.[2], "device":.[3]} | select(.type == "vpn") | .name' | gum choose --header "Select a network to connect to:")
