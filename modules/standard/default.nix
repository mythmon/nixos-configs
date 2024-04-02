{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    just
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc.automatic = true;
  };

  main-user = {
    enable = true;
    userName = "mythmon";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
