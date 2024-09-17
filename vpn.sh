#!/usr/bin/env sh

set -eo pipefail

activevpn=$(nmcli connection show --active | tail -n+2 | sed 's/\ \+/,/g' | sed 's/,$//g' | jq -rRc 'split(",") | {"name":.[0], "UUID":.[1], "type":.[2], "device":.[3]} | select(.type == "vpn") | .name')

if [[ -z "$activevpn" ]]; then
    echo "No active VPNs"
    choice=$(printf \
        "1. Connect to a VPN\n2. Cancel" \
        | gum choose --header "What would you like to do?")
    echo "> $choice"
else
    echo "Active VPN: $activevpn"
    choice=$(printf \
        "1. Connect to a different VPN\n2. Disconnect from $activevpn\n3. Cancel" \
        | gum choose --header "What would you like to do?")
    echo "> $choice"
    if [[ "$(echo $choice | cut -c1)" == '2' ]] || [[ "$(echo $choice | cut -c1)" == '1' ]]; then
        nmcli connection down "$activevpn"
    fi
fi

if [[ "$(echo $choice | cut -c1)" == '1' ]]; then
    ntwk=$(nmcli connection show | tail -n+2 | sed 's/\ \+/,/g' | sed 's/,$//g' | jq -rRc 'split(",") | {"name":.[0], "UUID":.[1], "type":.[2], "device":.[3]} | select(.type == "vpn") | .name' | gum choose --header "Select a VPN to connect to:")

    while [[ "$(bw status | jq -r '.status')" == "locked" ]]; do
        export BW_SESSION=$(bw unlock --raw)
    done

    vpnpswd=$(bw list items | jq -r '.[] | "\(.name),\(.login.username),\(.login.password)"' | fzf --with-nth=1..2 --delimiter=',' | cut -d',' -f3 | tr -d '\n')

    (echo $vpnpswd && cat) | nmcli connection up "$ntwk" --ask
fi
