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
  ];

  # Debloat Gnome
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
   
  # Gnome
  services.displayManager.gdm.enable = true;

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
