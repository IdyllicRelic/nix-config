{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    adw-gtk3
    alacritty
    nautilus
    cliphist
    wl-clipboard
  ];

  services.gvfs.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [ pkgs.sway-contrib.grimshot ];
    package = pkgs.swayfx;
  };
  programs.hyprlock.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    hyprlock.enableGnomeKeyring = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.swayfx}/bin/sway --unsupported-gpu";
        user = "seyrn";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet";
        user = "greeter";
      };
    };
  };

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          cursor-size = lib.gvariant.mkInt32 18;
          color-scheme = "prefer-dark";
          gtk-theme = "adw-gtk3";
        };
      };
    }
  ];

  services.upower.enable = true;

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
