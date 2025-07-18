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

  environment.gnome.excludePackages = with pkgs; [
    gnome-calendar
    gnome-music
    gnome-contacts
    gnome-clocks
    gnome-maps
    gnome-characters
    gnome-text-editor
    gnome-tour
    gnome-weather
    gnome-system-monitor
    gnome-logs
    gnome-calculator
    gnome-connections
    gnome-font-viewer
    geary
    decibels
    snapshot
    simple-scan
    totem
    baobab
    evince
    file-roller
    seahorse
    loupe
    yelp
    epiphany
  ];

  programs.gamemode.enable = true;

  # Gnome
  services.xserver.enable = false; # Disables X11
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Services
  services.flatpak.enable = true;
}
