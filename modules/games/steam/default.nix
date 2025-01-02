{pkgs, ...}: {
  hardware.steam-hardware.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamescope.enable = true;

  environment.systemPackages = with pkgs; [
    steam-tui
    steamcmd
  ];
}
