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
    bat
    fzf
    zoxide
    power-profiles-daemon
    kdePackages.qtstyleplugin-kvantum
    kdePackages.kate
  ];

  fonts.packages = with pkgs; [
    cascadia-code
  ];

  programs.gamemode.enable = true;

  # KDE Plasma
  services.xserver.enable = false; # Disables X11
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  # Services
  services.flatpak.enable = true;
}
