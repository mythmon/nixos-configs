#!/usr/bin/env bash

set -eu -o pipefail

echo "Formatting"
alejandra . 2>/dev/null
action=$1

echo "Rebuilding"
log_file=nixos-switch.log
sudo nixos-rebuild ${action} --flake '.#' | tee $log_file

# that worked, so now lets commit it
echo "Comitting"
dir=$(mktemp -d)
template="${dir}/commit-message-template"
generation=$(nixos-rebuild list-generations | awk 'NR==2 {print $1}')
touch "$template"
echo "$(hostname) gen ${generation} - " > "$template"
echo Using template "$template"

git commit --allow-empty -av --template="$template"
rm -r $dir
