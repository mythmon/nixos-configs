switch:
  sudo nixos-rebuild switch --flake '.#'

fmt:
  nix fmt

boot:
  sudo nixos-rebuild boot --flake '.#'
