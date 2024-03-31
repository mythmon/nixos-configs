switch:
  ./bin/switch.sh switch

fmt:
  nix fmt

boot:
  ./bin/switch.sh boot

update:
  nix flake update

gc:
  sudo nix-store --gc
