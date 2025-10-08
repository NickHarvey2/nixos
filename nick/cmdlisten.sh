#!/usr/bin/env zsh

source ~/.zshrc
clear
echo -n '$ '
while :
do
    clip=$(cat ~/pipe)
    echo $clip
    if [[ $clip == 'exit' ]]; then
        break
    fi
    eval $clip
    echo
    echo -n '$ '
done
