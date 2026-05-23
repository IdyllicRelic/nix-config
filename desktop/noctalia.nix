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

  programs.hyprlock.enable = true;

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
      };
    }
  ];

  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    hyprlock.enableGnomeKeyring = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet";
        user = "greeter";
      };
    };
  };
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.udev.extraRules = ''
    KERNEL=="card*", SUBSYSTEM=="drm", ATTRS{vendor}=="0x10de", ATTRS{device}=="0x25ed", SYMLINK+="dri/by-name/dgpu"
    KERNEL=="card*", SUBSYSTEM=="drm", ATTRS{vendor}=="0x8086", ATTRS{device}=="0x468b", SYMLINK+="dri/by-name/igpu"
  '';
  services.upower.enable = true;

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
