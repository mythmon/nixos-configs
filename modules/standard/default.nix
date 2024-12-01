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
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    fish.enable = true;
  };
}
