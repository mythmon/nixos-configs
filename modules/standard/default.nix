{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    file
    just
    unzip
    zip
  ];

  nix = {
    gc.automatic = true;

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];

      # for https://github.com/nixified-ai/flake
      trusted-substituters = ["https://ai.cachix.org"];
      trusted-public-keys = ["ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="];
    };
  };

  main-user = {
    enable = true;
    userName = "mythmon";
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    node-red.enable = true;
  };
}
