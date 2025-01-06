{pkgs, ...}: let
  mainUserName = "mythmon";
in {
  nix = {
    gc.automatic = true;

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  boot.loader.systemd-boot.configurationLimit = 10;

  # The fish modules enables this by default for some completions. It is slow to build
  # though, so turn it off.
  documentation.man.generateCaches = false;

  main-user = {
    enable = true;
    userName = mainUserName;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    openssh.enable = true;
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      dina-font
      fira-code
      fira-code-symbols
      liberation_ttf
      monaspace
      mplus-outline-fonts.githubRelease
      nerd-fonts.fira-code
      nerd-fonts.monaspace
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      proggyfonts
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    fish.enable = true;
    localsend.enable = true;
    nix-ld.enable = true;
  };
}
