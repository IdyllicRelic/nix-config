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
    nvidia_oc
    p7zip
    power-profiles-daemon
    starship
    unrar
    unzip
    zoxide
  ];

  programs.gamemode.enable = true;

  # Services
  services.flatpak.enable = true;
}
