{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes

    # nautilus
    # gnome-system-monitor
  ];

  # Debloat Gnome
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
  # environment.gnome.excludePackages = with pkgs; [
  #   gnome-backgrounds
  #   gnome-calendar
  #   gnome-characters
  #   gnome-clocks
  #   gnome-connections
  #   gnome-contacts
  #   gnome-calculator
  #   gnome-font-viewer
  #   gnome-logs
  #   gnome-maps
  #   gnome-music
  #   gnome-text-editor
  #   gnome-tour
  #   gnome-weather
  #   gnome-system-monitor
  #   baobab
  #   decibels
  #   epiphany
  #   evince
  #   file-roller
  #   geary
  #   loupe
  #   seahorse
  #   simple-scan
  #   snapshot
  #   totem
  #   yelp
  # ];

  # Gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # services.xserver.enable = false;    # Disables X11
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Dconf options
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; 
      settings = {
        "org/gnome/desktop/interface" = {
          cursor-size = lib.gvariant.mkInt32 18;
          color-scheme = "prefer-dark";
        };
      };
    }
  ];
}
