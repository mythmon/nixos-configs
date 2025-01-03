{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    beekeeper-studio
    rambox
    heroku
  ];
}
