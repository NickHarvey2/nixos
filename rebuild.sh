#!/usr/bin/env nix-shell
#!nix-shell -i bash -p gum git

set -eo pipefail

echo "Path to flake:"
dir=`gum input --placeholder ${FLAKE_DIR:-''}`
if [ "$dir" = "" ]; then
    dir=$FLAKE_DIR
fi

echo "> $dir"

echo "Hostname:"
host=`gum input --placeholder $(hostname)`
if [ "$host" = "" ]; then
    host=$(hostname)
fi

echo "> $host"
echo

pushd $dir >/dev/null

while : ; do
    untracked_files=$(git ls-files --others --exclude-standard)
    unstaged_changes=$(git diff --name-only)

    if [[ -n "$untracked_files" ]] || [[ -n "$unstaged_changes" ]]; then
        echo "The working directory has unstaged changes."
        git status --short
        echo
        choice=$(printf \
            "1. View diff between current and index (git diff) then return to this menu\n2. Stage all unstaged changes (git add .)\n3. Stash unstaged changes, then reapply them after rebuild (git stash --include-untracked --keep-index; git stash pop)\n4. Interactively select hunks to be staged (git add . --patch)\n5. Continue with unstaged changes in working directory (not recommended)\n6. Cancel" \
            | gum choose --header "What would you like to do?")
        echo "> $choice"

        if [[ "$(echo $choice | cut -c1)" == '1' ]]; then
            git diff
        elif [[ "$(echo $choice | cut -c1)" == '2' ]]; then
            git add .
            continue
        elif [[ "$(echo $choice | cut -c1)" == '3' ]]; then
            echo "Stashing changes"
            git stash --include-untracked --keep-index
            break
        elif [[ "$(echo $choice | cut -c1)" == '4' ]]; then
            git add . --patch
            continue
        elif [[ "$(echo $choice | cut -c1)" == '5' ]]; then
            gum confirm "Warning: When using nixos-rebuild command with flakes, changes in untracked files will be ignored, but unstaged changes in tracked files will be honored, meaning some -- but not all -- unstaged changes may be applied if you continue" --affirmative "Continue anyway" --negative "Choose another option"
            if [[ $? == 0 ]]; then
                break
            else
                continue
            fi
        elif [[ "$(echo $choice | cut -c1)" == '6' ]]; then
            echo Cancelled
            exit
        fi
    else
        echo "The working directory has no unstaged changes."
        break
    fi
done

# TODO remove impure once the hardware-configuration.nix is in the flake
gum confirm "Run command? nixos-rebuild switch --flake $dir#$host --impure"
if [[ $? == 0 ]]; then
    sudo nixos-rebuild switch --flake "$dir#$host" --impure
    # if flake.lock was changed, stage those changes
    if [[ -n "$(git diff --name-only flake.lock)" ]]; then
        echo "Update have been made to flake.lock, staging"
        git add flake.lock
    fi
    gum confirm "Commit changes?"
    if [[ $? == 0 ]]; then
        # if there are staged, uncommitted changes
        if [[ -n $(git diff --name-only --staged) ]]; then
            # commit them
            commitmsg=$(gum write --header="Commit message:")
            while [[ $commitmsg == '' ]]; do
                echo "Commit message cannot be empty"
                commitmsg=$(gum write --header="Commit message:")
            done
            git commit -m"$commitmsg"

            gum confirm "Push to remote?"
            if [[ $? == 0 ]]; then
                git push origin main
            fi
        else
            # otherwise just print out a message about how there are no staged changes
            git commit
        fi
    fi
else
    echo Cancelled
fi

if [[ "$(echo $choice | cut -c1)" == '3' ]]; then
    echo "Restoring stashed changes"
    git stash pop
fi

popd >/dev/null
