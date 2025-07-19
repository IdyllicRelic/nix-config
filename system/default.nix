{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./nvidia.nix
    ./audio.nix
    ./network.nix
    ./packages.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_15; # Change to linuxPackages_cachyos after installation
  boot.kernelParams = [
    "quiet"
    "splash"
  ];

  # Enable zram
  zramSwap.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    home = "/home/seyrn";
    isNormalUser = true;
    description = "<ADD NAME>";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
    ];
  };
  programs.zsh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Setting Hostname
  networking.hostName = "nixos";

  system.stateVersion = "24.11";
}
