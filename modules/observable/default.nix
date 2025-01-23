{pkgs, ...}: {
  gnome.chatApp = "rambox.desktop";

  environment.systemPackages = with pkgs; [
    beekeeper-studio
    google-chrome
    rambox
    heroku
  ];

  networking.hosts = {
    "127.0.0.1" = [
      "api.observable.test"
      "avatars.test"
      "connector.test"
      "custom.test"
      "dispatch.observable.test"
      "events.observable.test"
      "job-manager.observable.test"
      "login.usercontent.test"
      "login.worker.test"
      "observable.test"
      "observablehq.observablecloud.test"
      "projects.test"
      "prompts.test"
      "usercontent.test"
      "worker.test"
      "ws.observable.test"
    ];
  };

  virtualisation.docker.autoPrune.flags = ["--all" "--filter" "label=prune=always"];
}
