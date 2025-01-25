{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    aria2
    lm_sensors
    unrar
    unzip
    gcc
    power-profiles-daemon
    kdePackages.qtstyleplugin-kvantum
    kdePackages.kate
    cascadia-code
  ];

  # KDE Plasma
  services.xserver.enable = false; # Disables X11
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  # Services
  services.flatpak.enable = true;
}
