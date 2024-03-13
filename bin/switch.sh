#!/usr/bin/env bash

set -e

cd ~/src/nixos-configs
echo "Formatting"
alejandra . 2>/dev/null

# echo "Rebuilding"
sudo nixos-rebuild switch --flake '.#' &>nixos-switch.log || (cat nixos-switch.log | grep --color error && false)

# that worked, so now lets commit it
echo "Comitting"
dir=$(mktemp -d)
template="${dir}/commit-message-template"
generation=$(nixos-rebuild list-generations | awk 'NR==2 {print $1}')
touch "$template"
echo "$(hostname) gen ${generation} - " > "$template"

git commit -av --template="$template"
