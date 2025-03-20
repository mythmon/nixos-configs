switch:
  ./bin/switch.sh switch

format: fmt

fmt:
  nix fmt

boot:
  ./bin/switch.sh boot

update:
  nix flake update
  nix flake archive
  just check

gc:
  sudo nix-store --gc

diff:
  bash -c 'nix run nixpkgs#nix-diff -- $(nix-store -qd $(echo /nix/var/nix/profiles/* | tr " " "\n" | grep link | sort -V | tail -n 2))'

iso:
  nix build ./iso#nixosConfigurations.exampleIso.config.system.build.isoImage

check:
  nixos-rebuild dry-build --flake '.#'

build:
  nixos-rebuild build --flake '.#'
