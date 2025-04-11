{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.availableKernelModules = ["aesni_intel" "cryptd"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
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
    auto-cpufreq = {
      enable = true;
      settings = {
        battery.governor = "powersave";
        charger.governor = "performance";
      };
    };

    fprintd.enable = true;

    fwupd = {
      enable = true;
      extraRemotes = ["lvfs-testing"];
      uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;

      # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
      package =
        (import (builtins.fetchTarball {
            url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
            sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
          }) {
            inherit (pkgs) system;
          })
        .fwupd;
    };

    libinput.touchpad = {
      naturalScrolling = true;
      clickMethod = "clickfinger";
    };

    power-profiles-daemon.enable = false;

    printing.enable = true;

    thermald.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  security.rtkit.enable = true;
  services.pulseaudio.enable = false; # disable PulseAudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # NOPASSWD for wheel
  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, use:
  # https://search.nixos.org
  environment.systemPackages = with pkgs; [
    efibootmgr
    fw-ectool
    keymapp
    vim
    wget
  ];

  hardware = {
    keyboard.zsa.enable = true;
    i2c.enable = true;
  };

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
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
