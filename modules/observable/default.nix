{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    beekeeper-studio
    google-chrome
    rambox
    heroku
  ];
}
