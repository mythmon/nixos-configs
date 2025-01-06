{pkgs, ...}: {
  nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    beekeeper-studio
    google-chrome
    rambox
    heroku
  ];
}
