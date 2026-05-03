{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    adw-gtk3
    alacritty
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.regreet = {
    enable = true;
    theme.name = "adw-gtk3";
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
  };

  services.upower.enable = true;

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
