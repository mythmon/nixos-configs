{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    just
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  main-user = {
    enable = true;
    username = "mythmon";
  };
}
