{login, ...}: {
  # TODO Pipewire configuration is better in Nixos 24.05 https://nixos.wiki/wiki/PipeWire

  home-manager.users.${login}.home.file."pipewire-roland-bridge-cast" = {
    source = ./90-roland-bridge-cast.conf;
    target = ".config/pipewire/pipewire.conf.d/90-roland-bridge-cast.conf";
    onChange = "systemctl --user restart pipewire";
  };
}
