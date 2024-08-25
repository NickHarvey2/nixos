#!/usr/bin/env nix-shell
#!nix-shell -i bash -p gum git jq

set -euo pipefail

selected_id=$(cat $IDENTITIES_FILE| jq -r '. | keys | .[]' | gum choose --header "Select an identity to use for this repository:")

git config user.name $selected_id

email=$(cat $IDENTITIES_FILE | jq -r --arg selected_id $selected_id '.[$selected_id].email')
if [[ $email != 'null' ]]; then
    git config user.email $email
fi

signingkey=$(cat $IDENTITIES_FILE | jq -r --arg selected_id $selected_id '.[$selected_id].signingkey')
if [[ $signingkey != 'null' ]]; then
    git config user.signingkey $signingkey
    git config commit.gpgsign true
    keyformat=$(cat $IDENTITIES_FILE | jq -r --arg selected_id $selected_id '.[$selected_id].keyformat')
    if [[ $keyformat == 'ssh' ]]; then
        git config gpg.format ssh
    else
        git config --unset gpg.format
    fi
fi

