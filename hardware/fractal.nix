{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
      luks.devices."luks-47f07638-6e83-47fc-93ea-d81530bb2df4".device = "/dev/disk/by-uuid/47f07638-6e83-47fc-93ea-d81530bb2df4";
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e878757a-6a1c-4fec-b471-7a9d5589a2a7";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/BF7D-25F6";
      fsType = "vfat";
    };

    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/AC6095B66095882A";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };

    "/mnt/data" = {
      device = "/dev/disk/by-uuid/9290145090143D63";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
