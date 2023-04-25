#!/usr/bin/env bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
LINE='export COMPOSE_FILE=docker-compose.yml:docker-compose.override.yml:$SCRIPT_DIR/docker-compose.tutor.yml:$SCRIPT_DIR/docker-compose.tutor-hosts.yml'
        

for script in ./bin/* ; do
    name=$(basename $script)
    dest=$HOME/bin/$name
    if [[ ! -e $dest ]] ; then
        ln -s $SCRIPT_DIR/bin/$name $dest
        echo "Symlinked ~/bin/$name -> ./bin/$name"
    fi

done

if [[ -d /run/systemd/system ]] ; then
    read -p "systemd detected, install user services to ~/.config/systemd/user/? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
        ln -s $SCRIPT_DIR/services/* $HOME/.config/systemd/user/

        for service in ./services/* ; do
            name=$(basename $script)
            dest=$HOME/.config/systemd/user/$name
            if [[ ! -e $dest ]] ; then
                ln -s $SCRIPT_DIR/services/$name $dest
                echo "Symlinked ~/.config/systemd/user/$name -> ./services/$name"
            fi
        done
    fi
fi

# walk sibling directories
for d in ../*/ ; do
    if [[ -e "$d/docker-compose.yml" ]] ; then
        grep -qF -- "export COMPOSE_FILE" "$d/.envrc" || echo "$LINE" >> "$d/.envrc"
        direnv allow $d
    fi
done
