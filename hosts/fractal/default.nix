{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    plymouth.enable = true;
    tmp.useTmpfs = true;
  };

  networking.hostName = "fractal";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pulseaudio.enable = false; # disable PulseAudio
  # Pipewire is our one true audio daemon
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # NOPASSWD for wheel
  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, use:
  # https://search.nixos.org
  environment.systemPackages = with pkgs; [efibootmgr vim wget keymapp btdu];

  hardware.keyboard.zsa.enable = true;

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
