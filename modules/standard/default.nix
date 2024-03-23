{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    just
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  main-user = {
    enable = true;
    userName = "mythmon";
  };

  nix.gc.automatic = true;
}
