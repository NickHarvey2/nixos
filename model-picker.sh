#!/usr/bin/env nix-shell
#!nix-shell -i zsh -p gum git

set -eo pipefail

MODELS=$(curl -s http://127.0.0.1:8080/models | jq -c '.data[] | {"name":.id,"status":.status.value}')
LOADED=$(echo $MODELS | jq -r 'select(.status == "loaded") | .name')
UNLOADED=$(echo $MODELS | jq -r 'select(.status == "unloaded") | .name')

if [[ -z $LOADED ]]; then
    SELECTED=$(echo $MODELS | jq -r '[.name, .status, "load"] | @csv' | gum table --columns model,status,action -r1)
else
    SELECTED=$(echo $MODELS | jq -r --arg loaded $LOADED '[.name, .status, (if .status == "loaded" then "unload" else "load (will unload \($loaded))" end)] | @csv' | gum table --columns model,status,action -r1)
fi
if [[ -z $SELECTED ]]; then
    echo 'Cancelled'
    exit 0
fi

if [[ -n $LOADED ]]; then
    curl http://127.0.0.1:8080/models/unload -d "{\"model\":\"$LOADED\"}"
    gum spin --title="Unloading $LOADED" -- bash -c "while [[ \$(curl -s http://127.0.0.1:8080/models | jq -r '.data[] | select(.id == \"$LOADED\") | .status.value') != \"unloaded\" ]]; do sleep 1; done"
fi

if [[ $SELECTED == $LOADED ]]; then
    exit 0
fi

curl http://127.0.0.1:8080/models/load -d "{\"model\":\"$SELECTED\"}"
gum spin --title="Loading $SELECTED" -- bash -c "while [[ \$(curl -s http://127.0.0.1:8080/models | jq -r '.data[] | select(.id == \"$SELECTED\") | .status.value') != \"loaded\" ]]; do sleep 1; done"
