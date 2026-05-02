{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./nvidia.nix
    ./audio.nix
    ./network.nix
    ./packages.nix
    ./gnome.nix
  ];

  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  systemd.network.wait-online.enable = false;

  # Kernel
  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  boot.kernelPackages = pkgs.linuxPackages_6_19;
  boot.kernelParams = [
    "quiet"
    "splash"
  ];

  # Enable zram
  zramSwap.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # Environment/Locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_GB.UTF-8";
  };

  # User
  users.users.seyrn = {
    isNormalUser = true;
    description = "<ADD NAME>";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Automatic nvidia overclocking
  systemd.services.nvidia_oc = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "NVIDIA Overclocking Service";
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/nvidia_oc set --index 0 --freq-offset 180 --mem-offset 360";
      User = "root";
      Restart = "on-failure";
    };
  };

  # Setting Hostname
  networking.hostName = "nixos";

  system.stateVersion = "24.11";
}
