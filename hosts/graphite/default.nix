{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.availableKernelModules = ["aesni_intel" "cryptd"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };
    tmp.useTmpfs = true;
  };

  networking = {
    hostName = "graphite";
    networkmanager.enable = true;
  };

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

  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };

  services = {
    fprintd.enable = true;

    libinput.touchpad = {
      naturalScrolling = true;
      clickMethod = "clickfinger";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    power-profiles-daemon.enable = true;

    printing.enable = true;

    thermald.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  powerManagement.powertop.enable = true;

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false; # disable PulseAudio

  # NOPASSWD for wheel
  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, use:
  # https://search.nixos.org
  environment.systemPackages = with pkgs; [efibootmgr vim wget keymapp];

  hardware.keyboard.zsa.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
