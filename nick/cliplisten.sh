#!/usr/bin/env nix-shell
#!nix-shell -i zsh -p gum git

source ~/.zshrc
clear
echo -n '' | wl-copy
last=''
echo -n '$ '
while :
do
    clip=$(wl-paste)
    if [[ $clip != '' && $clip != $last ]]; then
        echo $clip
        if [[ $clip == 'exit' ]]; then
            break
        fi
        eval $clip
        echo
        echo -n '$ '
        last=$clip
        echo -n '' | wl-copy
    fi
    sleep 0.2
done

