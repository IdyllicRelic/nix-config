{ lib, pkgs, ... }:
{
  # Gnome extensions
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes

    # Theme dependencies
    gtk-engine-murrine
    gnome-themes-extra
  ];

  # Debloat Gnome
  environment.gnome.excludePackages = with pkgs; [
    gnome-backgrounds
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-connections
    gnome-contacts
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

  # Gnome
  services.xserver.enable = false;    # Disables X11
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Dconf options
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; 
      settings = {
        "org/gnome/desktop/interface" = {
          cursor-size = lib.gvariant.mkInt32 18;
          text-scaling-factor = 1.1;
          color-scheme = "prefer-dark";
        };
        "org/gnome/mutter" = {
          experimental-features = [ "variable-refresh-rate" ];
        };
      };
    }
  ];
}
