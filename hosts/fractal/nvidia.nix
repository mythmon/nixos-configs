{
  pkgs,
  config,
  ...
}: {
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = false;
    nvidiaSettings = true; # accessible via `nvidia-settings`.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [glxinfo mesa-demos nvtopPackages.full];
}
