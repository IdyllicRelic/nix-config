{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    aria2
    bat
    fzf
    gcc
    git
    helix
    lm_sensors
    p7zip
    power-profiles-daemon
    starship
    unrar
    unzip
    zoxide

    # Gnome Extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-backgrounds
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-connections
    gnome-calculator
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-text-editor
    gnome-tour
    gnome-weather
    gnome-system-monitor
    baobab
    decibels
    epiphany
    evince
    file-roller
    geary
    loupe
    seahorse
    simple-scan
    snapshot
    totem
    yelp
  ];

  programs.gamemode.enable = true;

  # Podman
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  hardware.nvidia-container-toolkit.enable;

  # Gnome
  services.xserver.enable = false; # Disables X11
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Services
  services.flatpak.enable = true;
}
