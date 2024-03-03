{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    just
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
