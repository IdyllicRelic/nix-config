{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    aria2
    lm_sensors
    unrar
    unzip
    gcc
    bat
    fzf
    zoxide
    starship
    power-profiles-daemon
    helix
  ];

  programs.gamemode.enable = true;

  # Gnome
  services.xserver.enable = false; # Disables X11
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Services
  services.flatpak.enable = true;
}
