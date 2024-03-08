{pkgs, ...}: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true; # accessible via `nvidia-settings`.
  };

  environment.systemPackages = with pkgs; [glxinfo mesa-demos nvtop];
}
