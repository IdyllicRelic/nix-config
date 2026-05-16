{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./cachy-kernel.nix
    ./nvidia.nix
    ./network.nix
    ./packages.nix
    ./user.nix
  ];

  # Optimizations
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  systemd.network.wait-online.enable = false;

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Kernel
  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.kernelParams = [
    "quiet"
    "splash"
    "nowatchdog"
  ];

  # Enable zram
  zramSwap.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

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

  # Audio config
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Setting Hostname
  networking.hostName = "stratus";

  system.stateVersion = "24.11";
}
