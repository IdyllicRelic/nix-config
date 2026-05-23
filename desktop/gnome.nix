{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes

    gnome-console
    gnome-software
    nautilus
    adw-gtk3
  ];

  # Debloat Gnome
  services.gnome = {
    core-apps.enable = false;
    core-developer-tools.enable = false;
    games.enable = false;
  };
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  # Gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Dconf options
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          cursor-size = lib.gvariant.mkInt32 18;
          color-scheme = "prefer-dark";
          gtk-theme = "adw-gtk3";
          # font-name = "SUSE 11";
          # document-font-name = "SUSE 11";
          # monospace-font-name = "CaskaydiaCove Nerd Font 11";
        };
        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
        };
      };
    }
  ];
}
