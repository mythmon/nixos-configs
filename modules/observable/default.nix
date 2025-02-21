{pkgs, ...}: {
  gnome.chatApp = "rambox.desktop";

  environment.systemPackages = with pkgs; [
    beekeeper-studio
    google-chrome
    rambox
    heroku
    postgresql_17_jit
  ];

  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
    resolveLocalQueries = true;
    settings = {
      address = ["/test/127.0.0.1"];
    };
  };

  virtualisation.docker.autoPrune.flags = ["--all" "--filter" "label=prune=always"];
}
