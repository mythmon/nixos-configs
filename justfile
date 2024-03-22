switch:
  ./bin/switch.sh

fmt:
  nix fmt

boot:
  sudo nixos-rebuild boot --flake '.#'

update:
  nix flake update
