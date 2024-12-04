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
      enable = true;
      finegrained = false;
    };
    open = false;
    nvidiaSettings = true; # accessible via `nvidia-settings`.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # https://forum.garudalinux.org/t/issues-with-nvidia-like-not-waking-up-after-suspending-or-other-issues-with-current-version-of-nvidias-drivers/39572
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
  '';

  environment.systemPackages = with pkgs; [glxinfo mesa-demos nvtopPackages.full];
}
