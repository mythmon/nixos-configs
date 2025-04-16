{pkgs, ...}: {
  gnome.chatApp = "rambox.desktop";

  nixpkgs.config.permittedInsecurePackages = ["beekeeper-studio-5.1.5"];

  environment.systemPackages = with pkgs; [
    beekeeper-studio
    google-chrome
    heroku
    k3d
    kubectl
    postgresql_17_jit
    rambox
  ];

  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
    resolveLocalQueries = true;
    settings = {
      address = ["/test/127.0.0.1"];
    };
  };

  services.incron = {
    enable = true;
    systab = ''
      /home/mythmon/src/observablehq/observablehq/notebook-api/db IN_CREATE,IN_NO_LOOP ${pkgs.coreutils-full}/bin/chown mythmon:users $@/$#
      /home/mythmon/src/observablehq/observablehq/shared/observablehq-types-db/src IN_CREATE,IN_NO_LOOP ${pkgs.coreutils-full}/bin/chown mythmon:users $@/$#
    '';
  };

  virtualisation.docker.autoPrune.flags = ["--all" "--filter" "label=prune=always"];
}
