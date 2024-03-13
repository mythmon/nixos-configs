switch:
  ./bin/switch.sh

fmt:
  nix fmt

boot:
  sudo nixos-rebuild boot --flake '.#'
