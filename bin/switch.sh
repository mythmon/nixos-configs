#!/usr/bin/env bash

set -e

echo "Formatting"
alejandra . 2>/dev/null
action=$1

echo "Rebuilding"
log_file=nixos-switch.log
echo "see logs at ${log_file}"
sudo nixos-rebuild ${action} --flake '.#' &>nixos-switch.log || (cat "${log_file}" | grep --color error && false)

# that worked, so now lets commit it
echo "Comitting"
dir=$(mktemp -d)
template="${dir}/commit-message-template"
generation=$(nixos-rebuild list-generations | awk 'NR==2 {print $1}')
touch "$template"
echo "$(hostname) gen ${generation} - " > "$template"

git commit -av --template="$template"
