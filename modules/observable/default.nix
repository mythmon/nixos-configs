{pkgs, ...}: {
  gnome.chatApp = "rambox.desktop";

  environment.systemPackages = with pkgs; [
    beekeeper-studio
    google-chrome
    rambox
    heroku
  ];
}
