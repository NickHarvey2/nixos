#!/usr/bin/env sh

set -eo pipefail

if [[ "$(bw status | jq -r '.status')" == "locked" ]]; then
    export BW_SESSION=$(bw unlock --raw)
fi

bw list items | jq -r '.[] | "\(.name),\(.login.username),\(.login.password)"' | fzf --with-nth=1..2 --delimiter=',' | cut -d',' -f3 | tr -d '\n' | wl-copy
