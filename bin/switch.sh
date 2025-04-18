#!/usr/bin/env bash

set -eu -o pipefail

echo "Formatting"
alejandra . 2>/dev/null
action=$1

echo "Rebuilding"
log_file=nixos-switch.log
sudo nixos-rebuild ${action} --flake '.#' | tee $log_file
echo

# that worked, so now label the current commit via a bookmark
echo "Bookmarking"
generation=$(nixos-rebuild list-generations | awk 'NR==2 {print $1}')
bookmark="$(hostname)-${generation}"
jj bookmark set "$bookmark" --revision='latest(ancestors(@) & ~empty())'
